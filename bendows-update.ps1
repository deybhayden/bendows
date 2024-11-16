<#
# This is a script for upgrading a PC with winget
#>


try {
    if (Get-Command winget) {
        winget upgrade --all
    }
} catch {
    "winget is not available. Update AppInstaller in the AppStore before running again."
}