param(
  [string]$DistroPath = "C:\Program Files\WindowsApps",
  [string]$DistroCachePath = ".\",
  [string]$DistroName = "ubuntu",
  [string]$DistroVersion = "1804",
  [string]$DistroAppx = "CanonicalGroupLimited.Ubuntu18.04onWindows"
)

$DistroUrl = "https://aka.ms/wsl-$DistroName-$DistroVersion"
$DistroFilename = "$DistroCachePath\$DistroName-$DistroVersion.appx"

$OutputPrefix = "$([char]27)[92m>$([char]27)[0m"
$OutputForced = " (-Force)"

# Enable Hyper-V.
Write-Host "$OutputPrefix Enabling Hyper-V..."
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All

# Enable WSL.
Write-Host "$OutputPrefix Enabling Windows Susbsystem for Linux..."
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux

if((Test-Path "$DistroFilename" -PathType Leaf) -eq $True){
  Remove-Item "$DistroFilename"
}

if((Test-Path "$DistroFilename" -PathType Leaf) -eq $False){
  # Download WSL distrobution.
  Write-Host "$OutputPrefix Downloading $DistroName ($DistroVersion)..."
  Invoke-WebRequest -Uri "$DistroUrl" -OutFile "$DistroFilename" -UseBasicParsing
}

if((Test-Path "$DistroFilename" -PathType Leaf) -eq $True){
  # Install WSL distrobution.
  Write-Host "$OutputPrefix Installing $DistroName ($DistroVersion)..."
  Add-AppxPackage -Path "$DistroFilename"
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
