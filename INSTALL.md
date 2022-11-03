# Installation Notes

These are steps I recorded setting up a on a Dell XPS

Dell Warranty
Sign into Google in Microsoft Edge
Update App Installer (for winget)
winget search vscode
winget install vscode
open vscode, sign into GitHub for settings sync
winget install slack -s winget
plugin logitech mouse, install logi options
winget install Google.Chrome
wsl --install
reboot
winget install Zoom.Zoom
remap caps to control via keyboard
vscode add Cascadia Code in font family
vscode install WSL extension
running code inside of ubuntu will install code server
winget install Docker.DockerDesktop -s winget
winget install Figma.Figma -s winget

## Git Bash Set up

```shell
# copy .bash_profile to home directory
# open git bash as an admin
ln -sf Repos/bendows/.gitconfig /c/Users/hayde/.gitconfig
ln -sf Repos/bendows/.bashrc /c/Users/hayde/.bashrc
```
