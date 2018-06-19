Clear-Host
Import-Module PSPulsewayManager -Force
Import-Module PSManageService #-Force

Write-Color '[i] Get ', 'Services', ' settings' -Color Yellow, Green, Yellow
$Services = Get-PulsewayMonitoredServices
$Services
Write-Color '[i] Get ', 'Services', ' monitored' -Color Yellow, Green, Yellow
$Services.MonitoredServices