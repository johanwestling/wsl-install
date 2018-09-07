# Windows Subsystem for Linux (WSL) installer
Install Windows Subsystem for Linux + Distro in a single Powershell command.

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
