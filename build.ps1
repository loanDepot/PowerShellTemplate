#requires -Module InvokeBuild
#.SYNOPSIS
# This script only exists to help you with discovery.
# Normally you should just call Invoke-Build
[CmdletBinding()]
param(
    # The Task to build is, by default, the first task defined in the .build.ps1 file
    [string[]]$Task,

    [switch]$Clean
)
$InformationPreference = "Continue"

$Error.Clear()

Write-Information 'Invoking build...'
Invoke-Build @PSBoundParameters -Result Result

if ($Result.Error) {
    $Error[-1].ScriptStackTrace | Out-String
    exit 1
}

exit 0
