Clear-Host
Import-Module PSPulsewayManager -Force
Import-Module PSManageService #-Force

Write-Color '[i] Get ', 'Services', ' settings' -Color Yellow, Green, Yellow
$Services = Get-PulsewayMonitoredServices
$Services
Write-Color '[i] Get ', 'Services', ' monitored' -Color Yellow, Green, Yellow
$Services.ServicesMonitored
Write-Color '[i] Get ', 'Services', ' excluded from monitoring' -Color Yellow, Green, Yellow
$Services.ServicesExcluded
Write-Color '[i] Get ', 'Services', ' controled (all)' -Color Yellow, Green, Yellow
$Services.ServicesControled

#$servicesToMonitor = Get-PSService -Computers 'EVO1'
#$servicesToMonitor = $servicesToMonitor | Where { $_.Status -eq 'Running' -and $_.StartType -eq 'Automatic' }
#$servicesToMonitor | ft -a

$MonitorServiceControlled = @('BITS', 'IISADMIN', 'Audiosrv')
$MonitorServiceNotification = @('IISADMIN')

Set-PulsewayMonitoredServices -Services $MonitorServiceControlled -servicesToMonitor $MonitorServiceNotification -SendNotificationOnServiceStop Enabled -PrioritySendNotificationOnServiceStop Low
