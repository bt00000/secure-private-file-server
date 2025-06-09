# Disaster Recovery Playbook

**Project**: Secure Private Messaging and File Transfer Server (2025)  
**Environment**: Windows Server 2022, OpenSSH, SFTP, PowerShell  

---

## Overview

This Disaster Recovery Playbook outlines the steps to recover the Secure Private File Transfer Server in the event of a failure, data corruption, or security incident.

The server is critical for secure, end-to-end encrypted file transfers and must be restored quickly to maintain business continuity.

---

## Recovery Scenarios

### 1. **Server Crash (Hardware or Software Failure)**
- **Step 1**: Boot server using a recovery media if it cannot boot.
- **Step 2**: Restore from the latest **full system backup** created via **Windows Server Backup**.
- **Step 3**: Verify that OpenSSH Server is running:
  ```powershell
  Get-Service sshd
  ```
- **Step 4**: Verify static IP settings.
- **Step 5**: Confirm Windows Firewall rules — only port 22 open.
- **Step 6**: Test SSH and SFTP connections.

---

### 2. **Accidental File Deletion**
- **Step 1**: Identify the last known good backup.
- **Step 2**: Restore deleted files from **incremental backup**.
- **Step 3**: Confirm file integrity after restore.

---

### 3. **Ransomware or Malware Attack**
- **Step 1**: Disconnect the server from the network immediately.
- **Step 2**: Verify backups are clean and unaffected.
- **Step 3**: Wipe the infected machine (format/reinstall OS).
- **Step 4**: Restore the server from the last clean full backup.
- **Step 5**: Reapply all hardening configurations:
  - LGPO Security Baseline
  - SSH Hardening (disable root login, strong ciphers)
  - Windows Firewall inbound rules (Port 22 only)
- **Step 6**: Test SFTP, SSH functionality.
- **Step 7**: Run full malware scan before reconnecting to the network.

---

### 4. **Backup Recovery Test (Scheduled)**
- **Frequency**: Quarterly
- **Objective**: Validate the ability to fully restore the server.
- **Process**:
  - Restore a backup on a test environment.
  - Verify SSHD service, SFTP upload/download functionality.
  - Verify user authentication with public keys.

---

## Backup Strategy

| Backup Type     | Frequency        | Location               |
|-----------------|------------------|-------------------------|
| Full Backup     | Weekly (Sunday)   | External Secure Disk    |
| Incremental Backup | Daily (Mon-Sat) | External Secure Disk    |

- Backups are encrypted and stored securely offline when not in use.

---

## Post-Recovery Validation Checklist
- SSH login with public key authentication works.
- SFTP file upload and download tested.
- Windows Firewall rules intact (Port 22 only open).
- Server IP address and network configuration are static and correct.
- Windows automatic updates enabled.
- Monitoring scripts (Monitor-SSHD.ps1) are scheduled and running.
- Last backup and recovery logs are archived.

---
