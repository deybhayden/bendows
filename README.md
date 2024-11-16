# Bendows

This is a set of install notes and scripts for setting up Windows 11 with VS Code, Git, etc with [winget](https://github.com/microsoft/winget-cli).

- [INSTALL](./INSTALL.md)
- [bendows-install.ps1](./bendows-install.ps1)

If you want some PowerShell functions and utilities check out [PSBendows](https://github.com/deybhayden/PSBendows).

## Usage

```powershell
# installing
> powershell -ExecutionPolicy ByPass -F .\bendows-install.ps1
# updating
> powershell -ExecutionPolicy ByPass -F .\bendows-update.ps1
```
