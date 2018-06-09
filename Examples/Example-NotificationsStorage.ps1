Clear-Host
Import-Module PSPulsewayManager -Force
Import-Module PSWriteColor

$Drives = Get-PulsewayLocalDiskSpace -Verbose
$Drives
$Drives.MonitoredDrives
