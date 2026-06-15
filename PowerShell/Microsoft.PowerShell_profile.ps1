# Bendows Powershell

# light-theme readability tweaks for PSReadLine
# Applies only when Windows app theme is Light.
$appsUseLightTheme = $null
try {
    $appsUseLightTheme = Get-ItemPropertyValue -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize' -Name 'AppsUseLightTheme' -ErrorAction Stop
}
catch {
    $appsUseLightTheme = $null
}

if (
    $appsUseLightTheme -eq 1 -and
    (Get-Command Set-PSReadLineOption -ErrorAction SilentlyContinue)
) {
    Set-PSReadLineOption -Colors @{
        Command          = "$($PSStyle.Foreground.FromRgb(0x0E, 0x74, 0x10))"
        Default          = "$($PSStyle.Foreground.FromRgb(0x1E, 0x1E, 0x1E))"
        Member           = "$($PSStyle.Foreground.FromRgb(0x1E, 0x1E, 0x1E))"
        Type             = "$($PSStyle.Foreground.FromRgb(0x1E, 0x1E, 0x1E))"
        Parameter        = "$($PSStyle.Foreground.FromRgb(0x5E, 0x5E, 0x5E))"
        Operator         = "$($PSStyle.Foreground.FromRgb(0x5E, 0x5E, 0x5E))"
        InlinePrediction = "$($PSStyle.Foreground.FromRgb(0x7A, 0x7A, 0x7A))"
    }

    $PSStyle.FileInfo.Directory = "$($PSStyle.Foreground.FromRgb(0x0B, 0x63, 0x7F))"
}

# End accepts suggestion
Set-PSReadLineKeyHandler -Key End -ScriptBlock {
    param($key, $arg)
    [Microsoft.PowerShell.PSConsoleReadLine]::AcceptSuggestion($key, $arg)
    [Microsoft.PowerShell.PSConsoleReadLine]::EndOfLine($key, $arg)
}

# SCP Image content
function Copy-Image-To-Server {
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$Destination
    )

    $tempPath = Join-Path $env:TEMP ("clip_upload_{0}.png" -f [guid]::NewGuid().ToString('N'))
    $helperPath = Join-Path $env:TEMP ("copy-server-image_{0}.ps1" -f [guid]::NewGuid().ToString('N'))

    $saveClipboardImageScript = @'
param([string]$Path)

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

if (-not [System.Windows.Forms.Clipboard]::ContainsImage()) {
    exit 2
}

$image = [System.Windows.Forms.Clipboard]::GetImage()
if ($null -eq $image) {
    exit 2
}

try {
    $image.Save($Path, [System.Drawing.Imaging.ImageFormat]::Png)
    exit 0
}
finally {
    $image.Dispose()
}
'@

    try {
        Set-Content -LiteralPath $helperPath -Value $saveClipboardImageScript -Encoding UTF8
        & powershell.exe -NoProfile -Sta -ExecutionPolicy Bypass -File $helperPath $tempPath
        $saveExitCode = $LASTEXITCODE

        if ($saveExitCode -eq 2) {
            Write-Host "No image found in clipboard." -ForegroundColor Red
            return
        }

        if ($saveExitCode -ne 0 -or -not (Test-Path -LiteralPath $tempPath)) {
            Write-Host "Failed to read image from clipboard." -ForegroundColor Red
            return
        }

        scp $tempPath $Destination
        if ($LASTEXITCODE -eq 0) {
            Write-Host "Image successfully sent!" -ForegroundColor Green
        }
        else {
            Write-Host "scp failed." -ForegroundColor Red
        }
    }
    finally {
        Remove-Item -LiteralPath $helperPath, $tempPath -ErrorAction SilentlyContinue
    }
}

# Llama functions
function Start-Gemma {
    $llamaServer = Get-Command llama-server.exe -ErrorAction SilentlyContinue
    if (-not $llamaServer) {
        Write-Error 'llama-server.exe was not found in PATH.'
        return
    }

    & $llamaServer.Source `
        -hf 'ggml-org/gemma-4-26b-a4b-it-GGUF:Q4_K_M' `
        --jinja
}

# ssh completions
Register-ArgumentCompleter -Native -CommandName ssh, scp, sftp -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)

    $hosts = @()

    $sshConfig = "$HOME\.ssh\config"
    if (Test-Path $sshConfig) {
        $hosts += Get-Content $sshConfig |
        Where-Object { $_ -match '^\s*Host\s+(.+)$' } |
        ForEach-Object {
            $matches[1] -split '\s+'
        } |
        Where-Object { $_ -notmatch '[*?]' }
    }

    $knownHosts = "$HOME\.ssh\known_hosts"
    if (Test-Path $knownHosts) {
        $hosts += Get-Content $knownHosts |
        Where-Object { $_ -notmatch '^\|' } |
        ForEach-Object {
            ($_ -split '\s+')[0] -split ','
        } |
        ForEach-Object {
            $_ -replace '^\[|\].*$', ''
        }
    }

    $hosts |
    Sort-Object -Unique |
    Where-Object { $_ -like "$wordToComplete*" } |
    ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
    }
}