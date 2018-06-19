function Get-PulsewayCPUBelow {
    [cmdletbinding()]
    param(
        [string] $Computer = $Env:COMPUTERNAME
    )
    $RegistryPath = 'HKLM:\SOFTWARE\MMSOFT Design\PC Monitor'
    $RegistryKey1 = 'BelowCPUUsagePercentage' # 1 to 99
    $RegistryKey2 = 'BelowCPUUsageTimeInterval' # 1 to 120
    $RegistryKey3 = 'PrioritySendNotificationOnBelowCPUUsage'
    $RegistryKey4 = 'SendNotificationOnBelowCPUUsage' # 1 or 0

    $ReadRegistry = Get-RegistryRemote -Computer $Computer -RegistryPath $RegistryPath `
        -RegistryKey $RegistryKey1, $RegistryKey2, $RegistryKey3, $RegistryKey4

    $Percentage = $ReadRegistry[0]
    $TimeInterval = $ReadRegistry[1]
    $NotificationType = $ReadRegistry[2]
    $NotificationEnabled = $ReadRegistry[3]

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
        [System.Nullable[NotificationType]] $PrioritySendNotificationOnBelowCPUUsage = $null,
        [System.Nullable[NotificationStatus]] $SendNotificationOnBelowCPUUsage = $null
    )
    if ($PrioritySendNotificationOnBelowCPUUsage -eq $null -or $SendNotificationOnBelowCPUUsage -eq $null) {
        return 'Error: Not set. Not enough parameters!'
    }

    $RegistryPath = 'HKLM:\SOFTWARE\MMSOFT Design\PC Monitor'
    $RegistryKey1 = 'BelowCPUUsagePercentage' # 1 to 99
    $RegistryKey2 = 'BelowCPUUsageTimeInterval' # 1 to 120
    $RegistryKey3 = 'PrioritySendNotificationOnBelowCPUUsage'
    $RegistryKey4 = 'SendNotificationOnBelowCPUUsage' # 1 or 0

    Set-RegistryRemote -Computer $Computer -RegistryPath $RegistryPath `
        -RegistryKey $RegistryKey1, $RegistryKey2, $RegistryKey3, $RegistryKey4 `
        -Value $BelowCPUUsagePercentage, $BelowCPUUsageTimeInterval, ($PrioritySendNotificationOnBelowCPUUsage -As [Int]), ($SendNotificationOnBelowCPUUsage -As [Int])
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

    $ReadRegistry = Get-RegistryRemote -Computer $Computer -RegistryPath $RegistryPath `
        -RegistryKey $RegistryKey1, $RegistryKey2, $RegistryKey3, $RegistryKey4

    $Percentage = $ReadRegistry[0]
    $TimeInterval = $ReadRegistry[1]
    $NotificationType = $ReadRegistry[2]
    $NotificationEnabled = $ReadRegistry[3]

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
        [System.Nullable[NotificationType]] $PrioritySendNotificationOnCPUUsage = $null,
        [System.Nullable[NotificationStatus]] $SendNotificationOnCPUUsage = $null
    )
    if ($PrioritySendNotificationOnCPUUsage -eq $null -or $SendNotificationOnCPUUsage -eq $null) {
        return 'Error: Not set. Not enough parameters!'
    }

    $RegistryPath = 'HKLM:\SOFTWARE\MMSOFT Design\PC Monitor'
    $RegistryKey1 = 'CPUUsagePercentage' # 1 to 99
    $RegistryKey2 = 'CPUUsageTimeInterval' # 1 to 120
    $RegistryKey3 = 'PrioritySendNotificationOnCPUUsage'
    $RegistryKey4 = 'SendNotificationOnCPUUsage' # 1 or 0

    Set-RegistryRemote -Computer $Computer -RegistryPath $RegistryPath `
        -RegistryKey $RegistryKey1, $RegistryKey2, $RegistryKey3, $RegistryKey4 `
        -Value $CPUUsagePercentage, $CPUUsageTimeInterval, ($PrioritySendNotificationOnCPUUsage -As [Int]), ($SendNotificationOnCPUUsage -As [Int])
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

    $ReadRegistry = Get-RegistryRemote -Computer $Computer -RegistryPath $RegistryPath `
        -RegistryKey $RegistryKey1, $RegistryKey2, $RegistryKey3, $RegistryKey4

    $Percentage = $ReadRegistry[0]
    $TimeInterval = $ReadRegistry[1]
    $NotificationType = $ReadRegistry[2]
    $NotificationEnabled = $ReadRegistry[3]

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
        [System.Nullable[NotificationType]] $PrioritySendNotificationOnLowMemory = $null,
        [System.Nullable[NotificationStatus]] $SendNotificationOnLowMemory = $null
    )
    if ($PrioritySendNotificationOnLowMemory -eq $null -or $SendNotificationOnLowMemory -eq $null) {
        return 'Error: Not set. Not enough parameters!'
    }

    $RegistryPath = 'HKLM:\SOFTWARE\MMSOFT Design\PC Monitor'
    $RegistryKey1 = 'LowMemoryPercentage' # 1 to 99
    $RegistryKey2 = 'LowMemoryTimeInterval' # 1 to 120
    $RegistryKey3 = 'PrioritySendNotificationOnLowMemory'
    $RegistryKey4 = 'SendNotificationOnLowMemory' # 1 or 0

    Set-RegistryRemote -Computer $Computer -RegistryPath $RegistryPath `
        -RegistryKey $RegistryKey1, $RegistryKey2, $RegistryKey3, $RegistryKey4 `
        -Value $LowMemoryPercentage, $LowMemoryTimeInterval, ($PrioritySendNotificationOnLowMemory -As [Int]), ($SendNotificationOnLowMemory -As [Int])
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

    $ReadRegistry = Get-RegistryRemote -Computer $Computer -RegistryPath $RegistryPath `
        -RegistryKey $RegistryKey1, $RegistryKey2, $RegistryKey3

    $NotificationEnabled = $ReadRegistry[0]
    $TimeInterval = $ReadRegistry[1]
    $NotificationType = $ReadRegistry[2]

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
        [int] $PortInterval = 10,
        [System.Nullable[NotificationType]] $PrioritySendNotificationOnPortNotAccessible = $null,
        [System.Nullable[NotificationStatus]] $SendNotificationOnPortNotAccessible = $null
    )
    if ($PrioritySendNotificationOnPortNotAccessible -eq $null -or $SendNotificationOnPortNotAccessible -eq $null) {
        return 'Error: Not set. Not enough parameters!'
    }

    $RegistryPath = 'HKLM:\SOFTWARE\MMSOFT Design\PC Monitor'
    $RegistryKey1 = 'PortInterval'
    $RegistryKey2 = 'PrioritySendNotificationOnPortNotAccessible'
    $RegistryKey3 = 'SendNotificationOnPortNotAccessible'

    Set-RegistryRemote -Computer $Computer -RegistryPath $RegistryPath `
        -RegistryKey $RegistryKey1, $RegistryKey2, $RegistryKey3 `
        -Value $PortInterval, ($PrioritySendNotificationOnPortNotAccessible -As [Int]), ($SendNotificationOnPortNotAccessible -As [Int])
}