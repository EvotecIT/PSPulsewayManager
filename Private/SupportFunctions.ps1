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
        [string[]]$Computer,
        [string] $RegistryPath,
        [string[]]$RegistryKey,
        [string[]]$Value
    )

    $ScriptBlock = {
        #[cmdletbinding()]
        param(
            [string] $RegistryPath,
            [string[]] $RegistryKey,
            [string[]] $Value
        )
        $VerbosePreference = $Using:VerbosePreference
        $List = New-Object System.Collections.ArrayList

        for ($i = 0; $i -lt $RegistryKey.Count; $i++) {

            Write-Verbose "REG WRITE: $RegistryPath REGKEY: $($RegistryKey[$i]) REGVALUE: $($Value[$i])"
            $Setting = Set-ItemProperty -Path $RegistryPath -Name $RegistryKey[$i] -Value $Value[$i] #-PassThru
            $List.Add($Setting) | Out-Null
        }
        return $List
    }

    $ListComputers = New-Object System.Collections.ArrayList
    foreach ($Comp in $Computer) {
        $Return = Invoke-Command -ComputerName $Computer -ScriptBlock $ScriptBlock -ArgumentList $RegistryPath, $RegistryKey, $Value
        $ListComputers.Add($Return) | Out-Null
    }
    return $ListComputers
}
function Get-RegistryRemote {
    [cmdletbinding()]
    param(
        [string[]]$Computer = $Env:COMPUTERNAME,
        [string]$RegistryPath,
        [string[]]$RegistryKey
    )


    $ScriptBlock = {
        [cmdletbinding()]
        param(
            [string]$RegistryPath,
            [string[]]$RegistryKey
        )
        $VerbosePreference = $Using:VerbosePreference
        $List = New-Object System.Collections.ArrayList

        #Write-Verbose "REG READ: $RegistryPath REGKEY: $($RegistryKey)"

        for ($i = 0; $i -lt $RegistryKey.Count; $i++) {
            $RegKey = $RegistryKey[$i]
            Write-Verbose "REG READ: $RegistryPath REGKEY: $RegKey"
            $Setting = Get-ItemProperty -Path $RegistryPath -Name $RegKey
            Write-Verbose "REG VALUE: $($Setting.$RegKey)"
            $List.Add($Setting.$RegKey) | Out-Null
        }
        return $List
    }
    $ListComputers = New-Object System.Collections.ArrayList
    foreach ($Comp in $Computer) {
        $Return = Invoke-Command -ComputerName $Comp -ScriptBlock $ScriptBlock -ArgumentList $RegistryPath, $RegistryKey
        $ListComputers.Add($Return) | Out-Null
    }
    return $ListComputers
}