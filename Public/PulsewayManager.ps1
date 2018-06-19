function Get-PulsewayStatus {
    param(
        [string] $Computer = $ENV:COMPUTERNAME
    )
    $Service = Get-PSService -Computers $Computer -Services 'Pulseway'
    if ($Service.Status -eq 'Running') {
        return [PulsewayStatus]::Running
    } elseif ($Service.Stuats -eq 'N/A') {
        return [PulsewayStatus]::NotAvailable
    } else {
        return [PulsewayStatus]::NotRunning
    }
}