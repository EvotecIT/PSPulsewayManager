Enum NotificationStatus {
    Enabled = 1
    Disabled = 0
}

Enum NotificationType {
    <#
        Accessing
        [NotificationType] $Day = [NotificationType]::Critical
        1 -As [NotificationType]
    #>
    Critical = 3
    Elevated = 2
    Normal = 1
    Low = 0
}

function Get-PulsewayCPUBelow {
    [cmdletbinding()]
    param(
        [string] $Computer = $Env:COMPUTERNAME
    )
    $RegistryPath = 'HKLM:\SOFTWARE\MMSOFT Design\PC Monitor'
    $RegistryKey1 = 'BelowCPUUsagePercentage' # 1 to 99
    $RegistryKey2 = 'BelowCPUUsageTimeInterval' # 1 to 120
    $RegistryKey3 = 'PrioritySendNotificationOnBelowCPUUsage'
    # Critical = 3 , # Elevated = 2, # Normal = 1, # Low = 0
    $RegistryKey4 = 'SendNotificationOnBelowCPUUsage' # 1 or 0

    $Percentage = Get-RegistryRemotely -Computer $Computer -RegistryPath $RegistryPath -RegistryKey $RegistryKey1
    $TimeInterval = Get-RegistryRemotely -Computer $Computer -RegistryPath $RegistryPath -RegistryKey $RegistryKey2
    $NotificationType = Get-RegistryRemotely -Computer $Computer -RegistryPath $RegistryPath -RegistryKey $RegistryKey3
    $NotificationEnabled = Get-RegistryRemotely -Computer $Computer -RegistryPath $RegistryPath -RegistryKey $RegistryKey4

    $Return = [ordered]  @{
        Name                = 'CPU Below'
        Percentage          = $Percentage
        TimeInterval        = $TimeInterval
        NotificationType    = $NotificationType -As [NotificationType]
        NotificationEnabled = $NotificationEnabled -As [NotificationStatus]
    }
    return $Return
}

function Get-PulsewayCPUAbove {
    [cmdletbinding()]
    param(
        [string] $Computer = $Env:COMPUTERNAME
    )
    $RegistryPath = 'HKLM:\SOFTWARE\MMSOFT Design\PC Monitor'
    $RegistryKey1 = 'CPUUsagePercentage' # 1 to 99
    $RegistryKey2 = 'CPUUsageTimeInterval' # 1 to 120
    $RegistryKey3 = 'PrioritySendNotificationOnCPUUsage'

    $RegistryKey4 = 'SendNotificationOnCPUUsage' # 1 or 0

    $Percentage = Get-RegistryRemotely -Computer $Computer -RegistryPath $RegistryPath -RegistryKey $RegistryKey1
    $TimeInterval = Get-RegistryRemotely -Computer $Computer -RegistryPath $RegistryPath -RegistryKey $RegistryKey2
    $NotificationType = Get-RegistryRemotely -Computer $Computer -RegistryPath $RegistryPath -RegistryKey $RegistryKey3
    $NotificationEnabled = Get-RegistryRemotely -Computer $Computer -RegistryPath $RegistryPath -RegistryKey $RegistryKey4

    $Return = [ordered] @{
        Name                = 'CPU Above'
        Percentage          = $Percentage
        TimeInterval        = $TimeInterval
        NotificationType    = $NotificationType -As [NotificationType]
        NotificationEnabled = $NotificationEnabled -As [NotificationStatus]
    }
    return $Return
}

function Get-PulsewayMemoryLow {
    [cmdletbinding()]
    param(
        [string] $Computer = $Env:COMPUTERNAME
    )
    $RegistryPath = 'HKLM:\SOFTWARE\MMSOFT Design\PC Monitor'
    $RegistryKey1 = 'LowMemoryPercentage' # 1 to 99
    $RegistryKey2 = 'LowMemoryTimeInterval' # 1 to 120
    $RegistryKey3 = 'PrioritySendNotificationOnLowMemory'
    $RegistryKey4 = 'SendNotificationOnLowMemory' # 1 or 0

    $Percentage = Get-RegistryRemotely -Computer $Computer -RegistryPath $RegistryPath -RegistryKey $RegistryKey1
    $TimeInterval = Get-RegistryRemotely -Computer $Computer -RegistryPath $RegistryPath -RegistryKey $RegistryKey2
    $NotificationType = Get-RegistryRemotely -Computer $Computer -RegistryPath $RegistryPath -RegistryKey $RegistryKey3
    $NotificationEnabled = Get-RegistryRemotely -Computer $Computer -RegistryPath $RegistryPath -RegistryKey $RegistryKey4

    $Return = [ordered] @{
        Name                = 'Low Memory'
        Percentage          = $Percentage
        TimeInterval        = $TimeInterval
        NotificationType    = $NotificationType -As [NotificationType]
        NotificationEnabled = $NotificationEnabled -As [NotificationStatus]
    }
    return $Return
}
function Get-PulsewayMonitoredPortClosed {
    [cmdletbinding()]
    param(
        [string] $Computer = $Env:COMPUTERNAME
    )
    $RegistryPath = 'HKLM:\SOFTWARE\MMSOFT Design\PC Monitor'
    $RegistryKey1 = 'SendNotificationOnPortNotAccessible' # 1 to 99
    $RegistryKey2 = 'PortInterval' # 1 to 120
    $RegistryKey3 = 'PrioritySendNotificationOnPortNotAccessible'

    $NotificationEnabled = Get-RegistryRemotely -Computer $Computer -RegistryPath $RegistryPath -RegistryKey $RegistryKey1
    $TimeInterval = Get-RegistryRemotely -Computer $Computer -RegistryPath $RegistryPath -RegistryKey $RegistryKey2
    $NotificationType = Get-RegistryRemotely -Computer $Computer -RegistryPath $RegistryPath -RegistryKey $RegistryKey3

    $Return = [ordered] @{
        Name                = 'Monitored Port Closed'
        TimeInterval        = $TimeInterval
        NotificationType    = $NotificationType -As [NotificationType]
        NotificationEnabled = $NotificationEnabled -As [NotificationStatus]
    }
    return $Return
}