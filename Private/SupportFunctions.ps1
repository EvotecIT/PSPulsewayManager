function Get-RegistryRemotely {
    [cmdletbinding()]
    param(
        $Computer = $Env:COMPUTERNAME,
        $RegistryPath,
        $RegistryKey
    )

    $ScriptBlock = {
        [cmdletbinding()]
        param(
            $RegistryPath,
            $RegistryKey
        )
        $Setting = Get-ItemProperty -Path $RegistryPath -Name $RegistryKey
        return $Setting.$RegistryKey
    }
    $List = New-Object System.Collections.ArrayList
    foreach ($Comp in $Computer) {
        $Return = Invoke-Command -ComputerName $Comp -ScriptBlock $ScriptBlock -ArgumentList $RegistryPath, $RegistryKey
        $List.Add($Return) | Out-Null
    }
    return $List
}
function Set-RegistryRemotly {
    [cmdletbinding()]
    param(
        $Computer,
        $RegistryPath,
        $RegistryKey,
        $Value
    )

    $ScriptBlock = {
        [cmdletbinding()]
        param(
            $RegistryPath,
            $RegistryKey,
            $Value
        )
        $VerbosePreference = $Using:VerbosePreference
        $Setting = Set-ItemProperty -Path $RegistryPath -Name $RegistryKey -Value $Value #-PassThru
        return $Setting
    }
    $List = New-Object System.Collections.ArrayList
    foreach ($Comp in $Computer) {
        $Return = Invoke-Command -ComputerName $Comp -ScriptBlock $ScriptBlock -ArgumentList $RegistryPath, $RegistryKey, $Value
        $List.Add($Return) | Out-Null
    }
    return $List
}

function Set-RegistryRemote {
    [cmdletbinding()]
    param(
        $Computer,
        $RegistryPath,
        [string[]]$RegistryKey,
        [object[]]$Value
    )

    $ScriptBlock = {
        [cmdletbinding()]
        param(
            $RegistryPath,
            $RegistryKey,
            $Value
        )
        $VerbosePreference = $Using:VerbosePreference
        $Setting = Set-ItemProperty -Path $RegistryPath -Name $RegistryKey -Value $Value #-PassThru
        return $Setting
    }
    $List = New-Object System.Collections.ArrayList
    foreach ($Comp in $Computer) {
        $Return = Invoke-Command -ComputerName $Comp -ScriptBlock $ScriptBlock -ArgumentList $RegistryPath, $RegistryKey, $Value
        $List.Add($Return) | Out-Null
    }
    return $List
}
