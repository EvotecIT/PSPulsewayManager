function Set-RegistryRemote {
    [cmdletbinding()]
    param(
        [string[]]$Computer,
        [string] $RegistryPath,
        [string[]]$RegistryKey,
        [string[]]$Value,
        [parameter(Mandatory = $False)][Switch]$PassThru
    )

    $ScriptBlock = {
        #[cmdletbinding()]
        param(
            [string] $RegistryPath,
            [string[]] $RegistryKey,
            [string[]] $Value,
            [bool]$PassThru
        )
        $VerbosePreference = $Using:VerbosePreference
        $List = New-Object System.Collections.ArrayList

        for ($i = 0; $i -lt $RegistryKey.Count; $i++) {
            Write-Verbose "REG WRITE: $RegistryPath REGKEY: $($RegistryKey[$i]) REGVALUE: $($Value[$i])" # PassThru: $PassThru"
            $Setting = Set-ItemProperty -Path $RegistryPath -Name $RegistryKey[$i] -Value $Value[$i] -PassThru:$PassThru
            if ($PassThru -eq $true) { $List.Add($Setting) > $null  }
        }
        return $List
    }

    $ListComputers = New-Object System.Collections.ArrayList
    foreach ($Comp in $Computer) {
        $Return = Invoke-Command -ComputerName $Computer -ScriptBlock $ScriptBlock -ArgumentList $RegistryPath, $RegistryKey, $Value, $PassThru
        if ($PassThru -eq $true) { $ListComputers.Add($Return) > $null }
    }
    return $ListComputers
}

function Get-RegistryRemoteList {
    param(
        [string[]]$Computer = $Env:COMPUTERNAME,
        [string]$RegistryPath
    )
    $ScriptBlock = {
        [cmdletbinding()]
        param(
            [string]$RegistryPath
        )
        $VerbosePreference = $Using:VerbosePreference
        $Setting = Get-ItemProperty -Path $RegistryPath
        return $Setting
    }

    $ListComputers = New-Object System.Collections.ArrayList
    foreach ($Comp in $Computer) {
        $Return = Invoke-Command -ComputerName $Comp -ScriptBlock $ScriptBlock -ArgumentList $RegistryPath
        $ListComputers.Add($Return)  > $null
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
            $Setting = Get-ItemProperty -Path $RegistryPath -Name $RegKey
            Write-Verbose "REG READ: $RegistryPath REGKEY: $RegKey REG VALUE: $($Setting.$RegKey)"
            $List.Add($Setting.$RegKey)  > $null
        }
        return $List
    }
    $ListComputers = New-Object System.Collections.ArrayList
    foreach ($Comp in $Computer) {
        $Return = Invoke-Command -ComputerName $Comp -ScriptBlock $ScriptBlock -ArgumentList $RegistryPath, $RegistryKey
        $ListComputers.Add($Return)  > $null
    }
    return $ListComputers
}

function Get-ObjectCount($Object) {
    return $($Object | Measure-Object).Count
}