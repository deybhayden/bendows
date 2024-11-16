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
cp Repos/bendows/.gitconfig /c/Users/hayde/.gitconfig
ln -sf Repos/bendows/.bashrc /c/Users/hayde/.bashrc
```

## Installing NordLayer

NordLayer isn't available on winget, so go here: [Nordlayer Windows Download](https://nordlayer.com/download/windows/)

### DNS

To prevent intermittent network errors on Windows, set up manual DNS on the PC. Google's Values are below (enable DNS over SSL)

```shell
# IPv4
8.8.8.8
8.8.4.4

# IPv6
2001:4860:4860::8888
2001:4860:4860::8844
```

## Add Explorer 'Open with Code'

Double click the `shell-vscode.reg` and `background-vscode.reg` files to add an option in Explorer to open a folder in VS Code.
