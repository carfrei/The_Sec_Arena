# HackTheBox Sherlock: PhishNet
[← Back to Very Easy Sherlocks](../readme.md) | [← Back to HTB Root](../../readme.md)

**Difficulty:** Very Easy ⭐ | **Category:** Email Security & Phishing Analysis  
**Status:** ✅ **COMPLETE** (11/11 tasks)

---

## Challenge Overview

Email security and phishing analysis challenge. Investigation of a suspicious email to identify sender information, email headers, phishing indicators, and associated malware artifacts using email forensics techniques.

**Key Focus Areas:**
- Email header analysis
- SPF validation and email authentication
- Phishing URL identification
- Malware attachment analysis
- MITRE ATT&CK technique mapping

---

## Methodology

### Phase 1: Email Header Analysis
- Examined email headers for originating IP and mail server information
- Identified sender and reply-to addresses
- Analyzed email routing and relay information

### Phase 2: Authentication & Security
- Verified SPF (Sender Policy Framework) results
- Analyzed email authentication mechanisms
- Identified domain spoofing indicators

### Phase 3: Phishing Content Analysis
- Identified malicious URLs within email body
- Analyzed domain used in phishing links
- Determined fake company names and social engineering tactics

### Phase 4: Malware & Attachment Analysis
- Examined ZIP attachment structure
- Identified hidden/malicious files within archive
- Calculated SHA-256 hash of suspicious files
- Mapped techniques to MITRE ATT&CK framework

---

## Questions & Answers

### ✅ Task 1: Originating IP Address
**Q:** What is the originating IP address of the sender?  
**A:** `45.67.89.10`

**Analysis:** Extracted from email headers, this IP represents the source of the email transmission.

---

### ✅ Task 2: Relaying Mail Server
**Q:** Which mail server relayed this email before reaching the victim?  
**A:** `203.0.113.25`

**Analysis:** Identified from the Received headers chain, showing the intermediary mail server that processed the email.

---

### ✅ Task 3: Sender's Email Address
**Q:** What is the sender's email address?  
**A:** `finance@business-finance.com`

**Analysis:** Extracted from the From header field in the email.

---

### ✅ Task 4: Reply-To Email Address
**Q:** What is the 'Reply-To' email address specified in the email?  
**A:** `support@business-finance.com`

**Analysis:** Identified from the Reply-To header field, showing where replies would be directed.

---

### ✅ Task 5: SPF Result
**Q:** What is the SPF (Sender Policy Framework) result for this email?  
**A:** `pass`

**Analysis:** SPF validation indicates the email passed authentication checks, though domain spoofing was still possible through other means.

---

### ✅ Task 6: Phishing URL Domain
**Q:** What is the domain used in the phishing URL inside the email?  
**A:** `secure.business-finance.com`

**Analysis:** Identified malicious URL crafted to appear legitimate by mimicking the real business domain.

**MITRE ATT&CK:** T1566.001 - Phishing: Spearphishing with Attachment

---

### ✅ Task 7: Fake Company Name
**Q:** What is the fake company name used in the email?  
**A:** `Business Finance Ltd.`

**Analysis:** Social engineering tactic using legitimate-sounding entity name to increase credibility and deceive recipients.

---

### ✅ Task 8: Attachment Name
**Q:** What is the name of the attachment included in the email?  
**A:** `Invoice_2025_Payment.zip`

**Analysis:** Archive containing malicious payload disguised as legitimate invoice document.

---

### ✅ Task 9: SHA-256 Hash
**Q:** What is the SHA-256 hash of the attachment?  
**A:** `8379C41239E9AF845B2AB6C27A7509AE8804D7D73E455C800A551B22BA25BB4A`

**Analysis:** Cryptographic hash used for file identification and malware correlation in threat intelligence databases.

---

### ✅ Task 10: Malicious File Name
**Q:** What is the filename of the malicious file contained within the ZIP attachment?  
**A:** `invoice_document.pdf.bat`

**Analysis:** Double extension attack disguising executable BAT file as PDF document to trick users into execution.

**MITRE ATT&CK:** T1036.004 - Masquerading: Masquerade File Type

---

### ✅ Task 11: MITRE ATT&CK Techniques
**Q:** Which MITRE ATT&CK techniques are associated with this attack?  
**A:** `T1566.001`

**Analysis:** 
- **T1566.001:** Phishing: Spearphishing with Attachment
  - Attack relies on social engineering through deceptive email with malicious attachment
  - Uses legitimate-appearing sender and business context
  - Attachment delivery mechanism for initial compromise

---

## 🛡️ Defense & Mitigation

### Email Security Best Practices
```bash
# Implement email filtering
- Block known phishing domains
- Scan attachments with multiple AV engines
- Validate SPF/DKIM/DMARC records

# User Education
- Train users on phishing indicators
- Verify sender addresses before clicking links
- Disable automatic file extension hiding
- Suspicious file types: .bat, .exe, .scr, .vbs, etc.
```

### Technical Controls
1. **Email Gateway Filtering:** Block suspicious attachments (ZIP, BAT, EXE)
2. **URL Rewriting:** Redirect external links through monitoring service
3. **Sandbox Analysis:** Detonate suspicious attachments in isolated environment
4. **DMARC Policy:** Implement strict alignment requirements

---

## 📊 Attack Timeline

| Step | Action | Details |
|------|--------|---------|
| T+0 | Email Crafted | Fake invoice email created with legitimate branding |
| T+1 | Email Sent | Originated from 45.67.89.10, relayed through 203.0.113.25 |
| T+2 | Delivery | Email reaches victim inbox with ZIP attachment |
| T+3 | User Interaction | Victim extracts ZIP and sees "invoice_document.pdf" |
| T+4 | Malware Execution | User double-clicks file, executes BAT script |
| T+5 | System Compromise | Malware gains initial access and establishes persistence |

---

## 🔍 Phishing Indicators (IOCs)

**Email Artifacts:**
- Sender: finance@business-finance.com
- Reply-To: support@business-finance.com
- Phishing URL: secure.business-finance.com
- Originating IP: 45.67.89.10
- Relay Server: 203.0.113.25

**File Indicators:**
- Attachment: Invoice_2025_Payment.zip
- SHA-256: 8379C41239E9AF845B2AB6C27A7509AE8804D7D73E455C800A551B22BA25BB4A
- Malicious File: invoice_document.pdf.bat

---

## 🔧 Tools Used

**Email Analysis:**
- Email Header Analyzer
- SPF/DKIM/DMARC validation tools
- URL extraction and analysis

**File Analysis:**
- Archive extraction tools
- SHA-256 hashing utilities
- VirusTotal or similar threat intelligence platforms

**Frameworks:**
- MITRE ATT&CK for technique classification

---

## 📚 Key Learnings

1. **Email Header Analysis**
   - Originating IP reveals sender's actual location
   - Relay servers show email path and potential compromise points
   - Authentication results (SPF/DKIM/DMARC) indicate email legitimacy

2. **Phishing Tactics**
   - Domain spoofing (secure.business-finance.com mimics real company)
   - Social engineering (invoice context creates urgency)
   - Double extension attacks hide true file type

3. **Attachment Analysis**
   - Always check actual file type, not just extension
   - Hash correlation enables threat intelligence sharing
   - Archive contents require scanning

4. **MITRE ATT&CK Mapping**
   - T1566.001 covers phishing with attachments
   - Helps organizations understand attack patterns
   - Enables correlation with other incidents

---

## 📞 Metadata

**Challenge Completed:** December 29, 2025
**Status:** ✅ All Tasks Completed (11/11)
**Difficulty Assessment:** Very Easy - Foundational email security knowledge
**Time Investment:** Appropriate for phishing analysis fundamentals

**Next Steps:**
- Analyze more complex phishing campaigns
- Study email authentication mechanisms deeper
- Investigate malware payload analysis
- Explore social engineering patterns

---

[← Back to Very Easy Sherlocks](../readme.md) | [← Back to HTB Root](../../readme.md)

---

## Completion Badge
<a href="https://labs.hackthebox.com/achievement/sherlock/2991649/985" target="_blank">HTB Achievement - PhishNet</a>

---

**Disclaimer:** This write-up is for educational purposes. Analysis was conducted in an authorized lab environment provided by HackTheBox.
