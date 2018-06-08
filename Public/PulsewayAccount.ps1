# Account - Maintenance Mode
function Get-PulsewayMaintenanceMode {
    [cmdletbinding()]
    param(
        $Computer = $Env:COMPUTERNAME
    )
    $RegistryPath = 'HKLM:\SOFTWARE\MMSOFT Design\PC Monitor'
    $RegistryKey = 'MaintenanceMode'

    Get-RegistryRemote -Computer $Computer -RegistryPath $RegistryPath -RegistryKey $RegistryKey
}
function Set-PulsewayMaintenanceMode {
    [cmdletbinding()]
    param(
        [string[]] $Computer = $Env:COMPUTERNAME,
        [System.Nullable[bool]] $Toggle = $null
    )
    if ($Toggle -eq $null) { return 'Error: Not set. Not enough parameters!' }

    $RegistryPath = 'HKLM:\SOFTWARE\MMSOFT Design\PC Monitor'
    $RegistryKey = 'MaintenanceMode'

    if ($Toggle) { $Value = 1 } else { $Value = 0 }

    Set-RegistryRemote -Computer $Computer -RegistryPath $RegistryPath -RegistryKey $RegistryKey -Value $Value
}

# Account - Dedicated Server
function Set-PulsewaCustomServerAddress {
    [cmdletbinding()]
    param(
        [string[]] $Computer = $Env:COMPUTERNAME,
        [string] $CustomServerAddress = ''
    )
    if ($CustomServerAddress -eq '') { return 'Error: Not set. Not enough parameters!' }

    $RegistryPath = 'HKLM:\SOFTWARE\MMSOFT Design\PC Monitor'
    $RegistryKey = 'CustomServerAddress'

    Set-RegistryRemote -Computer $Computer -RegistryPath $RegistryPath -RegistryKey $RegistryKey -Value $CustomServerAddress
}
function Get-PulsewaCustomServerAddress {
    [cmdletbinding()]
    param(
        [string[]] $Computer = $Env:COMPUTERNAME

    )
    $RegistryPath = 'HKLM:\SOFTWARE\MMSOFT Design\PC Monitor'
    $RegistryKey = 'CustomServerAddress'

    Get-RegistryRemote -Computer $Computer -RegistryPath $RegistryPath -RegistryKey $RegistryKey
}

# Account - Computer Information

function Set-PulsewayGroupName {
    [cmdletbinding()]
    param(
        [string[]] $Computer = $Env:COMPUTERNAME,
        [string] $GroupName = ''
    )
    if ($GroupName -eq '') { return 'Error: Not set. Not enough parameters!' }

    $RegistryPath = 'HKLM:\SOFTWARE\MMSOFT Design\PC Monitor'
    $RegistryKey = 'GroupName'

    Set-RegistryRemote -Computer $Computer -RegistryPath $RegistryPath -RegistryKey $RegistryKey -Value $GroupName
}
function Get-PulsewayGroupName {
    [cmdletbinding()]
    param(
        [string[]] $Computer = $Env:COMPUTERNAME

    )
    $RegistryPath = 'HKLM:\SOFTWARE\MMSOFT Design\PC Monitor'
    $RegistryKey = 'GroupName'

    Get-RegistryRemote -Computer $Computer -RegistryPath $RegistryPath -RegistryKey $RegistryKey
}
function Get-PulsewayComputerName {
    [cmdletbinding()]
    param(
        [string[]] $Computer = $Env:COMPUTERNAME

    )
    $RegistryPath = 'HKLM:\SOFTWARE\MMSOFT Design\PC Monitor'
    $RegistryKey = 'ComputerName'

    Get-RegistryRemote -Computer $Computer -RegistryPath $RegistryPath -RegistryKey $RegistryKey
}

function Set-PulsewayComputerName {
    [cmdletbinding()]
    param(
        [string[]] $Computer = $Env:COMPUTERNAME,
        [string] $NewComputerName = ''
    )
    if ($NewComputerName -eq '') { return 'Error: Not set. Not enough parameters!' }

    $RegistryPath = 'HKLM:\SOFTWARE\MMSOFT Design\PC Monitor'
    $RegistryKey = 'ComputerName'

    Set-RegistryRemote -Computer $Computer -RegistryPath $RegistryPath -RegistryKey $RegistryKey -Value $NewComputerName
}