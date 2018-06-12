Clear-Host
Import-Module PSPulsewayManager -Force
Import-Module PSWriteColor

$Computer = 'AD1'

Write-Color 'Get ', 'Low Disk Space' -Color White, Yellow
$Drives = Get-PulsewayLocalDiskSpace -Computer $Computer -Verbose
$Drives
Write-Color 'List ', ' drives separatly' -Color White, Yellow -LinesAfter 1
$Drives.MonitoredDrives

## Find all drives for computer/server
$FindDrives = Get-Drive -Computer $Computer
$FindDrives
$ListDrives = @()
# Set the settings for all drives for particular computer/server (Elevated)
$DrivesElevated = Set-DriveSettings -Drive $FindDrives -Percentage 10 -Priority Elevated -SizeMB 20000 -UsePercentage No
# Repeat process for same drives but make it critical
$DrivesCritical = Set-DriveSettings -Drive $FindDrives -Percentage 10 -Priority Critical -SizeMB 10000 -UsePercentage No

$ListDrives += $DrivesElevated
$ListDrives += $DrivesCritical

#Set-PulsewayLocalDiskSpace -Computer $Computer -Drives $ListDrives -SendNotificationOnLowHDDSpace Enabled -Verbose