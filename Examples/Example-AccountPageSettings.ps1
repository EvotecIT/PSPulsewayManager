Clear-Host
Import-Module PSPulsewayManager -Force

### Tests - Account Page ###
Get-PulsewayMaintenanceMode
Set-PulsewayMaintenanceMode -Toggle $false -Verbose
Get-PulsewayGroupName
Set-PulsewayGroupName -GroupName 'EVOTEC' -Verbose
Get-PulsewayComputerName
Set-PulsewayComputerName -NewComputerName 'EVO1' -Verbose