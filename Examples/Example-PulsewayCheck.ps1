Clear-Host
Import-Module PSPulsewayManager -Force
Import-Module PSManageService -Force
Import-Module PSWriteColor

# built in but accepts only one...
Get-PulsewayStatus -Computer 'AD1'

# useful if you don't want to wait for results
$Computers = 'AD1', 'EVO1'
Get-PSService -Computers $Computers -Services 'Pulseway'