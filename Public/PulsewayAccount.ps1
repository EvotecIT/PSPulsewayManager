# Account - Maintenance Mode
function Get-PulsewayMaintenanceMode {
    [cmdletbinding()]
    param(
        $Computer = $Env:COMPUTERNAME
    )
    $RegistryPath = 'HKLM:\SOFTWARE\MMSOFT Design\PC Monitor'
    $RegistryKey = 'MaintenanceMode'

    Get-RegistryRemotely -Computer $Computer -RegistryPath $RegistryPath -RegistryKey $RegistryKey
}
function Set-PulsewayMaintenanceMode {
    [cmdletbinding()]
    param(
        [string[]] $Computer = $Env:COMPUTERNAME,
        [bool] $Toggle
    )
    $RegistryPath = 'HKLM:\SOFTWARE\MMSOFT Design\PC Monitor'
    $RegistryKey = 'MaintenanceMode'

    if ($Toggle) { $Value = 1 } else { $Value = 0 }

    Set-RegistryRemotly -Computer $Computer -RegistryPath $RegistryPath -RegistryKey $RegistryKey -Value $Value
}

# Account - Dedicated Server
function Set-PulsewaCustomServerAddress {
    [cmdletbinding()]
    param(
        [string[]] $Computer = $Env:COMPUTERNAME,
        [string] $CustomServerAddress
    )
    $RegistryPath = 'HKLM:\SOFTWARE\MMSOFT Design\PC Monitor'
    $RegistryKey = 'CustomServerAddress'

    Set-RegistryRemotly -Computer $Computer -RegistryPath $RegistryPath -RegistryKey $RegistryKey -Value $CustomServerAddress
}
function Get-PulsewaCustomServerAddress {
    [cmdletbinding()]
    param(
        [string[]] $Computer = $Env:COMPUTERNAME

    )
    $RegistryPath = 'HKLM:\SOFTWARE\MMSOFT Design\PC Monitor'
    $RegistryKey = 'CustomServerAddress'

    Get-RegistryRemotely -Computer $Computer -RegistryPath $RegistryPath -RegistryKey $RegistryKey
}

# Account - Computer Information

function Set-PulsewayGroupName {
    [cmdletbinding()]
    param(
        [string[]] $Computer = $Env:COMPUTERNAME,
        [string] $GroupName
    )
    $RegistryPath = 'HKLM:\SOFTWARE\MMSOFT Design\PC Monitor'
    $RegistryKey = 'GroupName'

    Set-RegistryRemotly -Computer $Computer -RegistryPath $RegistryPath -RegistryKey $RegistryKey -Value $GroupName
}
function Get-PulsewayGroupName {
    [cmdletbinding()]
    param(
        [string[]] $Computer = $Env:COMPUTERNAME

    )
    $RegistryPath = 'HKLM:\SOFTWARE\MMSOFT Design\PC Monitor'
    $RegistryKey = 'GroupName'

    Get-RegistryRemotely -Computer $Computer -RegistryPath $RegistryPath -RegistryKey $RegistryKey
}
function Get-PulsewayComputerName {
    [cmdletbinding()]
    param(
        [string[]] $Computer = $Env:COMPUTERNAME

    )
    $RegistryPath = 'HKLM:\SOFTWARE\MMSOFT Design\PC Monitor'
    $RegistryKey = 'ComputerName'

    Get-RegistryRemotely -Computer $Computer -RegistryPath $RegistryPath -RegistryKey $RegistryKey
}

function Set-PulsewayComputerName {
    [cmdletbinding()]
    param(
        [string[]] $Computer = $Env:COMPUTERNAME,
        [string] $NewComputerName
    )
    $RegistryPath = 'HKLM:\SOFTWARE\MMSOFT Design\PC Monitor'
    $RegistryKey = 'ComputerName'

    Set-RegistryRemotly -Computer $Computer -RegistryPath $RegistryPath -RegistryKey $RegistryKey -Value $NewComputerName
}