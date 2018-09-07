# Windows Subsystem for Linux (WSL) installer
Install Windows Subsystem for Linux + Distro in a single Powershell command.

## Usage
1. Press **WIN + Q**.
1. Enter **Powershell**.
1. Press **CTRL + SHIFT + ENTER**.
1. Change directory to desired location:
    ```
    cd C:\Users\WINUSR\DESIRED\PATH\
    ```
1. Download WSL installer Powershell script:
    ```
    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/johanwestling/wsl-installer/master/wsl-install.ps1" -OutFile ".\wsl-install.ps1" -UseBasicParsing
    ```
1. Run WSL installer Powershell script:
    ```
    .\wsl-install.ps1
    ```
    **Note!** Defaults to **Ubuntu 18.04**, see **Params** section for how to change that.

## Params
* **-Force** _(Switch, default: false)
    ```
    .\wsl-install.ps1 -Force
    ```
* **-DistroName** _(String, default: "ubuntu")_
    ```
    .\wsl-install.ps1 -DistroName="..."
    ```
* **-DistroPath** _(String, default: "C:\Program Files\WindowsApps")_
    ```
    .\wsl-install.ps1 -DistroPath="..."
    ```
* **-DistroCachePath** _(String, default: ".\cache")_
    ```
    .\wsl-install.ps1 -DistroCachePath="..."
    ```
* **-DistroVersion** _(String, default: "1804")_
    ```
    .\wsl-install.ps1 -DistroVersion="..."
    ```
* **-DistroAppx** _(String, default: "CanonicalGroupLimited.Ubuntu18.04onWindows")_
    ```
    .\wsl-install.ps1 -DistroAppx="..."
    ```
