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
