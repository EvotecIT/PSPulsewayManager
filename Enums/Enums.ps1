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
Enum PulsewayStatus {
    NotAvailable = 0;
    NotRunning = 1;
    Running = 2;
}
Enum DiskStatus {
    Enabled = 1;
    Disabled = 0;
}