# Brute Force Checker

Defensive security tool for analyzing SSH authentication logs and detecting brute-force attack patterns.

## Purpose

Identifies and reports on unauthorized access attempts in `auth.log`:
- Source IPs with high failed login attempts
- Successful logins from suspicious IPs
- Attack timeline (first/last attempt)
- Compromised user accounts
- Recommendations for hardening

## Usage

```bash
./brute_force_checker.sh [log_file] [threshold]
```

### Arguments

| Argument | Default | Description |
|----------|---------|-------------|
| `log_file` | `/var/log/auth.log` | Path to SSH auth log |
| `threshold` | `10` | Failed attempts to flag as suspicious |

### Help

```bash
./brute_force_checker.sh -h
```

### Examples

```bash
# Default (system auth.log, threshold=10)
sudo ./brute_force_checker.sh

# Custom log file
sudo ./brute_force_checker.sh /var/log/auth.log.1 15

# Specific threshold
sudo ./brute_force_checker.sh /tmp/test.log 5
```

## Output Sections

1. **Failed login attempts by IP** - Counts failed attempts per source IP, marks as `[SUSPICIOUS]` if >= threshold

2. **Successful logins from top IPs** - Lists IPs with successful authentication and compromised user accounts

3. **Attack timeline** - First attempt, last attempt, and total count per suspicious IP

4. **Successful login summary** - Total successful logins and top user accounts

5. **Recommendations** - Hardening steps (fail2ban, SSH key auth, disable root login, etc.)

## Example Output

```
=== Brute Force Detection Report ===
Log: /var/log/auth.log | Threshold: 10 attempts | Date: Wed Dec 25 10:30:22 UTC 2025

[*] Failed login attempts by IP:
  45 203.0.113.10 [SUSPICIOUS]
  23 198.51.100.5 [SUSPICIOUS]
  8 192.0.2.100

[*] Successful logins from top IPs:
  203.0.113.10: 3 logins (users: root, ubuntu)

[*] Attack timeline (first/last attempt):
  203.0.113.10: first=Dec 23 14:32:01 | last=Dec 25 09:15:47 | total=45

[*] Successful login summary:
  Total successful logins: 142
  Top users:
    ubuntu: 87 logins
    admin: 32 logins
    root: 23 logins
```

## Requirements

- Linux/Unix system with bash
- Read access to log file (use `sudo` for `/var/log/auth.log`)
- Standard utilities: grep, awk, sort, uniq

### Setup

Ensure script has execute permissions:
```bash
chmod +x brute_force_checker.sh
```

## How It Works

### IP Detection

Extracts source IPs from failed password entries:
```bash
grep "Failed password" | grep -oP '(?<=from )\S+' | sort | uniq -c | sort -rn
```

### Successful Breach Detection

For each suspicious IP, checks for successful logins:
```bash
grep "Accepted password" | grep "from $ip" | grep -oP '(?<=for )\S+'
```

### Timeline Analysis

Extracts first and last attempt timestamps for pattern analysis.

## Legal & Ethical

**DEFENSIVE USE ONLY**

This tool is designed for:
- ✅ Incident investigation on systems you own/manage
- ✅ Security monitoring and hardening
- ✅ Post-compromise analysis
- ✅ Log analysis in authorized penetration tests

**NOT for:**
- ❌ Unauthorized access to systems
- ❌ Offensive attacks
- ❌ Violating system access policies

## Limitations

- Only analyzes successful/failed attempts in auth.log (not system activity)
- Cannot detect attacks using valid credentials from legitimate IPs
- Requires logs to be retained on disk (log rotation may delete evidence)
- Cannot identify attacks using SSH keys (only password-based attempts)

## Recommendations

If this tool detects suspicious activity:

1. **Immediate:**
   - Review successful login sources and user accounts
   - Check for unauthorized sudo usage: `grep "sudo" /var/log/auth.log`
   - Verify running processes: `ps aux | grep -v grep`

2. **Short-term:**
   - Implement `fail2ban` for automatic IP blocking
   - Disable password authentication (use SSH keys only)
   - Disable root login: `PermitRootLogin no` in `/etc/ssh/sshd_config`

3. **Long-term:**
   - Monitor logs with centralized logging (ELK, Splunk)
   - Implement MFA for all accounts
   - Rotate SSH keys quarterly
   - Regular security audits

## Limitations

**Important edge cases and limitations:**

- **Log format assumption**: Assumes standard sshd auth.log format. Custom log formats may not parse correctly
- **IP regex**: Pattern `(?<=from )\S+` assumes IP/hostname immediately after "from ". Malformed logs may extract partial data
- **Timezone awareness**: Timestamps extracted are local log time. No UTC conversion
- **Large file performance**: Script loads full log into memory via variable assignment. Files >100MB may be slow
- **Partial compromise detection**: Only detects successful logins RECORDED in auth.log. Does not detect:
  - SSH key-based attacks (no failed attempts recorded)
  - Port scanning on other ports
  - Attacks via other services (FTP, HTTP, etc)
  - Rootkits or kernel-level persistence
- **User field extraction**: Assumes standard format `for <username>`. Custom PAM modules may break this
- **Data retention**: Only analyzes current log file. Rotated logs require separate analysis
- **False positives**: Legitimate users with failed attempts (typos, key problems) may appear suspicious
- **False negatives**: Attackers with low request rates may not trigger threshold

## Recommended Workflow

1. Run regularly (cron job): `0 */6 * * * /path/to/brute_force_checker.sh`
2. Parse output for [BREACH] entries only in automated responses
3. Always manually verify findings before taking action
4. Combine with other monitoring (netstat, process monitoring, file integrity)
5. Archive reports for compliance and forensics

## Author

DrCarfrei

## License

MIT
