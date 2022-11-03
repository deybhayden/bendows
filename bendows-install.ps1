<#
# This is a script for setting up a PC with winget
#>


try {
    if (Get-Command winget) {
        Write-Output "Installing core packages via winget"
        winget install Microsoft.VSCode -s winget
        winget install SlackTechnologies.Slack -s winget
        winget install Zoom.Zoom -s winget
        winget install Logitech.OptionsPlus -s winget
        winget install Google.Chrome -s winget
        winget install Docker.DockerDesktop -s winget
        winget install Git.Git -s winget
        winget install Figma.Figma -s winget

        Write-Output "Installing WSL, reboot will be required"
        wsl --install
    }
} catch {
    "winget is not available. Update AppInstaller in the AppStore before running again."
}

