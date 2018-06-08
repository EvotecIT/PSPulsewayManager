Clear-Host
Import-Module PSPulsewayManager -Force

### Tests - Account Page ###
Get-PulsewayMaintenanceMode
Set-PulsewayMaintenanceMode -Toggle $false -Verbose
Get-PulsewayMaintenanceMode
Get-PulsewayGroupName
Set-PulsewayGroupName -GroupName 'EVOTEC'
Get-PulsewayComputerName
Set-PulsewayComputerName -NewComputerName 'EVO1'