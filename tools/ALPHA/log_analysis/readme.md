# Log Analysis Suite

Collection of defensive security tools for analyzing system and application logs.

## Tools

### [Brute Force Checker](brute_force_checker/)

Detects SSH brute-force attack patterns in auth.log.

- Identifies suspicious IPs by failed login attempts
- Flags successful logins from attack sources
- Generates attack timeline (first/last attempt)
- Reports compromised user accounts

**Tech:** Bash script using grep, awk, sort

**Quick start:**
```bash
cd brute_force_checker && chmod +x brute_force_checker.sh && sudo ./brute_force_checker.sh
```

### [Log Analyzer](log_analyzer/)

Generic log pattern extraction and analysis tool for any log file.

- Search patterns across multiple log files
- Extract specific fields (IPs, users, timestamps, commands)
- Aggregate and count occurrences
- Generate statistics (first/last/total)
- Identify unique values

**Tech:** Bash script with argument parsing and field extraction

**Quick start:**
```bash
cd log_analyzer && chmod +x log_analyzer.sh && ./log_analyzer.sh -f /var/log/syslog -p "error"
```

## Use Cases

- **Post-compromise analysis** - Timeline reconstruction, evidence gathering
- **Security monitoring** - Pattern detection, anomaly identification
- **Incident response** - Log correlation, root cause analysis
- **Forensics** - Event reconstruction, activity timeline

## Requirements

- Linux/Unix system with bash
- Read access to log files (may require sudo)
- Standard utilities: grep, awk, sed, sort, uniq

## License

MIT
