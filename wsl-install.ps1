param(
  [string]$DistroPath = $("C:\Program Files\WindowsApps"),
  [string]$DistroCachePath = $(".\cache"),
  [string]$DistroName = $("ubuntu"),
  [string]$DistroVersion = $("1804"),
  [string]$DistroAppx = $("CanonicalGroupLimited.Ubuntu18.04onWindows"),
  [switch]$Force = $False
)

$OutputPrefix=">> "
$OutputForced=" (-Force)"

# Enable Windows Subsystem for Linux (WSL) in Windows features (reboot prompt if not already enabled).
Write-Host "$OutputPrefix" -NoNewline -ForegroundColor Green
Write-Host "Enabling Windows Susbsystem for Linux..."
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux

if(((Test-Path "$DistroCachePath\$DistroName-$DistroVersion.appx" -PathType Leaf) -eq $False) -or ($Force -eq $True)){
  # Download WSL distrobution.
  Write-Host "$OutputPrefix" -NoNewline -ForegroundColor Green
  Write-Host "Downloading $DistroName ($DistroVersion)..." -NoNewline
  if($Force -eq $True){
    Write-Host "$OutputForced" -ForegroundColor Yellow
  } else {
    Write-Host ""
  }
  Invoke-WebRequest -Uri "https://aka.ms/wsl-$DistroName-$DistroVersion" -OutFile "$DistroCachePath\$DistroName-$DistroVersion.appx" -UseBasicParsing
}

if((Test-Path "$DistroCachePath\$DistroName-$DistroVersion.appx" -PathType Leaf) -eq $True){
  # Install WSL distrobution.
  Write-Host "$OutputPrefix" -NoNewline -ForegroundColor Green
  Write-Host "Installing $DistroName ($DistroVersion)..."
  Add-AppxPackage -Path "$DistroCachePath\$DistroName-$DistroVersion.appx"
}

# Check if WSL distrobution is installed.
$DistroPackage = $(Get-AppxPackage -Name "$DistroAppx" | Select-String -Pattern '.*')

if($DistroPackage){
  # Configure WSL distrobution.
  Write-Host "$OutputPrefix" -NoNewline -ForegroundColor Green
  Write-Host "Configuring $DistroName ($DistroVersion)..."
  Invoke-Expression "& '$DistroPath\$DistroPackage\$DistroName$DistroVersion.exe' install --root"
  Invoke-Expression "& '$DistroPath\$DistroPackage\$DistroName$DistroVersion.exe'"
}
