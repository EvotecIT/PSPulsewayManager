function Get-PulsewayMonitoredServices {
    [cmdletbinding()]
    param(
        [string] $Computer = $Env:COMPUTERNAME
    )

    # PrioritySendNotificationOnServiceStop = priority
    # SendNotificationOnServiceStop 1/0

    $RegistryPath = 'HKLM:\SOFTWARE\MMSOFT Design\PC Monitor'
    $RegistryKey1 = 'SendNotificationOnServiceStop'
    $RegistryKey2 = 'PrioritySendNotificationOnServiceStop'

    $ReadRegistry = Get-RegistryRemote -Computer $Computer -RegistryPath $RegistryPath -RegistryKey $RegistryKey1, $RegistryKey2
    $NotificationEnabled = $ReadRegistry[0]
    $NotificationPriority = $ReadRegistry[1]

    $RegistryPathSub = 'HKLM:\SOFTWARE\MMSOFT Design\PC Monitor\Services'
    $RegistryKeySub1 = 'Count'
    $ReadRegistrySub = Get-RegistryRemote -Computer $Computer -RegistryPath $RegistryPathSub -RegistryKey $RegistryKeySub1
    $ServicesCount = $ReadRegistrySub


    $List = New-Object System.Collections.ArrayList
    $Services = Get-RegistryRemoteList -Computer $Computer -RegistryPath $RegistryPathSub
    for ($i = 0; $i -lt $Services.Count; $i++) {
        #$Id = "Id$i"
        #$Percentage = "Percentage$i"
        ##$Priority = "Priority$i"
        #$SizeMB = "SizeMB$i"
        $Service = "Service$i"

        $ServicesFromRegistry = @{
            Service = $Services.$Service
        }
        $List.Add($ServicesFromRegistry)  > $null
    }

    #$Value = $NotificationEnabled
    #$ValueConverted = $Value -As [NotificationStatus]
    #Write-verbose "Return VALUE: $NotificationEnabled After CONVERSION: $ValueConverted"

    $Return = [ordered] @{
        Name                = 'Services'
        ComputerName        = $Computer
        Count               = $ServicesCount
        NotificationType    = $NotificationType -As [NotificationType]
        NotificationEnabled = $NotificationEnabled -As [NotificationStatus]
        MonitoredServices   = $List
    }
    return $Return
}