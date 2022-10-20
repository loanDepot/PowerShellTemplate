#.SYNOPSIS
# This script exists to help you install build-time dependencies the first time
[CmdletBinding()]
param()
$InformationPreference = "Continue"

Push-Location $PSScriptRoot

# If Invoke-Build is available, use the more complete InstallBuildDependencies
if (Get-Command Invoke-Build) {
    Invoke-Build InstallBuildDependencies
} else {
    # Otherwise, install it from the PSGallery
    Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
    # In case you call this from a hosted build agent ...
    $Script = Install-Script Install-RequiredModule -NoPathUpdate -Force -Passthru
    & (Join-Path $Script.InstalledLocation "Install-RequiredModule.ps1") (Join-Path $PSScriptRoot "RequiredModules.psd1")
}
