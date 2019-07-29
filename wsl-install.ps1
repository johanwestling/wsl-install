param(
  [string]$DistroPath = "C:\Program Files\WindowsApps",
  [string]$DistroCachePath = ".\",
  [string]$DistroName = "ubuntu",
  [string]$DistroVersion = "1804",
  [string]$DistroAppx = "CanonicalGroupLimited.Ubuntu18.04onWindows",
  [switch]$Force = $False
)

$OutputPrefix = "$([char]27)[92m→$([char]27)[0m"
$OutputForced = " (-Force)"

# Enable Hyper-V.
Write-Host "$OutputPrefix Enabling Hyper-V..."
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All

# Enable WSL.
Write-Host "$OutputPrefix Enabling Windows Susbsystem for Linux..."
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux

if(((Test-Path "$DistroCachePath\$DistroName-$DistroVersion.appx" -PathType Leaf) -eq $False) -or ($Force -eq $True)){
  # Download WSL distrobution.
  Write-Host "$OutputPrefix Downloading $DistroName ($DistroVersion)..." -NoNewLine
  if($Force -eq $True){
    Write-Host "$OutputForced" -ForegroundColor Yellow
  } else {
    Write-Host ""
  }
  Invoke-WebRequest -Uri "https://aka.ms/wsl-$DistroName-$DistroVersion" -OutFile "$DistroCachePath\$DistroName-$DistroVersion.appx" -UseBasicParsing
}

if((Test-Path "$DistroCachePath\$DistroName-$DistroVersion.appx" -PathType Leaf) -eq $True){
  # Install WSL distrobution.
  Write-Host "$OutputPrefix Installing $DistroName ($DistroVersion)..."
  Add-AppxPackage -Path "$DistroCachePath\$DistroName-$DistroVersion.appx"
}

# Check if WSL distrobution is installed.
$DistroPackage = $(Get-AppxPackage -Name "$DistroAppx" | Select-String -Pattern '.*')

if($DistroPackage){
  # Configure WSL distrobution.
  Write-Host "$OutputPrefix Configuring $DistroName ($DistroVersion)..."
  Invoke-Expression "& '$DistroPath\$DistroPackage\$DistroName$DistroVersion.exe' install --root"

  Write-Host "$OutputPrefix Lauching $DistroName ($DistroVersion)..."
  Start-Process "$DistroPath\$DistroPackage\$DistroName$DistroVersion.exe"

  exit
}
