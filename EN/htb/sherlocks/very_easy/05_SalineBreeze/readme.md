# HackTheBox Sherlock: SalineBreeze-1
[← Back to Very Easy Sherlocks](../readme.md) | [← Back to HTB Root](../../readme.md)

**Difficulty:** Very Easy ⭐ | **Category:** Threat Intelligence & MITRE ATT&CK Analysis  
**Status:** ✅ **COMPLETE** (20/20 tasks)

---

## Challenge Overview

Threat intelligence analysis of Salt Typhoon, a sophisticated nation-state cyber espionage group. Investigation focuses on tactics, techniques, procedures (TTPs), malware artifacts, and attribution across multiple security research publications.

**Key Focus Areas:**
- Nation-state threat actor attribution
- MITRE ATT&CK framework mapping
- Malware analysis and custom tools
- CVE and vulnerability research
- Infrastructure and C&C analysis
- Registry persistence techniques

---

## Scenario

As a junior threat intelligence analyst facing budget constraints, you're tasked with conducting comprehensive research on Salt Typhoon. Your findings must leverage MITRE ATT&CK framework to fortify organizational defenses against this nation-state adversary.

---

## Questions & Answers

### ✅ Task 1: Suspected Nation-State Origin
**Q:** Starting with the MITRE ATT&CK page, which country is thought be behind Salt Typhoon?  
**A:** `China`

**Analysis:** MITRE ATT&CK attribution data indicates Chinese state sponsorship for Salt Typhoon operations.

---

### ✅ Task 2: Active Since Year
**Q:** According to that page, Salt Typhoon has been active since at least when? (Year)  
**A:** `2019`

**Analysis:** MITRE ATT&CK timeline shows Salt Typhoon operational activity beginning in 2019, indicating nearly 5+ years of sustained espionage operations.

---

### ✅ Task 3: Target Infrastructure Type
**Q:** What kind of infrastructure does Salt Typhoon target?  
**A:** `Network`

**Analysis:** Salt Typhoon focuses on critical network infrastructure, particularly telecommunications and government networks for signals intelligence gathering.

---

### ✅ Task 4: Custom Malware S1206
**Q:** Salt Typhoon has been associated with multiple custom built malware, what is the name of the malware associated with the ID S1206?  
**A:** `JumbledPath`

**Analysis:** JumbledPath (S1206) represents a custom-developed tool in Salt Typhoon's malware arsenal, suggesting sophisticated development capabilities.

---

### ✅ Task 5: JumbledPath Target OS
**Q:** What operating system does this malware target?  
**A:** `Linux`

**Analysis:** JumbledPath targets Linux systems, indicating focus on compromising network infrastructure and server assets running Linux-based operating systems.

---

### ✅ Task 6: JumbledPath Programming Language
**Q:** What programming language is the malware written in?  
**A:** `GO`

**Analysis:** Written in Go, suggesting modern development practices and potential cross-platform compatibility. Go enables compilation to various architectures and operating systems.

---

### ✅ Task 7: Network Sniffer Vendor
**Q:** On which vendor's devices does the malware act as a network sniffer?  
**A:** `Cisco`

**Analysis:** JumbledPath specifically functions as a network sniffer on Cisco network devices, enabling traffic interception and signals intelligence collection on enterprise networks.

**MITRE ATT&CK:** T1040 - Traffic Sniffing

---

### ✅ Task 8: Indicator Removal MITRE ID
**Q:** The malware can perform 'Indicator Removal' by erasing logs. What is the MITRE ATT&CK ID for this?  
**A:** `T1070.002`

**Analysis:** 
- **T1070.002:** Indicator Removal - Clear Log Files
- Malware erases logs to remove traces of intrusion
- Critical anti-forensics technique used for persistence

---

### ✅ Task 9: Picus Security Blog - Sophos CVE
**Q:** On December 20th, 2024, Picus Security released a blog on Salt Typhoon detailing some of the CVEs associated with the threat actor. What was the CVE for the vulnerability related to the Sophos Firewall?  
**A:** `CVE-2022-3236`

**Analysis:** This Sophos Firewall vulnerability was actively exploited by Salt Typhoon to establish initial access to network infrastructure.

**Severity:** Critical - Remote Code Execution (RCE) on firewall appliances

---

### ✅ Task 10: Crowdoor Persistence Registry Key
**Q:** The blog demonstrates how the group modifies the registry to obtain persistence with a backdoor known as Crowdoor. Which registry key do they target?  
**A:** `HKCU\Software\Microsoft\Windows\CurrentVersion\Run`

**Analysis:** Crowdoor uses standard Windows Run registry key for user-level persistence, ensuring malware executes on every system restart.

**Technique:** AutoRun key modification - classic Windows persistence mechanism

---

### ✅ Task 11: Registry Modification MITRE ID
**Q:** What is the MITRE ATT&CK ID of the previous technique?  
**A:** `T1112`

**Analysis:**
- **T1112:** Modify Registry
- Salt Typhoon modifies Windows registry to maintain persistence
- Specifically targets Run keys for automatic execution

---

### ✅ Task 12: TrendMicro Blog Threat Actor Name
**Q:** On November 25th, 2024, TrendMicro published a blog post detailing the threat actor. What name does this blog primarily use to refer to the group?  
**A:** `Earth Estries`

**Analysis:** TrendMicro uses the name "Earth Estries" for this Chinese APT group, demonstrating multiple naming conventions in threat intelligence community (Salt Typhoon / FusionTyphoon / Earth Estries).

---

### ✅ Task 13: Multi-Modular Backdoor Malware
**Q:** The blog post identifies additional malware attributed to the threat actor. Which malware do they describe as a 'multi-modular backdoor...using a custom protocol protected by Transport Layer Security'  
**A:** `GhostSpider`

**Analysis:** GhostSpider represents advanced custom backdoor with:
- Modular architecture for flexibility
- Custom C&C protocol
- TLS encryption for secure communications
- Post-exploitation persistence capability

---

### ✅ Task 14: .dev TLD Domain
**Q:** Most of the domains the malware communicates with have a .com top-level domain. One uses a .dev TLD. What is the full domain name for the .dev TLD?  
**A:** `telcom.grishamarkovgf8936.workers.dev`

**Analysis:** Use of Cloudflare Workers (.workers.dev) subdomain suggests:
- C&C infrastructure obfuscation
- Leveraging legitimate cloud services for command and control
- Domain naming appears intentionally confusing (Grishamarkov reference)

**IOC:** telcom.grishamarkovgf8936.workers.dev

---

### ✅ Task 15: First GET Request Filename
**Q:** What is the filename for the first GET request to the C&C server used by the malware?  
**A:** `index.php`

**Analysis:** Standard web shell pattern where malware makes initial reconnaissance request to `index.php`, likely receiving configuration or command instructions.

---

### ✅ Task 16: Kaspersky Securelist Threat Actor Name (2021)
**Q:** On September 30th, 2021, a blog post was released on Securelist by Kaspersky. What was the threat actor's name at that time?  
**A:** `GhostEmperor`

**Analysis:** Earlier Kaspersky research referred to this group as "GhostEmperor," demonstrating:
- Evolution of threat actor naming over time
- Different organizations use different naming conventions
- Same APT group has multiple identities (Salt Typhoon / Earth Estries / GhostEmperor)

---

### ✅ Task 17: Demodex Malware
**Q:** What is the name of the malware that this article focuses on?  
**A:** `Demodex`

**Analysis:** Demodex represents a sophisticated malware component used by GhostEmperor/Salt Typhoon for establishing persistent backdoor access and executing post-exploitation activities.

---

### ✅ Task 18: Demodex Malware Type
**Q:** What type of malware is the above malware?  
**A:** `Rootkit`

**Analysis:** 
- **Type:** Rootkit (kernel-level malware)
- Provides privileged access to system internals
- Enables sophisticated hiding of malicious artifacts
- Difficult to detect and remove

**Significance:** Rootkit capability indicates advanced development and nation-state level sophistication

---

### ✅ Task 19: PowerShell Dropper Encryption
**Q:** The first stage consists of a malicious PowerShell dropper. What type of encryption is used to obfuscate the code?  
**A:** `AES`

**Analysis:**
- **First Stage:** PowerShell dropper
- **Obfuscation:** AES encryption
- **Purpose:** Bypass signature-based detection and YARA rules
- **Technique:** Common in nation-state malware to evade security controls

---

### ✅ Task 20: IOCTL Code for Service Hiding
**Q:** The malware uses Input/Output Control codes to perform various tasks related to hiding malicious artifacts. What is the IOCTL code used by the malware to hide its service from the list within the services.exe process address space?  
**A:** `0x220300`

**Analysis:**
- **IOCTL:** 0x220300
- **Purpose:** Hide malware service from services.exe enumeration
- **Technique:** Direct kernel driver communication to manipulate process memory
- **Impact:** Prevents detection through standard service listing tools

**MITRE ATT&CK:** T1112 (Modify Registry) / T1562.004 (Disable or Modify Security Tools)

---

## 🌍 Threat Actor Attribution Summary

| Identifier | Source | Organization | Year |
|-----------|--------|---------------|------|
| **Salt Typhoon** | Public naming | NSA/CISA | 2024 |
| **Earth Estries** | TrendMicro | TrendMicro | 2024 |
| **GhostEmperor** | Securelist | Kaspersky | 2021 |
| **FusionTyphoon** | Alternative | Microsoft | 2024 |

**Confirmed Attribution:** China-sponsored APT group active since 2019

---

## 🔧 Malware Arsenal

| Malware | Type | Target OS | Key Feature |
|---------|------|-----------|------------|
| **JumbledPath** (S1206) | Network Sniffer | Linux (Cisco) | Traffic interception |
| **Crowdoor** | Backdoor | Windows | Registry persistence |
| **GhostSpider** | Multi-module Backdoor | Multi-OS | TLS C&C protocol |
| **Demodex** | Rootkit | Windows | Kernel-level hiding |

---

## 🛡️ Defense & Mitigation

### Detection Strategy
```bash
# Monitor for suspicious registry modifications
Monitor HKCU\Software\Microsoft\Windows\CurrentVersion\Run

# Watch for IOCTL codes
Monitor kernel drivers for 0x220300 IOCTL calls

# Detect AES-encrypted PowerShell dropper
Search event logs for suspicious PowerShell execution

# Network IOC monitoring
Monitor for connections to: telcom.grishamarkovgf8936.workers.dev
Monitor for index.php requests from suspicious clients
```

### Mitigation Controls
1. **Patch Management:** Apply CVE-2022-3236 and related firewall patches
2. **Registry Monitoring:** Alert on Run key modifications
3. **Process Monitoring:** Monitor for hidden services
4. **Network Segmentation:** Isolate critical infrastructure
5. **EDR Deployment:** Endpoint detection and response for rootkit detection

---

## 📊 MITRE ATT&CK Mapping

| Technique ID | Technique | Salt Typhoon Usage |
|--------------|-----------|-------------------|
| T1040 | Traffic Sniffing | JumbledPath on Cisco devices |
| T1070.002 | Clear Log Files | Log erasure for anti-forensics |
| T1112 | Modify Registry | Crowdoor persistence |
| T1562.004 | Disable/Modify Security Tools | Service hiding (0x220300 IOCTL) |

---

## 🔍 Research Timeline

- **Sep 30, 2021:** Kaspersky publishes GhostEmperor/Demodex research
- **2019+:** Salt Typhoon operational activity observed
- **Nov 25, 2024:** TrendMicro releases Earth Estries blog
- **Dec 20, 2024:** Picus Security publishes comprehensive CVE analysis

---

## 📚 Key Learnings

1. **Attribution Challenges**
   - Multiple names for same actor indicate attribution complexity
   - Different organizations may use different identities
   - Requires cross-referencing multiple threat intelligence sources

2. **Nation-State Sophistication**
   - Custom malware development (JumbledPath, Demodex, GhostSpider)
   - Advanced kernel-level techniques (rootkit implementation)
   - Long campaign duration (2019-present) indicates sustained resources

3. **Infrastructure Targeting**
   - Critical focus on network infrastructure (Cisco devices)
   - Firewall compromise for deep network access
   - Network sniffing for signals intelligence collection

4. **Persistence Mechanisms**
   - Multiple persistence techniques (registry, kernel drivers, hidden services)
   - Redundancy suggests well-resourced operation
   - Anti-forensics (log deletion) indicates operational security awareness

---

## 📞 Metadata

**Challenge Completed:** December 29, 2025
**Status:** ✅ All Tasks Completed (20/20)
**Difficulty Assessment:** Very Easy - Threat intelligence research fundamentals
**Time Investment:** Appropriate for MITRE ATT&CK framework and threat actor research

**Next Steps:**
- Research additional Salt Typhoon/Earth Estries campaigns
- Study nation-state TTPs deeper
- Develop detection signatures for identified IOCs
- Analyze rootkit techniques and defenses

---

[← Back to Very Easy Sherlocks](../readme.md) | [← Back to HTB Root](../../readme.md)

---

## Completion Badge
<a href="https://labs.hackthebox.com/achievement/sherlock/2991649/979" target="_blank">HTB Achievement - SalineBreeze-1</a>

---

**Disclaimer:** This write-up is for educational purposes. Analysis was conducted in an authorized lab environment provided by HackTheBox.
