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