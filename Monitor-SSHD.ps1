# File: Monitor-SSHD.ps1

$service = Get-Service -Name 'sshd'

if ($service.Status -ne 'Running') {
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logMessage = "$timestamp - SSHD Service is NOT running."

    # Log to file
    Add-Content -Path "C:\Logs\sshd_monitor.log" -Value $logMessage

    # Write to Event log
    Write-EventLog -LogName Application -Source "SSHD Monitor" -EventID 1001 -EntryType Error -Message $logMessage
} else {
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logMessage = "$timestamp - SSHD Service is running normally."

    # Log to file
    Add-Content -Path "C:\Logs\sshd_monitor.log" -Value $logMessage
}
