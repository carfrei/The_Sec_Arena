# Security Learning Resources

Curated list of references and resources for security research and challenges.

---

## 🎓 Learning Platforms

### Hands-On Practice
- **HackTheBox** - https://www.hackthebox.com/
  - Sherlocks (forensics), Machines (pentesting), Challenges (programming)
  - Difficulty: Beginner to Expert
  
- **OverTheWire** - https://overthewire.org/wargames/
  - Bandit (Linux), Natas (web), Leviathan (privesc), Krypton (crypto)
  - Difficulty: Beginner to Intermediate
  
- **PicoCTF** - https://picoctf.org/
  - Annual CTF with practice challenges
  - Web, reverse engineering, forensics, cryptography, binary exploitation
  
- **VulnHub** - https://www.vulnhub.com/
  - 500+ vulnerable VMs for download
  - Realistic penetration testing scenarios
  
- **TryHackMe** - https://tryhackme.com/
  - Guided learning paths
  - Linux, web security, networking

### Concepts & Theory
- **PortSwigger Web Security Academy** - https://portswigger.net/web-security
  - Free web security training with labs
  - OWASP Top 10 coverage
  
- **Cybrary** - https://www.cybrary.it/
  - Security certifications and courses
  
- **Coursera/edX** - Security specializations
  - University-level security education

---

## 🛠️ Reference & Tools

### Exploitation
- **Metasploit Framework** - https://www.metasploitmodule.com/
  - Exploitation tool and database
  
- **Searchsploit** - https://www.exploit-db.com/
  - Searchable exploit database
  
- **OWASP ZAP** - https://www.zaproxy.org/
  - Web application security scanner
  
- **Burp Suite** - https://portswigger.net/burp/
  - Professional web security testing (community edition free)

### Network Tools
- **Nmap** - https://nmap.org/
  - Network discovery and security auditing
  
- **Wireshark** - https://www.wireshark.org/
  - Network packet analyzer
  
- **netcat/ncat** - TCP/UDP network utility

### Cryptography
- **CyberChef** - https://gchq.github.io/CyberChef/
  - Encoding/decoding and crypto operations
  
- **John the Ripper** - https://www.openwall.com/john/
  - Password cracking tool
  
- **Hashcat** - https://hashcat.net/hashcat/
  - GPU-accelerated password recovery

### Reverse Engineering
- **Ghidra** - https://ghidra-sre.org/
  - Software reverse engineering suite (free, NSA)
  
- **IDA Free** - https://www.hex-rays.com/ida-free/
  - Binary code analysis
  
- **Radare2** - https://rada.re/
  - Unix-like reverse engineering tool
  
- **Strings/Objdump** - Built into Linux tools

### Scripting & Automation
- **Python** - https://www.python.org/
  - Libraries: requests, beautifulsoup4, paramiko, pycryptodome
  
- **Bash** - Linux shell scripting
  
- **PowerShell** - Windows automation

---

## 📚 Documentation & References

### Security Standards
- **OWASP Top 10** - https://owasp.org/www-project-top-ten/
  - Top web application vulnerabilities
  
- **MITRE ATT&CK** - https://attack.mitre.org/
  - Adversary tactics and techniques
  
- **PTES** - Penetration Testing Execution Standard
  - Pentesting methodology
  
- **CIS Controls** - https://www.cisecurity.org/
  - Security best practices

### Knowledge Bases
- **HackTricks** - https://book.hacktricks.xyz/
  - Penetration testing tricks and techniques
  
- **GTFOBins** - https://gtfobins.github.io/
  - Unix binaries that can be exploited
  
- **LOLBAS** - https://lolbas-project.github.io/
  - Living off the land binaries
  
- **PayloadsAllTheThings** - https://github.com/swisskyrepo/PayloadsAllTheThings
  - Payload repository for different vulnerabilities

### Vulnerability Databases
- **CVE Details** - https://www.cvedetails.com/
  - Vulnerability statistics and info
  
- **Exploit-DB** - https://www.exploit-db.com/
  - Public exploits database
  
- **SecurityFocus** - https://www.securityfocus.com/
  - Security vulnerabilities and patches

---

## 🔒 Certifications

### Entry-Level
- **CompTIA Security+** - General security foundation
- **CompTIA Network+** - Networking fundamentals
- **CEH (Certified Ethical Hacker)** - Broad ethical hacking overview

### Intermediate
- **OSCP (Offensive Security Certified Professional)** - Hands-on penetration testing
- **eLearnSecurity eJPT** - Junior pentester
- **CompTIA PenTest+** - Penetration testing

### Advanced
- **OSEP (Offensive Security Web Expert)** - Web exploitation
- **GPEN (GIAC Penetration Tester)** - Advanced pentesting
- **OSCE (Offensive Security Web Expert)** - Advanced exploitation

---

## 👥 Communities

### Forums & Discussion
- **HackTheBox Forums** - https://forum.hackthebox.com/
- **Reddit r/cybersecurity** - https://reddit.com/r/cybersecurity/
- **Reddit r/learnprogramming** - https://reddit.com/r/learnprogramming/
- **Stack Exchange** - https://security.stackexchange.com/

### Social & News
- **Twitter/X Security Community** - Follow: @LiveOverflow, @JohnHammondSec
- **YouTube Channels:**
  - Live Overflow (detailed walkthroughs)
  - John Hammond (CTF and security)
  - IppSec (HTB walkthroughs)

### Bug Bounty Platforms
- **HackerOne** - https://www.hackerone.com/
- **Bugcrowd** - https://www.bugcrowd.com/
- **Intigriti** - https://www.intigriti.com/
- **Yeswehack** - https://yeswehack.com/

---

## 📖 Books & Articles

### Recommended Books
- "The Web Application Hacker's Handbook" - Stuttard & Pinto
- "Web Security Testing Cookbook" - Jovanovic & Nospor
- "Practical Malware Analysis" - Michael Sikorski
- "Hacking: The Art of Exploitation" - Jon Erickson

### Online Articles
- **OWASP Blog** - https://owasp.org/blog/
- **Portswigger Blog** - https://portswigger.net/blog
- **TargetedBlog** - https://targetedblogs.blogspot.com/

---

## 🔧 Quick Reference

### Common Commands

**Network Discovery**
```bash
nmap -sV -p- target.com
nmap -A -T4 192.168.1.0/24
```

**Web Testing**
```bash
curl -v http://target.com
burp suite [GUI]
```

**File Analysis**
```bash
strings binary_file
file target_file
hexdump -C target_file
```

**Cryptography**
```bash
echo "text" | md5sum
openssl enc -d -aes-256-cbc -in encrypted_file
```

---

## 🆘 Getting Help

### When Stuck
1. Review the [METHODOLOGY.md](METHODOLOGY.md)
2. Check platform-specific write-ups (after trying)
3. Read tool documentation
4. Search security forums
5. Try different approaches

### Ethical Reminder
- Always have authorization before testing
- Respect intellectual property
- Disclose vulnerabilities responsibly
- Use knowledge for defense, not harm

---

## 📝 Last Updated
December 25, 2025

## Contribution
Have great resources? Submit them via pull request!
