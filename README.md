### PSPulsewayManager

Following is an easy to use `Powershell module` to control some of Pulseway Manager functionality. While `Pulseway Manager` offers GUI for enterprise deployments configuring some things from GUI is time consuming and not always easy. Also with this module you can in theory have different rules set based on different times. While `Pulseway` doesn't offer you that option you could schedule PowerShell script that will have diffrent rules at night and different rules at day...

I will continue adding more functions when I will have requirement to do so for my needs. Otherwise... you can make request ;-)

####### Pulseway GET functions

```
CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Function        Get-PulsewayComputerName                           0.5        PSPulsewayManager
Function        Get-PulsewayCPUAbove                               0.5        PSPulsewayManager
Function        Get-PulsewayCPUBelow                               0.5        PSPulsewayManager
Function        Get-PulsewayGroupName                              0.5        PSPulsewayManager
Function        Get-PulsewayLocalDiskSpace                         0.5        PSPulsewayManager
Function        Get-PulsewayMaintenanceMode                        0.5        PSPulsewayManager
Function        Get-PulsewayMemoryLow                              0.5        PSPulsewayManager
Function        Get-PulsewayMonitoredPortClosed                    0.5        PSPulsewayManager
Function        Get-PulsewayMonitoredServices                      0.5        PSPulsewayManager
Function        Get-PulsewayStatus                                 0.5        PSPulsewayManager
```

####### Pulseway SET functions

```
Function        Set-PulsewayComputerName                           0.5        PSPulsewayManager
Function        Set-PulsewayCPUAbove                               0.5        PSPulsewayManager
Function        Set-PulsewayCPUBelow                               0.5        PSPulsewayManager
Function        Set-PulsewayGroupName                              0.5        PSPulsewayManager
Function        Set-PulsewayLocalDiskSpace                         0.5        PSPulsewayManager
Function        Set-PulsewayMaintenanceMode                        0.5        PSPulsewayManager
Function        Set-PulsewayMemoryLow                              0.5        PSPulsewayManager
Function        Set-PulsewayMonitoredPortClosed                    0.5        PSPulsewayManager
Function        Set-PulsewayMonitoredServices                      0.5        PSPulsewayManager
```
