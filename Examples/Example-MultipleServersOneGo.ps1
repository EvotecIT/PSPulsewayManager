### Following Example shows a way to change multiple servers in one go according to specified rules.

#Install-Module PSPulsewayManager
#Install-Module PSManageService
Clear-Host
Import-Module PSPulsewayManager -Force
Import-Module PSManageService -Force

$MeasureTotal = [System.Diagnostics.Stopwatch]::StartNew() # Timer Start

$Exludes = '*-S-*', '*RD*', 'UAT*', 'PROD*', 'CLR-*', '*Clu1', '*s2d*', '*FileServer*'

$Servers = Get-ADComputer -Filter { OperatingSystem -like 'Windows Server*' } -Properties OperatingSystem | Select-Object Name, DNSHostName, OperatingSystem
foreach ($Exclude in $Exludes) {
    $Servers = $Servers | Where { $_.Name -notlike $Exclude }

}

$Servers = $Servers | Sort-Object Name
$Services = Get-PSService -Computers $Servers.Name -Services 'Pulseway' -maxRunspaces 200 -Verbose
$PulsewayUnavailable = $Services | Where { $_.Status -eq 'N/A' }
$PulsewayRunning = $Services | Where { $_.Status -eq 'Running' }

Write-Color 'Servers to process: ', $Servers.Count, ' servers running: ', $PulsewayRunning.Count, ' servers unavailable: ', $PulsewayUnavailable.Count  -Color White, Yellow, White, Yellow, White, Yellow
Write-Color 'Pulseway is running: ', $PulsewayRunning.Count -Color White, Green
$PulsewayRunning | Format-Table -AutoSize
Write-Color 'Pulseway is unavailable: ', $PulsewayUnavailable.Count -Color White, Red
$PulsewayUnavailable | Format-Table -AutoSize


foreach ($server in $PulsewayRunning.Computer) {
    Write-Color '[start]', ' Processing server: ', $Server, ' for ', 'CPU/Storage' -Color Green, White, Yellow, White, Yellow
    ### Change CPU 90% for 30 minutes for all servers, disable Below CPU
    Set-PulsewayCPUBelow -Computer $Server -SendNotificationOnBelowCPUUsage Disabled -BelowCPUUsagePercentage 10 -BelowCPUUsageTimeInterval 30 -PrioritySendNotificationOnBelowCPUUsage Normal #-Verbose
    Set-PulsewayCPUAbove -Computer $Server -SendNotificationOnCPUUsage Enabled -CPUUsagePercentage 90 -CPUUsageTimeInterval 30 -PrioritySendNotificationOnCPUUsage Critical #-Verbose
    ### Storage 20GB free - ELEVATED, Storage 10GB free - CRITICAL
    $ListDrives = @()
    $FindDrives = Get-Drive -Computer $server |  Where { [int] $_.SizeGB -gt 25 } #| Where { $_.VolumeName -ne 'Temporary Storage' -and $_.VolumeName -ne 'Bek Volume' }
    # Set the settings for all drives for particular computer/server (Elevated)
    $DrivesElevated = Set-DriveSettings -Drive $FindDrives -Percentage 10 -Priority Elevated -SizeMB 20000 -UsePercentage No
    # Repeat process for same drives but make it critical
    $DrivesCritical = Set-DriveSettings -Drive $FindDrives -Percentage 10 -Priority Critical -SizeMB 10000 -UsePercentage No
    $ListDrives += $DrivesElevated
    $ListDrives += $DrivesCritical
    Set-PulsewayLocalDiskSpace -Computer $Server -Drives $ListDrives -SendNotificationOnLowHDDSpace Enabled #-Verbose
    Write-Color '[stop ]', ' Processing server: ', $Server, ' for ', 'CPU/Storage' -Color Red, White, Yellow, White, Yellow

    if ($Server -like 'WEU-*' -or $Server -like 'NEU-*') {
        ### disable RAM Monitoring
        Write-Color '[start]', ' Processing server: ', $Server, ' for ', 'RAM disabling' -Color Green, White, Yellow, White, Gray
        Set-PulsewayMemoryLow -Computer $Server -LowMemoryPercentage 5 -LowMemoryTimeInterval 30 -PrioritySendNotificationOnLowMemory Low -SendNotificationOnLowMemory Disabled #-Verbose
        Write-Color '[stop ]', ' Processing server: ', $Server, ' for ', 'RAM disabling' -Color White, Yellow, White, Gray

    } elseif ($Server -like '-P-*' -and $Server -notlike '*HOST*') {
        ### disable RAM Monitoring
        Write-Color '[start]', ' Processing server: ', $Server, ' for ', 'RAM disabling' -Color Green, White, Yellow, White, Gray
        Set-PulsewayMemoryLow -Computer $Server -LowMemoryPercentage 5 -LowMemoryTimeInterval 30 -PrioritySendNotificationOnLowMemory Low -SendNotificationOnLowMemory Disabled #-Verbose
        Write-Color '[stop ]', ' Processing server: ', $Server, ' for ', 'RAM disabling' -Color Red, White, Yellow, White, Gray

    } elseif ($Server -like '*HOST*') {
        ### RAM - 5% for 30 minutes - CRITICAL
        Write-Color '[start]', ' Processing server: ', $Server, ' for ', 'RAM 5% in 30 minutes' -Color Green, White, Yellow, White, Red
        Set-PulsewayMemoryLow -Computer $Server -LowMemoryPercentage 5 -LowMemoryTimeInterval 30 -PrioritySendNotificationOnLowMemory Critical -SendNotificationOnLowMemory Enabled #-Verbose
        Write-Color '[stop ]', ' Processing server: ', $Server, ' for ', 'RAM 5% in 30 minutes' -Color Red, White, Yellow, White, Red
    } else {
        ### disable RAM Monitoring
        Write-Color '[start]', ' Processing server: ', $Server, ' for ', 'RAM disabling' -Color Green, White, Yellow, White, Gray
        Set-PulsewayMemoryLow -Computer $Server -LowMemoryPercentage 5 -LowMemoryTimeInterval 30 -PrioritySendNotificationOnLowMemory Low -SendNotificationOnLowMemory Disabled #-Verbose
        Write-Color '[stop ]', ' Processing server: ', $Server, ' for ', 'RAM disabling' -Color Red, White, Yellow, White, Gray
    }

    Write-Color '[i] ', 'Pulseway Settings for ', $Server -Color Yellow, White, Yellow
    $RamMonitoring = Get-PulsewayMemoryLow -Computer $Server #-Verbose
    Write-color '[i] ', 'Ram settings: ', 'NotificationEnabled ', $RamMonitoring.NotificationEnabled,
    ' NotificationType ', $RamMonitoring.NotificationType, ' TimeInterval ', $RamMonitoring.TimeInterval,
    ' Percentage ', $RamMonitoring.Percentage -Color Yellow, White, Yellow, Gray, Yellow, Gray, Yellow, Gray, Yellow, Gray
    $CpuBelow = Get-PulsewayCPUBelow -Computer $Server
    Write-color '[i] ', 'CPU Below settings: ', 'NotificationEnabled ', $CpuBelow.NotificationEnabled,
    ' NotificationType ', $CpuBelow.NotificationType, ' TimeInterval ', $CpuBelow.TimeInterval,
    ' Percentage ', $CpuBelow.Percentage  -Color Yellow, White, Yellow, Gray, Yellow, Gray, Yellow, Gray, Yellow, Gray
    $CpuAbove = Get-PulsewayCPUAbove -Computer $Server
    Write-color '[i] ', 'CPU Above settings: ', 'NotificationEnabled ', $CpuAbove.NotificationEnabled,
    ' NotificationType ', $CpuAbove.NotificationType, ' TimeInterval ', $CpuAbove.TimeInterval,
    ' Percentage ', $CpuAbove.Percentage  -Color Yellow, White, Yellow, Gray, Yellow, Gray, Yellow, Gray, Yellow, Gray
    $MonitoredDrives = Get-PulsewayLocalDiskSpace -Computer $server
    Write-color '[i] ', 'Drive Monitoring Count: ', $MonitoredDrives.MonitoredDrivesCount, ' NotificationEnabled ', $MonitoredDrives.NotificationEnabled -Color Yellow, White, Gray, Yellow, Gray
    foreach ($Drive in $MonitoredDrives.MonitoredDrives) {
        Write-color '[**] ', 'Drive settings: ', 'Percentage ', $Drive.Percentage,
        ' ID ', $Drive.ID, ' UsePercentage ', $Drive.UsePercentage,
        ' SizeMB ', $Drive.SizeMB  -Color Yellow, White, Yellow, Gray, Yellow, Gray, Yellow, Gray, Yellow, Gray
    }
}

$MeasureTotal.Stop()
Write-Color 'Time to process: ', "$($measureTotal.Elapsed)" -Color White, Yellow