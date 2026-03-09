# WSL & Docker

Docker Desktop uses WSL2 and we set up WSL2 for Ubuntu in this repo.

## Disk Space Management

VHDX files (more about these files and storage mgmt [here](https://learn.microsoft.com/en-us/windows/wsl/disk-space)) grow indefinitely and can end up eating a lot of disk space - even when you purge the docker images/containers (see [thread](https://github.com/docker/for-win/issues/244)).

1. Use the `Disk Usage` Docker Desktop extension and remove all images/containers (as much as you want to clean out)
2. Then use an Admin powershell to Optimize the VHDX size:

```powershell
PS C:\Users\hayde> cd "C:\Users\hayde\AppData\Local\Docker\wsl\disk"
PS C:\Users\hayde\AppData\Local\Docker\wsl\disk> ls

    Directory: C:\Users\hayde\AppData\Local\Docker\wsl\disk

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a---           3/26/2026  7:57 AM   479419432960 docker_data.vhdx

PS C:\Users\hayde\AppData\Local\Docker\wsl\disk> Optimize-VHD .\docker_data.vhdx -Mode Full
PS C:\Users\hayde\AppData\Local\Docker\wsl\disk> ls

    Directory: C:\Users\hayde\AppData\Local\Docker\wsl\disk

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a---           3/26/2026  8:03 AM    36562796544 docker_data.vhdx
```

The above example resized a ~450 GB vhdx to ~35 GB.
