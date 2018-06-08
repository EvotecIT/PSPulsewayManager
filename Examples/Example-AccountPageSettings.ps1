Import-Module PSPulsewayManager -Force

Clear-Host

### Tests - Account Page ###
Get-PulsewayMaintenanceMode
Set-PulsewayMaintenanceMode -Toggle $false -Verbose
Get-PulsewayMaintenanceMode
Get-PulsewayGroupName
Set-PulsewayGroupName -GroupName 'EVOTEC'
Get-PulsewayComputerName
Set-PulsewayComputerName -NewComputerName 'EVO1'