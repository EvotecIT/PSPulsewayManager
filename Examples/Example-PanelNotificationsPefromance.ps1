Clear-Host
Import-Module PSPulsewayManager -Force
Import-Module PSWriteColor

### Tests - Notifications Performance Page ###

Write-Color '[i] Get ', 'CPU usage below', ' settings' -Color Yellow, Green, Yellow
Get-PulsewayCPUBelow
Write-Color '[i] Get ', 'CPU usage above', ' settings' -Color Yellow, Green, Yellow
Get-PulsewayCPUAbove
Write-Color '[i] Get ', 'Memory', ' settings' -Color Yellow, Green, Yellow
Get-PulsewayMemoryLow
Write-Color '[i] Get ', 'Port Closed', ' settings' -Color Yellow, Green, Yellow
Get-PulsewayMonitoredPortClosed

Set-PulsewayCPUAbove -CPUUsagePercentage 25 -CPUUsageTimeInterval 20 -PrioritySendNotificationOnCPUUsage Elevated -SendNotificationOnCPUUsage Enabled -Verbose
Set-PulsewayCPUBelow -BelowCPUUsagePercentage 2 -BelowCPUUsageTimeInterval 20 -PrioritySendNotificationOnBelowCPUUsage Elevated -SendNotificationOnBelowCPUUsage Disabled -Verbose
Set-PulsewayMemoryLow -LowMemoryPercentage 10 -LowMemoryTimeInterval 15 -PrioritySendNotificationOnLowMemory Critical -SendNotificationOnLowMemory Enabled -Verbose
Set-PulsewayMonitoredPortClosed -PortInterval 2 -PrioritySendNotificationOnPortNotAccessible Critical -SendNotificationOnPortNotAccessible Enabled -Verbose
