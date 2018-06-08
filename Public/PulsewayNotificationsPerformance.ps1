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

function Set-PulsewayCPUBelow {
    [cmdletbinding()]
    param(
        [string] $Computer = $Env:COMPUTERNAME,
        [int] $BelowCPUUsagePercentage = 10,
        [int] $BelowCPUUsageTimeInterval = 1,
        [NotificationType] $PrioritySendNotificationOnBelowCPUUsage,
        [NotificationStatus] $SendNotificationOnBelowCPUUsage
    )
    $RegistryPath = 'HKLM:\SOFTWARE\MMSOFT Design\PC Monitor'
    $RegistryKey1 = 'BelowCPUUsagePercentage' # 1 to 99
    $RegistryKey2 = 'BelowCPUUsageTimeInterval' # 1 to 120
    $RegistryKey3 = 'PrioritySendNotificationOnBelowCPUUsage'
    $RegistryKey4 = 'SendNotificationOnBelowCPUUsage' # 1 or 0

    Set-RegistryRemotly -Computer $Computer -RegistryPath $RegistryPath -RegistryKey $RegistryKey1 -Value $BelowCPUUsagePercentage
    Set-RegistryRemotly -Computer $Computer -RegistryPath $RegistryPath -RegistryKey $RegistryKey2 -Value $BelowCPUUsageTimeInterval
    Set-RegistryRemotly -Computer $Computer -RegistryPath $RegistryPath -RegistryKey $RegistryKey3 -Value ($PrioritySendNotificationOnBelowCPUUsage -As [Int])
    Set-RegistryRemotly -Computer $Computer -RegistryPath $RegistryPath -RegistryKey $RegistryKey4 -Value ($SendNotificationOnBelowCPUUsage -As [Int])
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

function Set-PulsewayCPUAbove {
    [cmdletbinding()]
    param(
        [string] $Computer = $Env:COMPUTERNAME,
        [int] $CPUUsagePercentage = 10,
        [int] $CPUUsageTimeInterval = 1,
        [NotificationType] $PrioritySendNotificationOnCPUUsage,
        [NotificationStatus] $SendNotificationOnCPUUsage
    )
    $RegistryPath = 'HKLM:\SOFTWARE\MMSOFT Design\PC Monitor'
    $RegistryKey1 = 'CPUUsagePercentage' # 1 to 99
    $RegistryKey2 = 'CPUUsageTimeInterval' # 1 to 120
    $RegistryKey3 = 'PrioritySendNotificationOnCPUUsage'
    $RegistryKey4 = 'SendNotificationOnCPUUsage' # 1 or 0

    Set-RegistryRemotly -Computer $Computer -RegistryPath $RegistryPath -RegistryKey $RegistryKey1 -Value $CPUUsagePercentage
    Set-RegistryRemotly -Computer $Computer -RegistryPath $RegistryPath -RegistryKey $RegistryKey2 -Value $CPUUsageTimeInterval
    Set-RegistryRemotly -Computer $Computer -RegistryPath $RegistryPath -RegistryKey $RegistryKey3 -Value ($PrioritySendNotificationOnCPUUsage -As [Int])
    Set-RegistryRemotly -Computer $Computer -RegistryPath $RegistryPath -RegistryKey $RegistryKey4 -Value ($SendNotificationOnCPUUsage -As [Int])
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

function Set-PulsewayMemoryLow {
    [cmdletbinding()]
    param(
        [string] $Computer = $Env:COMPUTERNAME,
        [int] $LowMemoryPercentage = 10,
        [int] $LowMemoryTimeInterval = 1,
        [NotificationType] $PrioritySendNotificationOnLowMemory,
        [NotificationStatus] $SendNotificationOnLowMemory
    )
    $RegistryPath = 'HKLM:\SOFTWARE\MMSOFT Design\PC Monitor'
    $RegistryKey1 = 'LowMemoryPercentage' # 1 to 99
    $RegistryKey2 = 'LowMemoryTimeInterval' # 1 to 120
    $RegistryKey3 = 'PrioritySendNotificationOnLowMemory'
    $RegistryKey4 = 'SendNotificationOnLowMemory' # 1 or 0

    Set-RegistryRemotly -Computer $Computer -RegistryPath $RegistryPath -RegistryKey $RegistryKey1 -Value $LowMemoryPercentage
    Set-RegistryRemotly -Computer $Computer -RegistryPath $RegistryPath -RegistryKey $RegistryKey2 -Value $LowMemoryTimeInterval
    Set-RegistryRemotly -Computer $Computer -RegistryPath $RegistryPath -RegistryKey $RegistryKey3 -Value ($PrioritySendNotificationOnLowMemory -As [Int])
    Set-RegistryRemotly -Computer $Computer -RegistryPath $RegistryPath -RegistryKey $RegistryKey4 -Value ($SendNotificationOnLowMemory -As [Int])
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

function Set-PulsewayMonitoredPortClosed {
    [cmdletbinding()]
    param(
        [string] $Computer = $Env:COMPUTERNAME,
        [int] $LowMemoryPercentage = 10,
        [int] $LowMemoryTimeInterval = 1,
        [NotificationType] $PrioritySendNotificationOnLowMemory,
        [NotificationStatus] $SendNotificationOnLowMemory
    )
    $RegistryPath = 'HKLM:\SOFTWARE\MMSOFT Design\PC Monitor'
    $RegistryKey2 = 'PortInterval' # 1 to 120
    $RegistryKey3 = 'PrioritySendNotificationOnPortNotAccessible'
    $RegistryKey4 = 'SendNotificationOnPortNotAccessible' # 1 to

    Set-RegistryRemotly -Computer $Computer -RegistryPath $RegistryPath -RegistryKey $RegistryKey2 -Value $PortInterval
    Set-RegistryRemotly -Computer $Computer -RegistryPath $RegistryPath -RegistryKey $RegistryKey3 -Value ($PrioritySendNotificationOnPortNotAccessible -As [Int])
    Set-RegistryRemotly -Computer $Computer -RegistryPath $RegistryPath -RegistryKey $RegistryKey4 -Value ($SendNotificationOnPortNotAccessible -As [Int])
}