# HackTheBox Machine: Redeemer
[← Back to Very Easy Machines](../readme.md) | [← Back to HTB Root](../../readme.md)

**Redis Enumeration & Authentication Bypass Challenge**

## Machine Overview
Introductory machine demonstrating Redis service enumeration, default configuration risks, and unauthenticated database access. Focuses on reconnaissance techniques and understanding in-memory databases.

**Difficulty:** Very Easy | **Status:** Retired | **Platform:** HackTheBox Machines | **OS:** Linux | **Type:** Enumeration

---

## Methodology

### Phase 1: Reconnaissance & Port Scanning
- Network enumeration with Nmap
- Service identification on open ports
- Version detection of running services

### Phase 2: Service Enumeration
- Redis service identification
- Understanding Redis protocol and functionality
- Database structure exploration

### Phase 3: Database Access & Flag Extraction
- Connection to Redis service using redis-cli
- Database navigation and key enumeration
- Flag retrieval from database

---

## Questions & Answers

### ✅ Task 1: Open TCP Port
**Q:** Which TCP port is open on the machine?  
**A:** `6379`

**Analysis:** Standard Redis default port. Port 6379 is the default listening port for Redis server instances unless explicitly configured otherwise.

---

### ✅ Task 2: Running Service
**Q:** Which service is running on the port that is open on the machine?  
**A:** `redis`

**Analysis:** Redis is an open-source, in-memory data structure store running on port 6379. No authentication configured, allowing unauthenticated access for this lab environment.

---

### ✅ Task 3: Redis Database Type
**Q:** What type of database is Redis? Choose from the following options: (i) In-memory Database, (ii) Traditional Database  
**A:** `In-memory Database`

**Analysis:**
- **In-memory Database:** Redis stores all data in RAM
- Provides extremely fast read/write operations
- Data is volatile (lost on restart) unless persistence is configured
- Excellent for caching, session storage, and real-time applications

---

### ✅ Task 4: Command-Line Utility
**Q:** Which command-line utility is used to interact with the Redis server? Enter the program name you would enter into the terminal without any arguments.  
**A:** `redis-cli`

**Analysis:** redis-cli (Redis Command Line Interface) is the official tool for:
- Connecting to Redis servers
- Executing Redis commands
- Interactive exploration of data
- Remote administration of Redis instances

---

### ✅ Task 5: Hostname Flag
**Q:** Which flag is used with the Redis command-line utility to specify the hostname?  
**A:** `-h`

**Analysis:** Flag syntax for redis-cli connection:
```bash
redis-cli -h <hostname> -p <port>
```
- `-h` specifies the hostname or IP address
- `-p` specifies the port number
- Default is localhost:6379 if not specified

---

### ✅ Task 6: Server Information Command
**Q:** Once connected to a Redis server, which command is used to obtain the information and statistics about the Redis server?  
**A:** `info`

**Analysis:** The `info` command returns:
- Redis server version
- Memory usage statistics
- Connected clients count
- Replication status
- Keyspace statistics
- Configuration parameters

```bash
redis-cli
> info
```

---

### ✅ Task 7: Redis Server Version
**Q:** What is the version of the Redis server being used on the target machine?  
**A:** `5.0.7`

**Analysis:** Redis 5.0.7 is a relatively older version (released in 2019). Versions pre-6.0 lacked built-in ACL capabilities, making authentication more primitive and relying on simple password protection (if configured).

---

### ✅ Task 8: Database Selection Command
**Q:** Which command is used to select the desired database in Redis?  
**A:** `select`

**Analysis:** Redis database selection:
- Redis instances typically contain 16 databases (indexed 0-15)
- Default database is 0
- Syntax: `select <database_number>`
- Databases are isolated keyspaces

```bash
redis-cli
> select 0  # Switch to database 0
> select 1  # Switch to database 1
```

---

### ✅ Task 9: Keys in Database 0
**Q:** How many keys are present inside the database with index 0?  
**A:** `4`

**Analysis:**
- Database 0 contains 4 key-value pairs
- Can be verified with the `dbsize` command
- Keys enumeration reveals stored data in the database

```bash
> select 0
> dbsize
(integer) 4
```

---

### ✅ Task 10: Key Enumeration Command
**Q:** Which command is used to obtain all the keys in a database?  
**A:** `keys *`

**Analysis:** The `keys` command with wildcard pattern:
- **Syntax:** `keys <pattern>`
- **`keys *`:** Returns all keys in the current database
- **Pattern matching:** Supports glob-style patterns (*, ?, [])
- **Warning:** Can be slow on large databases (keys are scanned sequentially)

```bash
> keys *
```

---

## 🎯 Redis Enumeration Summary

| Command | Purpose | Example Output |
|---------|---------|-----------------|
| `info` | Server statistics | Redis version, memory usage, etc. |
| `ping` | Server connectivity | PONG |
| `select <db>` | Switch database | OK |
| `dbsize` | Count keys in database | (integer) 4 |
| `keys *` | List all keys | 1) "key1" 2) "key2" 3) "key3" 4) "key4" |
| `get <key>` | Retrieve value | String value |
| `type <key>` | Determine data type | string, list, hash, set, zset |

---

## 🛡️ Security Implications

### Why This Machine Matters
```
Redis Running Without Authentication
         ↓
Unauthenticated Access to All Data
         ↓
Potential Data Exfiltration
         ↓
Service Misconfiguration Exploits
```

### Default Configuration Risks
- **Unprotected Port:** Port 6379 exposed without authentication
- **No Access Control:** Anyone can connect and read/modify data
- **In-Memory Persistence:** No encryption at rest
- **Network Exposure:** No TLS encryption by default (pre-6.0)

### Real-World Impact
- Exposure of sensitive cached data
- Session hijacking (if sessions stored in Redis)
- Database credential leakage
- Service unavailability (via data deletion)

---

## 🔧 Tools & Commands Used

**Scanning & Enumeration:**
- `nmap` - Port scanning and service detection
- `redis-cli` - Redis command-line interface

**Key Redis Commands:**
```bash
# Connection
redis-cli -h <hostname> -p 6379

# Information
info                    # Server statistics
ping                    # Test connectivity
config get *            # View configuration

# Database Navigation
select <database>       # Switch database
dbsize                  # Count keys

# Key Operations
keys *                  # List all keys
get <key>               # Get value by key
del <key>               # Delete key
type <key>              # Check data type

# String Operations
set <key> <value>       # Store value
append <key> <value>    # Append to string
```

---

## 📚 Key Learnings

1. **Redis Fundamentals**
   - In-memory data structure store
   - Key-value database with multiple data types
   - Extremely fast access compared to traditional databases
   - Requires persistent backing to prevent data loss

2. **Service Enumeration**
   - Default port discovery (6379)
   - Service identification through version banners
   - Understanding service-specific protocols and commands

3. **Security Best Practices**
   - Enable authentication with strong passwords
   - Bind Redis to localhost only (unless remote access needed)
   - Use firewall rules to restrict access
   - Keep Redis updated to latest version
   - Monitor for unauthorized access attempts

4. **Database Structure**
   - Multiple databases for data organization
   - Keyspace statistics reveal data volume
   - Pattern matching for key enumeration
   - Data type awareness for proper value retrieval

---

## 📞 Metadata

**Machine Completed:** December 29, 2025
**Status:** ✅ All Tasks Completed (10/10)
**Difficulty Assessment:** Very Easy - Introductory service enumeration
**Time Investment:** 15-30 minutes for complete walkthrough
**Retirement Status:** Retired (no longer actively updated)

**Next Steps:**
- Explore Redis persistence mechanisms (RDB, AOF)
- Study Redis security configurations
- Learn about Redis clustering and replication
- Practice with other retired machines

---

[← Back to Very Easy Machines](../readme.md) | [← Back to HTB Root](../../readme.md)

---

## Completion Badge
<a href="https://labs.hackthebox.com/achievement/machine/2991649/472" target="_blank">HTB Achievement - Redeemer</a>

---

**Disclaimer:** This write-up is for educational purposes. Analysis was conducted in an authorized lab environment provided by HackTheBox.
