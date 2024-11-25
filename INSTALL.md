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
