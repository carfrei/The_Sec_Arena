# Security Glossary

Quick reference for common security terms used in The Sec Arena.

---

## A

**API** - Application Programming Interface  
Defined method for software applications to communicate and share data.

**Attack Surface**  
All points where an attacker could potentially gain entry to a system.

**Authentication**  
Process of verifying identity (who you are).

**Authorization**  
Process of determining permissions (what you can do).

---

## B

**Binary Exploitation**  
Attacking compiled executables to gain unauthorized access or code execution.

**Blind SQLi** - Blind SQL Injection  
SQL injection where error messages aren't visible; uses timing or boolean-based inference.

**Brute Force**  
Attempting all possible combinations to crack a password or key.

**Buffer Overflow**  
Writing data beyond the allocated buffer, corrupting adjacent memory.

---

## C

**Command Injection**  
Inserting arbitrary commands into application input that gets executed by the system.

**CSRF** - Cross-Site Request Forgery  
Attack where user unknowingly performs unintended actions on another site.

**Cryptanalysis**  
Study of breaking cryptographic systems without the key.

**CVE** - Common Vulnerabilities and Exposures  
Unique identifier for publicly known security vulnerabilities.

---

## D

**Deserialization**  
Converting stored/transmitted data back into an object (can be exploited).

**DLL Injection**  
Injecting malicious code into a running process (Windows).

**DoS** - Denial of Service  
Attack designed to make a service unavailable.

---

## E

**Encryption**  
Converting plaintext to ciphertext using an algorithm and key (reversible).

**Enumeration**  
Systematic gathering of information about a target system or network.

**Exploit**  
Code/method that takes advantage of a vulnerability.

**Exposure**  
Unintended disclosure of sensitive information.

---

## F

**Forensics**  
Investigation of digital systems to recover evidence or understand what happened.

**FSOP** - File Structure Overwrite Pointer  
Advanced exploitation technique targeting FILE structure in glibc.

---

## G

**Gadget Chain**  
Sequence of code snippets used in ROP (Return-Oriented Programming) attacks.

**Generic Publicly Available Exploit**  
Ready-made exploit code available to attackers.

---

## H

**Hash Function**  
One-way function that converts input to fixed-size output (non-reversible in theory).

**Heap Overflow**  
Buffer overflow in heap memory instead of stack.

**Horizontal Privilege Escalation**  
Gaining access to same privilege level as another user (lateral movement).

---

## I

**IOC** - Indicator of Compromise  
Evidence that a system has been breached (IP addresses, file hashes, domains).

**Integer Overflow**  
When integer exceeds maximum value, causing unexpected behavior.

**IDS** - Intrusion Detection System  
Network monitoring system that alerts on suspicious activity.

---

## J

**JWT** - JSON Web Token  
Token-based authentication mechanism used in web applications.

---

## K

**Kerberos**  
Network authentication protocol (commonly used in Windows domains).

---

## L

**LDAP** - Lightweight Directory Access Protocol  
Protocol for accessing directory services (like Active Directory).

**Log Analysis**  
Examining system/application logs to identify patterns or incidents.

---

## M

**MFA** - Multi-Factor Authentication  
Using multiple authentication methods (password + phone, etc).

**MITM** - Man-In-The-Middle  
Attack where attacker intercepts communication between two parties.

**Malware**  
Malicious software designed to harm or exploit a system.

---

## N

**NoSQL Injection**  
Injecting malicious queries into NoSQL databases (similar to SQLi).

---

## O

**OWASP** - Open Web Application Security Project  
Non-profit focused on improving web application security.

**Obfuscation**  
Making code hard to understand without changing functionality.

---

## P

**Padding Oracle**  
Exploitation technique using padding validation error messages.

**Pentesting** - Penetration Testing  
Authorized simulated attack to find vulnerabilities.

**Privilege Escalation**  
Gaining higher-level access than currently authorized.

**Payload**  
Data or code used in an exploit.

---

## Q

**Quantum Computing**  
Computing paradigm that could break current encryption (future threat).

---

## R

**RCE** - Remote Code Execution  
Ability to execute arbitrary code on a remote system.

**Reverse Engineering**  
Analyzing software/firmware to understand how it works.

**ROP** - Return-Oriented Programming  
Exploitation technique chaining gadgets to execute arbitrary code.

---

## S

**SQLi** - SQL Injection  
Inserting malicious SQL into input to manipulate database queries.

**SSTI** - Server-Side Template Injection  
Injecting template code that gets processed server-side.

**SUID** - Set User ID  
File permission allowing execution as the file owner.

**Serialization**  
Converting an object into a transmittable/storable format.

**Sandbox**  
Isolated environment to safely test untrusted code.

---

## T

**Time-Based Injection**  
Attack using time delays to infer information (blind SQLi timing).

**Traversal** (see Path Traversal)

**Two-Factor Authentication** (see MFA)

---

## U

**Unicode Normalization**  
Technique for bypassing filters using equivalent characters.

**Unauthenticated Access**  
Gaining access without valid credentials.

---

## V

**Vulnerability**  
Weakness in software that can be exploited.

**Vertical Privilege Escalation**  
Gaining access to higher privilege level (user → admin).

---

## W

**WAF** - Web Application Firewall  
Security appliance filtering HTTP/HTTPS traffic.

**Weak Cryptography**  
Using outdated or flawed encryption methods.

**XSS** - Cross-Site Scripting  
Injecting malicious JavaScript into web pages.

---

## X

**XXE** - XML External Entity  
Injecting malicious XML to read files or perform SSRF.

---

## Y

**YAML Deserialization**  
Exploiting unsafe YAML parsing to execute code.

---

## Z

**Zero-Day**  
Previously unknown vulnerability with no patch available.

**Zeroconf**  
Automatic network configuration (can expose services).

---

## Abbreviations Reference

| Abbr | Full Term |
|------|-----------|
| API | Application Programming Interface |
| CSRF | Cross-Site Request Forgery |
| CVE | Common Vulnerabilities and Exposures |
| DDoS | Distributed Denial of Service |
| DNS | Domain Name System |
| FTP | File Transfer Protocol |
| HTTP | Hypertext Transfer Protocol |
| HTTPS | HTTP Secure |
| IP | Internet Protocol |
| JWT | JSON Web Token |
| LFI | Local File Inclusion |
| MITM | Man-In-The-Middle |
| OTP | One-Time Password |
| RCE | Remote Code Execution |
| RFI | Remote File Inclusion |
| SSH | Secure Shell |
| SQL | Structured Query Language |
| SQLi | SQL Injection |
| SSL | Secure Sockets Layer |
| SSRF | Server-Side Request Forgery |
| TLS | Transport Layer Security |
| URL | Uniform Resource Locator |
| VPN | Virtual Private Network |
| WAF | Web Application Firewall |
| XSS | Cross-Site Scripting |
| XXE | XML External Entity |

---

## Related Resources

- **OWASP:** https://owasp.org/
- **MITRE ATT&CK:** https://attack.mitre.org/
- **CyberChef Help:** https://gchq.github.io/CyberChef/
- **Security+ Study Guide:** CompTIA official materials

---

## Contributing to Glossary

Found missing terms? Submit additions via pull request!

---

*Last Updated: December 25, 2025*
