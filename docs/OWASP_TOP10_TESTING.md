# OWASP Top 10 Testing Checklist

Comprehensive security testing checklist based on OWASP Top 10 2021 vulnerabilities.

---

## 🔍 Pre-Assessment

- [ ] Scope defined clearly
- [ ] Authorization obtained
- [ ] Testing environment confirmed
- [ ] Tools prepared and tested
- [ ] Baseline assessment completed

---

## 1️⃣ Broken Access Control

**Description:** Users can act outside their intended permissions.

### Testing Areas
- [ ] Test direct object reference (IDOR)
  - Modify user IDs in URLs/requests
  - Access other users' data
  
- [ ] Test for missing access controls
  - Try accessing admin endpoints as regular user
  - Check forced browsing capabilities
  
- [ ] Test authorization bypass
  - Check if authentication can be bypassed
  - Test parameter manipulation
  
- [ ] Test privilege escalation
  - Regular user accessing admin functions
  - Account takeover possibilities

### Vulnerable Code Examples
```
GET /api/users/123/profile  → Try /api/users/124/profile
GET /admin → Access as regular user
```

### Findings
- [ ] Vulnerability Found: [Yes/No]
- [ ] Severity: [Critical/High/Medium/Low]
- [ ] Details: [Description]

---

## 2️⃣ Cryptographic Failures

**Description:** Data exposure due to weak encryption.

### Testing Areas
- [ ] Check for sensitive data exposure
  - Search for credentials in source code
  - Check localStorage/sessionStorage
  - Review API responses
  
- [ ] Test encryption implementation
  - Check if HTTPS is enforced
  - Look for weak cipher suites
  - Test for SSL/TLS vulnerabilities
  
- [ ] Test password hashing
  - Check password storage mechanisms
  - Look for plaintext passwords
  - Test password reset functionality

### Tools
- Burp Suite
- OWASP ZAP
- Wireshark

### Findings
- [ ] Vulnerability Found: [Yes/No]
- [ ] Severity: [Critical/High/Medium/Low]
- [ ] Details: [Description]

---

## 3️⃣ Injection

**Description:** Untrusted data sent as command or query.

### SQL Injection Testing
- [ ] Test login forms for SQLi
- [ ] Test search functionality
- [ ] Test URL parameters
- [ ] Test POST parameters
- [ ] Test file upload names

**Payloads:**
```sql
' OR '1'='1
admin' --
' UNION SELECT NULL,NULL,NULL --
```

### NoSQL Injection Testing
- [ ] Test JSON parameters
- [ ] Test MongoDB operators
- [ ] Test conditional injection

**Payload:**
```json
{"username": {"$ne": null}, "password": {"$ne": null}}
```

### Command Injection Testing
- [ ] Test for OS command execution
- [ ] Test file operations
- [ ] Test network operations

### Other Injection Types
- [ ] LDAP Injection
- [ ] XPath Injection
- [ ] Template Injection
- [ ] Expression Language Injection

### Findings
- [ ] SQL Injection: [Yes/No]
- [ ] NoSQL Injection: [Yes/No]
- [ ] Command Injection: [Yes/No]
- [ ] Other: [Yes/No]
- [ ] Severity: [Critical/High/Medium/Low]

---

## 4️⃣ Insecure Design

**Description:** Missing security controls and flawed architecture.

### Testing Areas
- [ ] Test for missing security requirements
- [ ] Review threat modeling
- [ ] Check for secure by default design
- [ ] Test multi-factor authentication
- [ ] Check account lockout mechanisms
- [ ] Test password reset functionality
- [ ] Verify rate limiting
- [ ] Check for business logic flaws

### Findings
- [ ] Vulnerability Found: [Yes/No]
- [ ] Severity: [Critical/High/Medium/Low]
- [ ] Details: [Description]

---

## 5️⃣ Security Misconfiguration

**Description:** Insecure default settings, incomplete setups.

### Testing Areas
- [ ] Test for unnecessary services running
  - [ ] Check open ports
  - [ ] Check running services
  - [ ] Check for default credentials
  
- [ ] Test for unnecessary features enabled
  - [ ] Directory listing enabled
  - [ ] Debug mode enabled
  - [ ] Stack traces in errors
  
- [ ] Test HTTP security headers
  - [ ] Content-Security-Policy
  - [ ] X-Frame-Options
  - [ ] X-Content-Type-Options
  - [ ] Strict-Transport-Security
  
- [ ] Test for exposure of sensitive information
  - [ ] robots.txt
  - [ ] .git directory
  - [ ] Backup files
  - [ ] Configuration files

### Tools
```bash
nmap -sV target_ip
curl -I target_url
```

### Findings
- [ ] Misconfiguration Found: [Yes/No]
- [ ] Severity: [Critical/High/Medium/Low]
- [ ] Details: [Description]

---

## 6️⃣ Vulnerable and Outdated Components

**Description:** Using libraries with known vulnerabilities.

### Testing Areas
- [ ] Check application dependencies
  - [ ] npm audit
  - [ ] pip check
  - [ ] composer audit
  
- [ ] Identify component versions
- [ ] Check for known CVEs
- [ ] Test for exploitable vulnerabilities

### Tools
- OWASP Dependency Check
- Snyk
- npm audit
- pip-audit

### Findings
- [ ] Vulnerable Component: [Yes/No]
- [ ] CVE Identified: [CVE-XXXX-XXXXX]
- [ ] Severity: [Critical/High/Medium/Low]

---

## 7️⃣ Authentication & Session Management Failures

**Description:** Compromised user accounts and sessions.

### Testing Areas
- [ ] Test authentication strength
  - [ ] Weak password requirements
  - [ ] Password reset vulnerabilities
  - [ ] Session fixation
  
- [ ] Test session management
  - [ ] Session timeout
  - [ ] Session invalidation
  - [ ] Session token randomness
  
- [ ] Test for account enumeration
- [ ] Test for brute force protection
- [ ] Test for cookie security
  - [ ] HttpOnly flag
  - [ ] Secure flag
  - [ ] SameSite attribute

### Tools
```bash
hydra -l admin -P wordlist.txt http-form-post
```

### Findings
- [ ] Authentication Flaw: [Yes/No]
- [ ] Session Flaw: [Yes/No]
- [ ] Severity: [Critical/High/Medium/Low]

---

## 8️⃣ Software and Data Integrity Failures

**Description:** Assumptions about software and data integrity.

### Testing Areas
- [ ] Test update mechanism
- [ ] Test for insecure CI/CD pipelines
- [ ] Test for insecure deserialization
- [ ] Test for unsigned updates

### Findings
- [ ] Vulnerability Found: [Yes/No]
- [ ] Severity: [Critical/High/Medium/Low]

---

## 9️⃣ Logging & Monitoring Failures

**Description:** Insufficient detection and response to breaches.

### Testing Areas
- [ ] Check for security logging
  - [ ] Are logins logged?
  - [ ] Are failed attempts logged?
  - [ ] Are administrative actions logged?
  
- [ ] Check for monitoring
  - [ ] Is there alerting?
  - [ ] Can suspicious activity be detected?
  - [ ] Are logs centralized?

### Findings
- [ ] Logging Issue: [Yes/No]
- [ ] Monitoring Issue: [Yes/No]
- [ ] Severity: [Critical/High/Medium/Low]

---

## 🔟 Server-Side Request Forgery (SSRF)

**Description:** Server fetches remote resource without validation.

### Testing Areas
- [ ] Test file upload functionality
- [ ] Test image processing
- [ ] Test URL input fields
- [ ] Test API endpoint parameters

### Payloads
```
http://localhost:8080
http://127.0.0.1/admin
http://169.254.169.254 (AWS metadata)
```

### Findings
- [ ] SSRF Vulnerability: [Yes/No]
- [ ] Severity: [Critical/High/Medium/Low]

---

## Summary

| # | Vulnerability | Found | Severity | Priority |
|---|---|---|---|---|
| 1 | Broken Access Control | [ ] | [ ] | [ ] |
| 2 | Cryptographic Failures | [ ] | [ ] | [ ] |
| 3 | Injection | [ ] | [ ] | [ ] |
| 4 | Insecure Design | [ ] | [ ] | [ ] |
| 5 | Security Misconfiguration | [ ] | [ ] | [ ] |
| 6 | Vulnerable Components | [ ] | [ ] | [ ] |
| 7 | Auth & Session Failures | [ ] | [ ] | [ ] |
| 8 | Software Integrity | [ ] | [ ] | [ ] |
| 9 | Logging & Monitoring | [ ] | [ ] | [ ] |
| 10 | SSRF | [ ] | [ ] | [ ] |

---

## Testing Complete

- [ ] All categories tested
- [ ] Findings documented
- [ ] Evidence collected
- [ ] Report prepared
- [ ] Recommendations provided

**Testing Date:** [Date]
**Tester:** Dr. Carfrei
**Status:** ✅ Complete

---

**Reference:** OWASP Top 10 2021
**Disclaimer:** This checklist is for authorized testing only.
