# Custom Tools Documentation

Guide to custom security tools in The Sec Arena.

---

## 🛠️ Available Tools

### Log Analysis Suite

Located in `tools/ALPHA/log_analysis/`

#### brute_force_checker.sh

**Purpose:** Detect SSH brute-force attacks in system auth.log

**Usage:**
```bash
./brute_force_checker.sh /var/log/auth.log
```

**Output:**
- IP addresses attempting brute force
- Failed login counts per IP
- Successful logins from attack sources
- Fail2ban recommendation

**Features:**
- Single-pass analysis (efficient)
- IPv4 and IPv6 support
- Pattern-based detection
- Timeline generation

**Limitations:**
- Only analyzes auth.log format
- Requires proper log permissions
- Needs recent log data

---

#### log_analyzer.sh

**Purpose:** Generic pattern extraction and statistics from log files

**Usage:**
```bash
# Count occurrences
./log_analyzer.sh -C "ERROR" -f /var/log/syslog

# Get statistics
./log_analyzer.sh -s "http_status" -f access.log

# Extract field
./log_analyzer.sh -e 4 -f /var/log/auth.log
```

**Actions:**
- `-C`: Count pattern matches
- `-s`: Show statistics (requires numeric fields)
- `-e`: Extract field (column number)
- `-c`: Get context lines around matches
- `-u`: Show only unique values

**Examples:**
```bash
# Top HTTP status codes
./log_analyzer.sh -e 9 -u -f access.log | head -10

# Count failed SSH attempts
./log_analyzer.sh -C "Failed password" -f auth.log

# Extract and count unique IPs
./log_analyzer.sh -e 1 -u -f access.log
```

**Performance:**
- Single-read design
- Efficient for large logs (1GB+)
- Minimal memory footprint

---

## 🔧 Tool Lifecycle

### ALPHA Stage
- Experimental, untested on production
- May contain bugs
- Use for testing and feedback
- No stability guarantees

### BETA Stage
- Tested and working
- Known issues documented
- Gathering user feedback
- Stability improving

### RELEASE Stage
- Production-ready
- Stable and supported
- Fully documented
- Regular maintenance

---

## 📈 Tool Development Path

Current status:
- **brute_force_checker.sh:** ALPHA → Ready for BETA (code review complete)
- **log_analyzer.sh:** ALPHA → Ready for BETA (comprehensive testing done)

Next steps for promotion to BETA:
1. Real-world testing on production logs
2. User feedback collection
3. Edge case handling
4. Performance optimization

---

## 🔗 Related Documentation

- [SETUP.md](SETUP.md) - Installation instructions
- [METHODOLOGY.md](METHODOLOGY.md) - When to use these tools
- [RESOURCES.md](RESOURCES.md) - Log analysis references

---

## 💬 Contributing

Found a bug? Have improvements?

1. Test thoroughly and document the issue
2. Create a detailed bug report
3. Submit pull request with fix
4. Follow code style guidelines

All contributions welcome!
