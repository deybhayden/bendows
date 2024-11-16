# Installation Notes

Basic steps on setting up a new Windows machine.

- Create 512 GB Dev Drive at `D:\`
- Sign into Google in Microsoft Edge
- Review `bendows-install.ps1` and run each winget individually
- `wsl --install`
- reboot

## Git Bash Set up

```shell
# copy .bash_profile to home directory
# open git bash as an admin
cp .gitattributes_global .gitignore_global .gitconfig /c/Users/hayde/
```

### DNS

To prevent intermittent network errors on Windows, set up manual DNS on the PC. Cloudflare's Values are below (enable DNS over SSL)

```shell
# IPv4
1.1.1.1
1.0.0.1

# IPv6
2606:4700:4700::1111
2606:4700:4700::1001
```

## Add Explorer 'Open with Code'

Double click the `shell-vscode.reg` and `background-vscode.reg` files to add an option in Explorer to open a folder in VS Code.

## Debloater

Run [Win11Debloat](https://github.com/Raphire/Win11Debloat) with the default setup, then select the apps to uninstall.

### Applications to Keep

- `Clipchamp.Clipchamp`
- `MSTeams`
- `Microsoft.WindowsAlarms`
- `Microsoft.WindowsSoundRecorder`
