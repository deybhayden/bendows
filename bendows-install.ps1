<#
# This is a script for setting up a PC with winget
#>


try {
    if (Get-Command winget) {
        Write-Output "Installing core packages via winget"
        winget install Google.Chrome -s winget
        winget install Google.GoogleDrive -s winget
        winget install Microsoft.VisualStudioCode -s winget
        winget install Microsoft.Powershell -s winget
        winget install Microsoft.PowerToys -s winget
        winget install OpenJS.NodeJS.LTS -s winget
        winget install BurntSushi.ripgrep.GNU -s winget
        winget install SlackTechnologies.Slack -s winget
        winget install Discord.Discord -s winget
        winget install Zoom.Zoom -s winget
        winget install Logitech.OptionsPlus -s winget
        winget install Logitech.GHUB -s winget
        winget install Docker.DockerDesktop -s winget
        winget install direnv.direnv -s winget
        winget install Git.Git -s winget
        winget install GitHub.cli -s winget
        winget install Piriform.CCleaner -s winget
        winget install Postman.Postman -s winget
        winget install Wireguard.Wireguard -s winget
        winget install beekeeper-studio.beekeeper-studio -s winget
        winget install MongoDB.Compass.Full -s winget
        winget install MongoDB.Shell -s winget
        winget install Putty.Putty -s winget
        winget install Microsoft.DotNet.SDK.6 -s winget
        winget install "Visual Studio Community 2022"  --override "--add Microsoft.VisualStudio.Workload.ManagedDesktop Microsoft.VisualStudio.ComponentGroup.WindowsAppSDK.Cs" -s msstore
        winget install Thales.SafeNetAuthenticationClient -s winget
        winget install Amazon.AWSCLI -s winget
        winget install Hashicorp.Terraform -s winget
        winget install WinSCP.WinSCP -s winget
        winget install dotPDN.PaintDotNet -s winget
        winget install OBSProject.OBSStudio -s winget

        Write-Output "Installing WSL, reboot will be required"
        wsl --install
    }
}
catch {
    "winget is not available. Update AppInstaller in the AppStore before running again."
}