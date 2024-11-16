#!/usr/bin/env node

import { spawn, execSync } from "node:child_process";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";
import { existsSync, mkdirSync, cpSync } from "node:fs";

const useProfile = process.argv[2] === "--profile";

if (process.argv[2] && process.argv[2] !== "--profile") {
  console.log("Usage: start.ts [--profile]");
  console.log("\nOptions:");
  console.log(
    "  --profile  Copy your default Chrome profile (cookies, logins)",
  );
  console.log("\nExamples:");
  console.log("  start.ts            # Start with fresh profile");
  console.log("  start.ts --profile  # Start with your Chrome profile");
  process.exit(1);
}

// Detect if running on native Windows or WSL2
const isWindows = process.platform === "win32";

// Get Windows username
function getWindowsUsername() {
  try {
    if (isWindows) {
      return process.env.USERNAME || process.env.USER;
    }
    return execSync("cmd.exe /c echo %USERNAME%", { encoding: "utf8" }).trim();
  } catch {
    throw new Error("Failed to get Windows username");
  }
}

const winUser = getWindowsUsername();

let chromePath, winProfilePath, scrapingProfileWin;

if (isWindows) {
  // Native Windows paths
  chromePath = `C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe`;
  winProfilePath = `C:\\Users\\${winUser}\\AppData\\Local\\Google\\Chrome\\User Data`;
  scrapingProfileWin = `C:\\Users\\${winUser}\\AppData\\Local\\Google\\Chrome\\ScrapingProfile`;
} else {
  // WSL2 paths
  chromePath = "/mnt/c/Program Files/Google/Chrome/Application/chrome.exe";
  winProfilePath = `/mnt/c/Users/${winUser}/AppData/Local/Google/Chrome/User Data`;
  scrapingProfileWin = `C:\\Users\\${winUser}\\AppData\\Local\\Google\\Chrome\\ScrapingProfile`;
}

// Kill only Chrome instances running on the debug port (9222)
async function killDebugChrome() {
  try {
    // Check if there's a Chrome on the debug port
    const response = await fetch("http://localhost:9222/json/version");
    if (response.ok) {
      // Get the process ID from the Chrome DevTools Protocol
      const versionInfo = await response.json();
      // The webSocketDebuggerUrl contains info but we need to find the PID differently
      // Use netstat to find the process using port 9222
      try {
        if (isWindows) {
          const netstatOutput = execSync('netstat -ano | findstr ":9222.*LISTENING"', { encoding: "utf8" });
          const match = netstatOutput.match(/LISTENING\s+(\d+)/);
          if (match) {
            const pid = match[1];
            execSync(`taskkill /F /PID ${pid} 2>nul`, { stdio: "ignore" });
          }
        } else {
          const netstatOutput = execSync('netstat.exe -ano | grep ":9222.*LISTENING"', { encoding: "utf8" });
          const match = netstatOutput.match(/LISTENING\s+(\d+)/);
          if (match) {
            const pid = match[1];
            execSync(`taskkill.exe /F /PID ${pid} 2>/dev/null`, { stdio: "ignore" });
          }
        }
      } catch {}
    }
  } catch {
    // No Chrome on debug port, nothing to kill
  }
}

await killDebugChrome();

// Wait a bit for processes to fully die
await new Promise((r) => setTimeout(r, 1000));

// Setup profile directory
if (isWindows) {
  if (!existsSync(scrapingProfileWin)) {
    mkdirSync(scrapingProfileWin, { recursive: true });
  }
} else {
  const scrapingProfileWsl = `/mnt/c/Users/${winUser}/AppData/Local/Google/Chrome/ScrapingProfile`;
  execSync(`mkdir -p "${scrapingProfileWsl}"`, { stdio: "ignore" });
}

if (useProfile) {
  if (isWindows) {
    // Copy profile on Windows
    cpSync(winProfilePath, scrapingProfileWin, { recursive: true, force: true });
  } else {
    // Sync profile with rsync on WSL2
    const scrapingProfileWsl = `/mnt/c/Users/${winUser}/AppData/Local/Google/Chrome/ScrapingProfile`;
    execSync(
      `rsync -a --delete "${winProfilePath}/" "${scrapingProfileWsl}/"`,
      { stdio: "pipe" },
    );
  }
}

// Start Chrome in background (detached so Node can exit)
// Use Windows path format for --user-data-dir since it's a Windows executable
spawn(
  chromePath,
  [
    "--remote-debugging-port=9222",
    `--user-data-dir=${scrapingProfileWin}`,
    "--profile-directory=Default",
    "--disable-search-engine-choice-screen",
    "--no-first-run",
    "--disable-features=ProfilePicker",
  ],
  { detached: true, stdio: "ignore" },
).unref();

// Wait for Chrome to be ready by checking the debugging endpoint
let connected = false;
for (let i = 0; i < 30; i++) {
  try {
    const response = await fetch("http://localhost:9222/json/version");
    if (response.ok) {
      connected = true;
      break;
    }
  } catch {
    await new Promise((r) => setTimeout(r, 500));
  }
}

if (!connected) {
  console.error("✗ Failed to connect to Chrome");
  process.exit(1);
}

// Start background watcher for logs/network (detached)
const scriptDir = dirname(fileURLToPath(import.meta.url));
const watcherPath = join(scriptDir, "watch.js");
spawn(process.execPath, [watcherPath], { detached: true, stdio: "ignore" }).unref();

console.log(
  `✓ Chrome started on :9222${useProfile ? " with your profile" : ""}`,
);
