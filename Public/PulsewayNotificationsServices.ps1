function Get-PulsewayMonitoredServices {
    [cmdletbinding()]
    param(
        [string] $Computer = $Env:COMPUTERNAME
    )
    $RegistryPath = 'HKLM:\SOFTWARE\MMSOFT Design\PC Monitor'
    $RegistryKey1 = 'SendNotificationOnServiceStop'
    $RegistryKey2 = 'PrioritySendNotificationOnServiceStop'

    $RegistryPathSub1 = 'HKLM:\SOFTWARE\MMSOFT Design\PC Monitor\Services'
    $RegistryKeySub1 = 'Count'

    $RegistryPathSub2 = 'HKLM:\SOFTWARE\MMSOFT Design\PC Monitor\ServicesExcludedFromNotifications'
    $RegistryKeySub2 = 'Count'

    $ReadRegistry = Get-RegistryRemote -Computer $Computer -RegistryPath $RegistryPath -RegistryKey $RegistryKey1, $RegistryKey2
    $NotificationEnabled = $ReadRegistry[0]
    $NotificationType = $ReadRegistry[1]

    $ReadRegistrySub1 = Get-RegistryRemote -Computer $Computer -RegistryPath $RegistryPathSub1 -RegistryKey $RegistryKeySub1
    $ServicesCount = $ReadRegistrySub1

    $ReadRegistrySub2 = Get-RegistryRemote -Computer $Computer -RegistryPath $RegistryPathSub2 -RegistryKey $RegistryKeySub2
    $ServicesExcludedCount = $ReadRegistrySub2

    $ListControlled = New-Object System.Collections.ArrayList

    $Services = Get-RegistryRemoteList -Computer $Computer -RegistryPath $RegistryPathSub1
    for ($i = 0; $i -lt $Services.Count; $i++) {
        $Service = "Service$i"
        $ListControlled.Add($Services.$Service)  > $null
    }

    $ListExcluded = New-Object System.Collections.ArrayList
    $Services = Get-RegistryRemoteList -Computer $Computer -RegistryPath $RegistryPathSub2
    for ($i = 0; $i -lt $Services.Count; $i++) {
        $Service = "Service$i"
        $ListExcluded.Add($Services.$Service)  > $null
    }

    $ListMonitored = Compare-Object -ReferenceObject $ListControlled -DifferenceObject $ListExcluded -PassThru

    $Return = [ordered] @{
        Name                    = 'Services'
        ComputerName            = $Computer
        CountServicesControlled = $ServicesCount
        CountServicesExcluded   = $ServicesExcludedCount
        CountServicesMonitored  = $ListMonitored.Count
        NotificationType        = $NotificationType -As [NotificationType]
        NotificationEnabled     = $NotificationEnabled -As [NotificationStatus]
        ServicesControled       = $ListControlled
        ServicesExcluded        = $ListExcluded
        ServicesMonitored       = $ListMonitored
    }
    return $Return
}

function Set-PulsewayMonitoredServices {
    [cmdletbinding()]
    param(
        [string] $Computer = $Env:COMPUTERNAME,
        [array] $Services,
        [array] $ServicesToMonitor,
        [NotificationStatus] $SendNotificationOnServiceStop,
        [NotificationType] $PrioritySendNotificationOnServiceStop,
        [parameter(Mandatory = $False)][Switch]$PassThru
    )
    Write-Verbose 'Set-PulsewayMonitoredServices - GetType: '

    $RegistryPath = 'HKLM:\SOFTWARE\MMSOFT Design\PC Monitor'
    $RegistryKey1 = 'SendNotificationOnServiceStop'
    $RegistryKey2 = 'PrioritySendNotificationOnServiceStop'

    $RegistryPathSub1 = 'HKLM:\SOFTWARE\MMSOFT Design\PC Monitor\Services'
    $RegistryKeySub1 = 'Count'

    $RegistryPathSub2 = 'HKLM:\SOFTWARE\MMSOFT Design\PC Monitor\ServicesExcludedFromNotifications'
    $RegistryKeySub2 = 'Count'

    $Count = Get-ObjectCount $Services

    $ServicesExcluded = Compare-Object -ReferenceObject $Services -DifferenceObject $ServicesToMonitor -PassThru
    $CountExcluded = Get-ObjectCount $ServicesExcluded

    # Enable/disable notification
    Set-RegistryRemote -Computer $Computer -RegistryPath $RegistryPath `
        -RegistryKey $RegistryKey1, $RegistryKey2 `
        -Value ($SendNotificationOnServiceStop -As [int]), ($PrioritySendNotificationOnServiceStop -As [Int]) `
        -PassThru:$PassThru

    # Count number of services
    Set-RegistryRemote -Computer $Computer -RegistryPath $RegistryPathSub1 `
        -RegistryKey $RegistryKeySub1 `
        -Value $Count -PassThru:$PassThru
    # Count number of services excluded
    Set-RegistryRemote -Computer $Computer -RegistryPath $RegistryPathSub2 `
        -RegistryKey $RegistryKeySub2 `
        -Value $CountExcluded -PassThru:$PassThru

    $ListServicesNameA = @()
    for ($i = 0; $i -le $Services.Count; $i++) {
        $ListServicesNameA += "Service$i"
    }
    $ListServicesNameB = @()
    for ($i = 0; $i -le $ServicesExcluded.Count; $i++) {
        $ListServicesNameB += "Service$i"
    }

    Set-RegistryRemote -Computer $Computer -RegistryPath $RegistryPathSub1 `
        -RegistryKey $ListServicesNameA `
        -Value $Services `
        -PassThru:$PassThru

    Set-RegistryRemote -Computer $Computer -RegistryPath $RegistryPathSub2 `
        -RegistryKey $ListServicesNameB `
        -Value $ServicesExcluded `
        -PassThru:$PassThru

}