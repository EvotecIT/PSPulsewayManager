Clear-Host
Import-Module PSPulsewayManager -Force
Import-Module PSManageService -Force
Import-Module PSWriteColor

Get-PulsewayStatus -Computer 'AD1'