# HackTheBox Machine: Fawn
**FTP Anonymous Login Challenge**

## Machine Overview
Introductory HTB machine teaching FTP protocol basics and anonymous access exploitation. Demonstrates file transfer concepts and insecure access controls.

**Difficulty:** Very Easy | **Status:** Retired | **Platform:** HackTheBox Machines | **Type:** Tutorial/Starting Point

---

## Methodology

### Phase 1: Reconnaissance
- Verify network connectivity with ping
- Port scanning with nmap to identify services
- Service version detection and OS identification

### Phase 2: Service Enumeration
- Identify FTP service on port 21/tcp
- Determine FTP server software version
- Recognize Unix/Linux operating system

### Phase 3: FTP Client Usage
- Access FTP help documentation
- Understand FTP command structure
- Identify anonymous login capability

### Phase 4: Exploitation
- Connect to FTP service with anonymous credentials
- Navigate FTP filesystem using list commands
- Download files from FTP server
- Retrieve proof flags

---

## Tasks & Answers

### ✅ Task 1: FTP Protocol Definition
**Q:** What does the 3-letter acronym FTP stand for?  
**A:** `File Transfer Protocol`

**Explanation:** FTP is a standard network protocol used for transferring files between a client and server over a network. It operates on a client-server model and is commonly used for uploading and downloading files.

---

### ✅ Task 2: FTP Default Port
**Q:** Which port does the FTP service listen on usually?  
**A:** `21`

**Explanation:** FTP service by default listens on TCP port 21. This is the well-known port assigned to FTP by IANA standards.

---

### ✅ Task 3: Secure FTP Alternative
**Q:** FTP sends data in the clear without encryption. What acronym is used for a later protocol designed to provide similar functionality to FTP but securely, as an extension of the SSH protocol?  
**A:** `SFTP`

**Explanation:** SFTP (SSH File Transfer Protocol) is the secure alternative to FTP, operating over SSH (port 22) with encryption, preventing credential and data interception.

---

### ✅ Task 4: Connectivity Testing
**Q:** What is the command we can use to send an ICMP echo request to test our connection to the target?  
**A:** `ping`

**Explanation:** Ping utility sends ICMP echo requests to verify network reachability and measure latency to the target system.

**Command:**
```bash
ping <target-ip>
```

---

### ✅ Task 5: FTP Server Version
**Q:** From your scans, what version is FTP running on the target?  
**A:** `vsftpd 3.0.3`

**Explanation:** Nmap service version detection identifies vsftpd (Very Secure FTP Daemon) version 3.0.3 running on the target machine. This is a common FTP server implementation.

**Nmap Command:**
```bash
nmap -sV <target-ip>
```

---

### ✅ Task 6: Operating System Type
**Q:** From your scans, what OS type is running on the target?  
**A:** `Unix`

**Explanation:** OS detection through nmap reveals Unix/Linux operating system, identifiable through service signatures and open ports.

---

### ✅ Task 7: FTP Client Help Command
**Q:** What is the command we need to run in order to display the FTP client help menu?  
**A:** `ftp -?`

**Explanation:** The `ftp -?` command displays the help menu for the FTP client, showing available options and flags.

**Alternative:**
```bash
man ftp  # View FTP manual page
ftp -h   # Help flag (platform dependent)
```

---

### ✅ Task 8: Anonymous FTP Login
**Q:** What is the username that is used over FTP when you want to log in without having an account?  
**A:** `anonymous`

**Explanation:** FTP supports anonymous login, allowing users to connect without valid credentials. The standard username is "anonymous" with any email address as password.

**FTP Connection:**
```bash
ftp <target-ip>
username: anonymous
password: [blank]
```

---

### ✅ Task 9: FTP Success Response Code
**Q:** What is the response code we get for the FTP message 'Login successful'?  
**A:** `230`

**Explanation:** FTP uses 3-digit numeric response codes. Code 230 indicates "User logged in, proceed" - successful authentication.

**FTP Response Codes:**
```
220 - Service ready
230 - User logged in
331 - User name okay, password required
425 - Can't open data connection
```

---

### ✅ Task 10: File Listing Commands
**Q:** There are a couple of commands we can use to list the files and directories available on the FTP server. One is dir. What is the other that is a common way to list files on a Linux system?  
**A:** `ls`

**Explanation:** Both `dir` and `ls` commands list directory contents in FTP. The `ls` command is the standard Unix/Linux file listing command, also available in FTP.

**FTP File Listing:**
```bash
ftp> dir      # Detailed directory listing
ftp> ls       # Short directory listing
ftp> pwd      # Print working directory
```

---

### ✅ Task 11: File Download Command
**Q:** What is the command used to download the file we found on the FTP server?  
**A:** `get`

**Explanation:** The `get` command in FTP downloads a single file from the remote server to the local machine.

**FTP File Operations:**
```bash
ftp> get filename          # Download single file
ftp> mget *.txt           # Download multiple files with wildcard
ftp> put filename         # Upload file (if permissions allow)
ftp> delete filename      # Delete file (if permissions allow)
```

---

## FTP Exploitation Walkthrough

```bash
# Step 1: Verify connectivity
ping <target-ip>

# Step 2: Scan for open ports
nmap <target-ip>

# Step 3: Identify FTP service details
nmap -sV <target-ip>

# Step 4: Connect to FTP server
ftp <target-ip>

# Step 5: Login with anonymous credentials
username: anonymous
password: [press Enter or type any value]

# Step 6: List available files
ls
dir

# Step 7: Download the flag file
get flag.txt

# Step 8: Exit FTP
bye

# Step 9: Display captured flag
cat flag.txt
```

---

## Key Findings

| Category | Detail |
|----------|--------|
| **Vulnerability** | FTP anonymous login enabled without restrictions |
| **Service** | vsftpd 3.0.3 (Very Secure FTP Daemon) |
| **OS** | Unix/Linux |
| **Attack Vector** | Anonymous FTP access to retrieve sensitive files |
| **Impact** | Information disclosure, potential code execution |
| **Lesson** | Disable anonymous FTP; use SFTP instead; implement access controls |

---

## Tools Used
- **ping** - ICMP connectivity verification
- **nmap** - Port scanning and service detection
- **ftp** - FTP client for remote file transfer

---

## Security Implications

This machine demonstrates critical FTP security issues:
- **Anonymous Access:** FTP allows unauthenticated access by default
- **Unencrypted Protocol:** FTP transmits credentials and data in cleartext
- **File Exposure:** Sensitive files accessible via anonymous login
- **Legacy Service:** FTP is outdated for production environments

**Modern Alternatives:**
- SFTP (SSH File Transfer Protocol)
- SCP (Secure Copy Protocol)
- Cloud-based file sharing with encryption
- REST APIs with authentication

---

## Learning Objectives Achieved
✅ Understand FTP protocol fundamentals
✅ Recognize FTP port and service identification
✅ Identify FTP server software and versions
✅ Use FTP client effectively
✅ Exploit anonymous login vulnerability
✅ Recognize FTP security weaknesses
✅ Understand need for encrypted file transfer

---

## Score
**100% Complete** ✓
All 11 tasks answered and machine exploited successfully.

---

**Completion Date:** December 26, 2025  
**Machine Difficulty:** Very Easy ⭐  
**Time to Complete:** < 30 minutes  
**Status:** Retired (Learning Resource)
