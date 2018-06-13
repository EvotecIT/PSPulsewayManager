Clear-Host
Import-Module PSPulsewayManager -Force

### Tests - Account Page ###
Get-PulsewayMaintenanceMode
Set-PulsewayMaintenanceMode -Toggle $false -Verbose
Get-PulsewayGroupName
Set-PulsewayGroupName -GroupName 'EVOTEC' -Verbose
Get-PulsewayComputerName
Set-PulsewayComputerName -NewComputerName 'EVO1' -Verbose

### Set settings remotly...

$Computer = 'AD1'
Get-PulsewayMaintenanceMode -Computer $Computer
Set-PulsewayMaintenanceMode -Computer $Computer -Toggle $false -Verbose
Get-PulsewayGroupName -Computer $Computer
Set-PulsewayGroupName -Computer $Computer -GroupName 'EVOTEC' -Verbose
Get-PulsewayComputerName -Computer $Computer
Set-PulsewayComputerName -Computer $Computer -NewComputerName 'AD1' -Verbose