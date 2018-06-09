Enum NotificationStatus {
    Enabled = 1;
    Disabled = 0;
}

Enum NotificationType {
    <#
        Accessing
        [NotificationType] $Day = [NotificationType]::Critical
        1 -As [NotificationType]
    #>
    Critical = 3;
    Elevated = 2;
    Normal = 1;
    Low = 0;
}

Enum Status {
    No = 0; Yes = 1;
}
function Get-PulsewayLocalDiskSpace {
    [cmdletbinding()]
    param(
        [string] $Computer = $Env:COMPUTERNAME
    )
    $RegistryPath = 'HKLM:\SOFTWARE\MMSOFT Design\PC Monitor'
    $RegistryKey1 = 'SendNotificationOnLowHDDSpace'

    $ReadRegistry = Get-RegistryRemote -Computer $Computer -RegistryPath $RegistryPath -RegistryKey $RegistryKey1
    $NotificationEnabled = $ReadRegistry[0]

    $RegistryPathSub = 'HKLM:\SOFTWARE\MMSOFT Design\PC Monitor\HDDList'
    $RegistryKeySub1 = 'Count'
    $ReadRegistrySub = Get-RegistryRemote -Computer $Computer -RegistryPath $RegistryPathSub -RegistryKey $RegistryKeySub1
    $MonitoredDrives = $ReadRegistrySub[0]

    # $Drive = Get-CimInstance Win32_LogicalDisk -ComputerName 'Evo1'
    # $Drive.VolumeSerialNumber

    $HddList = Get-RegistryRemoteList -Computer $Computer -RegistryPath $RegistryPathSub
    for ($i = 0; $i -lt $HddList.Count; $i++) {
        $Id = "Id$i"
        $Percentage = "Percentage$i"
        $Priority = "Priority$i"
        $SizeMB = "SizeMB$i"
        $UsePercentage = "UsePercentage$i"

        $HddList.$Id
        $HddList.$Percentage
        $HddList.$Priority
        $HddList.$SizeMB
        $HddList.$UsePercentage
    }

    $Value = $NotificationEnabled
    $ValueConverted = $Value -As [NotificationStatus]
    Write-verbose "Return VALUE: $NotificationEnabled After CONVERSION: $ValueConverted"

    $Return = [ordered] @{
        Name                 = 'HDD'
        MonitoredDrivesCount = $MonitoredDrives
        # TimeInterval        = $TimeInterval
        #  NotificationType    = $NotificationType -As [NotificationType]
        NotificationEnabled  = $NotificationEnabled #-As [NotificationStatus]
    }
    return $Return
}