# HackTheBox Machine: Meow
**Introductory Telnet Challenge**

## Machine Overview
Foundational HTB machine teaching basic networking concepts and telnet access. Introduction to virtual machines, VPN connectivity, and command-line reconnaissance tools.

**Difficulty:** Very Easy | **Status:** Retired | **Platform:** HackTheBox Machines | **Type:** Tutorial/Starting Point

---

## Methodology

### Phase 1: Setup & Connectivity
- Configure Virtual Machine environment
- Establish VPN connection via OpenVPN
- Verify connectivity to target with ICMP ping

### Phase 2: Reconnaissance
- Port scanning with Nmap to identify open services
- Service enumeration on discovered ports
- Identify telnet service on default port 23/tcp

### Phase 3: Exploitation
- Connect to telnet service without credentials
- Identify weak authentication (blank password)
- Retrieve root access

### Phase 4: Flag Extraction
- Access root shell
- Locate and capture proof flags

---

## Tasks & Answers

### ✅ Task 1: Virtual Machine Definition
**Q:** What does the acronym VM stand for?  
**A:** `Virtual Machine`

**Explanation:** A Virtual Machine is a software emulation of a computer system that runs an operating system and applications, providing isolated environments for testing and learning.

---

### ✅ Task 2: Command Line Interface
**Q:** What tool do we use to interact with the operating system in order to issue commands via the command line?  
**A:** `terminal`

**Explanation:** Also known as console or shell, the terminal provides command-line interface (CLI) access to issue system commands, including VPN connection initiation.

---

### ✅ Task 3: VPN Service
**Q:** What service do we use to form our VPN connection into HTB labs?  
**A:** `openvpn`

**Explanation:** OpenVPN is the VPN service used to establish encrypted connections into HackTheBox lab environments, enabling secure access to target machines.

---

### ✅ Task 4: Connectivity Testing
**Q:** What tool do we use to test our connection to the target with an ICMP echo request?  
**A:** `ping`

**Explanation:** Ping utility sends ICMP echo requests to verify network connectivity and measure latency to target systems.

**Command:**
```bash
ping <target-ip>
```

---

### ✅ Task 5: Port Scanning Tool
**Q:** What is the name of the most common tool for finding open ports on a target?  
**A:** `nmap`

**Explanation:** Nmap (Network Mapper) is the industry-standard tool for network reconnaissance, port scanning, and service enumeration.

**Command:**
```bash
nmap -p- <target-ip>  # Scan all ports
nmap -sV <target-ip>  # Identify services
```

---

### ✅ Task 6: Service Identification
**Q:** What service do we identify on port 23/tcp during our scans?  
**A:** `telnet`

**Explanation:** Port 23/tcp runs the Telnet service, an unencrypted remote login protocol. Nmap scanning reveals this service on the target.

**Nmap Output:**
```
23/tcp open telnet
```

---

### ✅ Task 7: Authentication
**Q:** What username is able to log into the target over telnet with a blank password?  
**A:** `root`

**Explanation:** The Meow machine demonstrates weak security practices by allowing root login with no password authentication, highlighting the importance of proper access controls.

**Telnet Connection:**
```bash
telnet <target-ip>
# When prompted for username, enter: root
# When prompted for password, press Enter (blank password)
# Successfully logged in as root
```

---

## Key Findings

| Category | Detail |
|----------|--------|
| **Vulnerability** | Unencrypted telnet service with weak authentication |
| **Root Cause** | Blank root password; no authentication enforcement |
| **Attack Vector** | Telnet login without credentials |
| **Impact** | Complete system compromise and remote code execution |
| **Lesson** | Never use telnet in production; disable root remote login; enforce strong authentication |

---

## Reconnaissance Summary

```bash
# Step 1: Verify connectivity
ping <target-ip>

# Step 2: Scan for open ports
nmap <target-ip>

# Step 3: Connect to telnet
telnet <target-ip>

# Step 4: Login with root/blank password
root
[blank password - just press Enter]

# Step 5: Capture flag
cat flag.txt
```

---

## Tools Used
- **Virtual Machine** - Lab environment
- **Terminal/Console** - Command-line interface
- **OpenVPN** - VPN connectivity
- **ping** - ICMP connectivity verification
- **nmap** - Port and service scanning
- **telnet** - Remote login client

---

## Learning Objectives Achieved
✅ Understand virtual machine concepts
✅ Configure VPN connectivity
✅ Use ping for connectivity testing
✅ Perform network reconnaissance with nmap
✅ Identify running services on target systems
✅ Connect via telnet protocol
✅ Recognize weak authentication practices

---

## Security Implications

This machine demonstrates critical security failures:
- **Unencrypted Protocol:** Telnet transmits credentials in cleartext
- **Weak Authentication:** Blank password for privileged account
- **No Access Controls:** Root login permitted remotely
- **Legacy Service:** Telnet should never be used in production

**Modern Alternatives:**
- SSH with key-based authentication
- Proper firewall rules
- Strong authentication policies

---

## Score
**100% Complete** ✓
All tasks answered and machine exploited successfully.

---

**Completion Date:** December 26, 2025  
**Machine Difficulty:** Very Easy ⭐  
**Time to Complete:** < 30 minutes  
**Status:** Retired (Learning Resource)
