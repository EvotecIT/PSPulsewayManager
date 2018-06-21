#Install-Module PSPulsewayManager
#Install-Module PSManageService
Clear-Host
Import-Module PSPulsewayManager -Force
Import-Module PSManageService -Force

$MeasureTotal = [System.Diagnostics.Stopwatch]::StartNew() # Timer Start

### Define meaningful services
$ServicesOverall = @('BDESVC', 'EventLog', 'gpsvc', 'Schedule', 'Spooler', 'TermService', 'MpsSvc', 'FA_Scheduler'
    'vmicheartbeat', 'vmickvpexchange', 'vmicrdv', 'vmicshutdown', 'vmictimesync', 'vmicvss', 'VSS', 'W32Time', 'WinDefend',
    'WindowsAzureGuestAgent', 'WindowsAzureNetAgentSvc', 'WindowsAzureTelemetryService', 'AATPSensor', 'AATPSensorUpdater',
    'WpnService', 'wuauserv', 'BITS', 'Dhcp', 'EFS', 'LanmanServer', 'LanmanWorkstation', 'RpcEptMapper', 'VaultSvc', 'RpcSs', 'netprofm', 'MSDTC', 'DPS', 'ClickToRunSvc')
$ServicesIIS = @('W3SVC', 'IISADMIN', 'AppHostSvc', 'AppIDSvc', 'Appinfo', 'AppMgmt')
$ServicesHA = @('Dfs', 'DFSR', 'ClusSvc')
$ServicesSQL = @('SQLWriter', 'MSSQL*', 'MsDtsServer*', 'MSSQLFDLauncher*', 'SQLAgent*', 'SQLBrowser', 'SQLIaaSExtension', 'SQLSERVERAGENT', 'SQLWriter', 'SSDPSRV', 'MSDTC')
$ServicesSQLControl = @('SQLTELEMETRY*', 'SSISTELEMETRY')
$ServicesMonitorOverall = 'DNSCache', 'Winmgmt', 'WinRM', 'RemoteRegistry'
$ServicesAD = 'ADWS', 'Netlogon', 'DNS', 'NTDS'
$ServicesMonitoring = 'HealthService', 'MMAExtensionHeartbeatService', 'PC Monitor', 'RdAgent', 'AzureNetworkWatcherAgent', 'AmazonSSMAgent'
$ServicesFortinet = @( 'FCEMS_ActiveDirectory', 'FCEMS_Apache', 'FCEMS_Deploy', 'FCEMS_Monitor', 'FCEMS_Server', 'FCEMS_Update', 'FCEMS_UploadServer' )
$ServicesVeeam = @('VeeamDeploySvc', 'VeeamEndpointBackupSvc')
$ServicesFileServer = @('srmsvc', 'SmbHash', 'SmbWitness', 'smphost')
$ServicesRDS = @('TermServLicensing', 'TScPubRPC', 'Tssdis', 'CcmExec')
$ServicesService = @('SMTPSVC', 'SolarWinds SFTP Server')
$ServicesNPS = @('IAS')
$ServicesADFS = @('adfssrv', 'appproxyctrl', 'appproxysvc')
$ServicesADConnect = @('ADSync', 'AzureADConnectHealthSyncInsights', 'AzureADConnectHealthSyncMonitor', 'WindowsAzureGuestAgent', 'WindowsAzureNetAgentSvc')
$ServicesTEIIS = @('Isonet*')
$ServicesSCCM = @('SMS_EXECUTIVE', 'SMS_NOTIFICATION_SERVER', 'SMS_SITE_COMPONENT_MANAGER', 'SMS_SITE_SQL_BACKUP', 'SMS_SITE_VSS_WRITER')
$ServicesRRAS = @('RaMgmtSvc', 'RasMan')
$ServicesBackup = @('VeeamBackupSvc', 'VeeamBrokerSvc', 'VeeamCatalogSvc', 'VeeamCloudSvc', 'VeeamDeploySvc', 'VeeamDistributionSvc', 'VeeamMountSvc', 'VeeamNFSSvc', 'VeeamTransportSvc')
$ServicesATA = @('ATACenter')
$ServicesCA = @('CertSvc')
$ServicesPrintServer = @('Spooler') #BH-P-PRINTSRV1
$ServicesHyperV = @('vmickvpexchange', 'vmicguestinterface', 'vmicshutdown', 'vmicheartbeat', 'vmcompute', 'vmicvmsession', 'vmicrdv', 'vmictimesync', 'vmms', 'vmicvss')
###

### prepare services for monitoring, and control

$ServiceMonitor = $ServicesIIS + $ServicesHA + $ServicesSQL + $ServicesMonitorOverall + $ServicesAD + $ServicesFortinet + $ServicesVeeam + $ServicesFileServer + $ServicesRDS + $ServicesService + `
    $ServicesNPS + $ServicesADFS + $ServicesADConnect + $ServicesTEIIS + $ServicesSCCM + $ServicesRRAS + `
    $ServicesBackup + $ServicesATA + $ServicesCA + $ServicesPrintServer + $ServicesHyperV | Sort-Object -Unique

$ServiceControlOnly = $ServicesOverall + $ServicesSQLControl + $ServicesMonitoring + $ServiceMonitor | Sort-Object -Unique

$Exludes = '*-S-*', '*RD*', 'UAT*', 'PROD*', 'CLR-*', '*Clu1', '*s2d*', '*FileServer*'

#$Servers = Get-ADComputer -Filter { Name -eq 'Evo1' -or Name -eq 'AD1' } -Properties OperatingSystem | Select-Object Name, DNSHostName, OperatingSystem
$Servers = Get-ADComputer -Filter { OperatingSystem -like 'Windows Server*' } -Properties OperatingSystem | Select-Object Name, DNSHostName, OperatingSystem
foreach ($Exclude in $Exludes) {
    $Servers = $Servers | Where { $_.Name -notlike $Exclude }
}

$Servers = $Servers | Sort-Object Name
$Services = Get-PSService -Computers $Servers.Name -Services 'Pulseway' -maxRunspaces 200 #-Verbose
$PulsewayUnavailable = $Services | Where { $_.Status -eq 'N/A' }
$PulsewayRunning = $Services | Where { $_.Status -eq 'Running' }

Write-Color 'Servers to process: ', $Servers.Count, ' servers running: ', $PulsewayRunning.Count, ' servers unavailable: ', $PulsewayUnavailable.Count  -Color White, Yellow, White, Yellow, White, Yellow
Write-Color 'Pulseway is running: ', $PulsewayRunning.Count -Color White, Green
#$PulsewayRunning | Format-Table -AutoSize
Write-Color 'Pulseway is unavailable: ', $PulsewayUnavailable.Count -Color White, Red
#$PulsewayUnavailable | Format-Table -AutoSize

$ServerServicesAll = Get-PSService -Computers $PulsewayRunning.Computer -maxRunspaces 200 #-Verbose

foreach ($server in $PulsewayRunning.Computer) {
    Write-Color '[start]', ' Processing server: ', $Server, ' for ', 'Services' -Color Green, White, Yellow, White, Yellow

    $ServicesToProcessAll = $ServerServicesAll | Where { $_.Computer -eq $server }
    $ServicesToProcessRunning = $ServerServicesAll | Where { $_.Computer -eq $server -and $_.Status -eq 'Running' -and $_.StartType -eq 'Automatic' }

    $Green = foreach ($service in $ServicesToProcessAll.name) {
        foreach ($service2 in $ServiceControlOnly) {
            if ($service -like $service2) {
                Write-Output $service
            }
        }
    }

    $Yellow = foreach ($service in $ServicesToProcessRunning.name) {
        foreach ($service2 in $ServiceMonitor) {
            if ($service -like $service2) {
                Write-Output $service
            }
        }
    }

    Write-Color '[**]' , ' Enabling those services for control ' , ([string] $Green) -Color Yellow, White, Green
    Write-Color '[**]' , ' Enabling those services for monitoring ' , ([string] $Yellow) -Color Yellow, White, Green
    Set-PulsewayMonitoredServices -Computer $Server -Services $Green -ServicesToMonitor $Yellow -SendNotificationOnServiceStop Enabled -PrioritySendNotificationOnServiceStop Critical #-Verbose

}

$MeasureTotal.Stop()
Write-Color 'Time to process: ', "$($measureTotal.Elapsed)" -Color White, Yellow