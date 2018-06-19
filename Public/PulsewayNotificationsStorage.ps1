function Get-PulsewayLocalDiskSpace {
    [cmdletbinding()]
    param(
        [string] $Computer = $Env:COMPUTERNAME
    )
    $RegistryPath = 'HKLM:\SOFTWARE\MMSOFT Design\PC Monitor'
    $RegistryKey1 = 'SendNotificationOnLowHDDSpace'

    $ReadRegistry = Get-RegistryRemote -Computer $Computer -RegistryPath $RegistryPath -RegistryKey $RegistryKey1
    $NotificationEnabled = $ReadRegistry

    $RegistryPathSub = 'HKLM:\SOFTWARE\MMSOFT Design\PC Monitor\HDDList'
    $RegistryKeySub1 = 'Count'
    $ReadRegistrySub = Get-RegistryRemote -Computer $Computer -RegistryPath $RegistryPathSub -RegistryKey $RegistryKeySub1
    $MonitoredDrives = $ReadRegistrySub


    $ListDrives = New-Object System.Collections.ArrayList
    $HddList = Get-RegistryRemoteList -Computer $Computer -RegistryPath $RegistryPathSub
    for ($i = 0; $i -lt $HddList.Count; $i++) {
        $Id = "Id$i"
        $Percentage = "Percentage$i"
        $Priority = "Priority$i"
        $SizeMB = "SizeMB$i"
        $UsePercentage = "UsePercentage$i"

        $Drive = @{
            Id            = $HddList.$Id
            Percentage    = $HddList.$Percentage
            Priority      = $HddList.$Priority
            SizeMB        = $HddList.$SizeMB
            UsePercentage = $HddList.$UsePercentage
        }
        $ListDrives.Add($Drive)  > $null
    }

    $Value = $NotificationEnabled
    $ValueConverted = $Value -As [NotificationStatus]
    Write-verbose "Return VALUE: $NotificationEnabled After CONVERSION: $ValueConverted"

    $Return = [ordered] @{
        Name                 = 'HDD'
        ComputerName         = $Computer
        MonitoredDrivesCount = $MonitoredDrives
        # TimeInterval        = $TimeInterval
        #  NotificationType    = $NotificationType -As [NotificationType]
        NotificationEnabled  = $NotificationEnabled #-As [NotificationStatus]
        MonitoredDrives      = $ListDrives
    }
    return $Return
}

function Set-PulsewayLocalDiskSpace {
    [cmdletbinding()]
    param(
        [string] $Computer = $Env:COMPUTERNAME,
        $Drives,
        [NotificationStatus] $SendNotificationOnLowHDDSpace,
        [parameter(Mandatory = $False)][Switch]$PassThru
    )
    $RegistryPath = 'HKLM:\SOFTWARE\MMSOFT Design\PC Monitor'
    $RegistryKey1 = 'SendNotificationOnLowHDDSpace'

    $RegistryPathSub = 'HKLM:\SOFTWARE\MMSOFT Design\PC Monitor\HDDList'
    $RegistryKeySub1 = 'Count'

    $Count = Get-ObjectCount $Drives

    # Enable/disable notification
    Set-RegistryRemote -Computer $Computer -RegistryPath $RegistryPath `
        -RegistryKey $RegistryKey1 `
        -Value ($SendNotificationOnLowHDDSpace -As [int]) -PassThru:$PassThru

    # Count number of drives
    Set-RegistryRemote -Computer $Computer -RegistryPath $RegistryPathSub `
        -RegistryKey $RegistryKeySub1 `
        -Value $Count -PassThru:$PassThru

    $i = 0
    foreach ($drive in $drives) {
        Set-RegistryRemote -Computer $Computer -RegistryPath $RegistryPathSub `
            -RegistryKey "Id$i", "Percentage$i", "Priority$i", "SizeMB$i", "UsePercentage$i" `
            -Value  $drive.Id, $drive.Percentage, $drive.Priority, $drive.SizeMB, $drive.UsePercentage -PassThru:$PassThru
        $i++
    }
}
function Get-Drive {
    param (
        $Computer = $env:COMPUTERNAME
    )
    $Drive = Get-CimInstance Win32_LogicalDisk -ComputerName $Computer | Where-Object { $_.DriveType -eq 3 } | Select-Object DeviceID,
    VolumeName,
    Size,
    FreeSpace,
    @{label = 'SizeGB'; expression = {[math]::round( ($_.Size / 1GB), 2) }},
    @{label = 'FreeSpaceGB'; expression = {[math]::round( ($_.FreeSpace / 1GB), 2) }},
    VolumeSerialNumber,
    PSComputerName
    return $Drive
}
function Set-DriveSettings {
    param (
        $Drive,
        [int] $Percentage,
        [NotificationType] $Priority,
        [int] $SizeMB,
        [status] $UsePercentage
    )
    $List = New-Object System.Collections.ArrayList
    foreach ($d in $drive) {
        $Disk = @{
            Id            = $d.VolumeSerialNumber
            Percentage    = $Percentage
            Priority      = $Priority -As [int]
            SizeMB        = $SizeMB
            UsePercentage = $UsePercentage -AS [int]
        }
        $List.Add($Disk) > $null
    }
    return $List
}