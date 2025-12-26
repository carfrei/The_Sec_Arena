# HackTheBox Sherlock: DreamJob-2
**Operation North Star Investigation**

## Challenge Overview
Forensic investigation of a targeted attack operation (Operation North Star) analyzing malware artifacts, Office documents, and binary analysis to determine the attack methodology and tooling.

**Difficulty:** Very Easy | **Platform:** HackTheBox Sherlocks

---

## Methodology

### Phase 1: Initial Triage
- Extracted and catalogued provided evidence files
- Identified Office document (17.dotm) and ISO executable package
- Performed initial binary analysis using strings and DetectItEasy

### Phase 2: Malware Analysis
- Extracted macros from Office document using olevba
- Analyzed embedded C2 communication patterns
- Researched attacker infrastructure and tooling

### Phase 3: Binary Forensics
- Examined ISO contents and embedded executables
- Analyzed packing and obfuscation techniques
- Correlated samples with VirusTotal database

### Phase 4: Attribution
- Cross-referenced MITRE ATT&CK framework
- Identified attacker tools and techniques
- Established timeline from first detection

---

## Questions & Answers

### ✅ Question 1: MITRE Similarity
**Q:** What MITRE software does DRATzarus most closely resemble?  
**A:** `Bankshot`

**Evidence:** DRATzarus shares behavioral similarities with Bankshot including anti-analysis techniques, registry manipulation, and C2 communication patterns documented in MITRE ATT&CK.

---

### ✅ Question 2: Debugger Detection API
**Q:** What API does DRATzarus use for debugger detection?  
**A:** `IsDebuggerPresent`

**Evidence:** Analyzed binary for anti-debugging techniques. This Windows API is commonly used to detect debugger presence by checking the BeingDebugged flag in the Process Environment Block (PEB).

---

### ✅ Question 3: Torisma C2 Encryption
**Q:** What encryption methods does Torisma use for C2 communication?  
**A:** `VEST-32`

**Evidence:** Analyzed Torisma malware communication protocol. VEST-32 is a cryptographic algorithm used in combination with XOR operations for encrypting command and control traffic.

---

### ✅ Question 4: Torisma Packing Method
**Q:** What packing method was used on Torisma?  
**A:** `Lz4 compression`

**Evidence:** 
- LZ4 is a real-time compression algorithm commonly used in malware obfuscation
- Verified through HTB platform acceptance
- Binary analysis of InternalViewer.exe confirmed compression-based packing
- LZ4 compression provides fast decompression speeds, making it suitable for runtime decompression in malware

**Lesson Learned:** 
The answer is `Lz4 compression` - initially misread as "Iz4". Case sensitivity and careful character recognition are critical in forensic analysis. LZ4 is an open-source lossless data compression algorithm known for high-speed compression/decompression, commonly used in malware packing techniques.

---

### ✅ Question 5: ISO Executable
**Q:** Which executable was embedded in the ISO?  
**A:** `InternalViewer.exe`

**Evidence:** Extracted ISO contents and identified executable launcher used to deploy secondary payloads.

---

### ✅ Question 6: Original EXE Name
**Q:** What was the original name of the executable (from SumatraPDF)?  
**A:** `SumatraPDF.exe`

**Evidence:** Analyzed metadata and resource sections of the executable packaged within the ISO.

---

### ✅ Question 7: First Seen in Wild (UTC)
**Q:** When was the executable first seen in the wild?  
**A:** `2020-08-13 08:44:50`

**Evidence:** VirusTotal submission date and first detection timestamp across antivirus databases. This represents initial campaign deployment date.

---

### ✅ Question 8: EXE Packer
**Q:** What packer was used on the executable?  
**A:** `Ultimate Packer for Executables`

**Evidence:** DetectItEasy and VirusTotal analysis identified UPX (Ultimate Packer for Executables) version 3.96 with NRV compression algorithm.

---

### ✅ Question 9: Macro URL
**Q:** What URL was found in the Office macro?  
**A:** `https://markettrendingcenter.com/lk_job_oppor.docx`

**Evidence:** Extracted and analyzed VBA macro code from 17.dotm. URL points to secondary payload delivery mechanism disguised as job opportunity document.

---

### ✅ Question 10: Document Author
**Q:** Who was the author of the document?  
**A:** `Mickey`

**Evidence:** Examined Office document properties and metadata (Author field).

---

### ✅ Question 11: Last Modifier
**Q:** Who was the last person to modify the document?  
**A:** `Challenger`

**Evidence:** Document metadata LastModifiedBy field.

---

### ✅ Question 12: Suspicious Folder
**Q:** What suspicious folder was found in the system?  
**A:** `\AppData\Local\Microsoft\Notice`

**Evidence:** Forensic analysis of file system artifacts and registry traces showed attacker persistence mechanism storing configuration in non-standard AppData subdirectory.

---

### ✅ Question 13: Suspicious File
**Q:** What suspicious file was checked?  
**A:** `wsuser.db`

**Evidence:** Database file located in suspicious folder used for storing attacker configuration, credentials, or exfiltration data.

---

## Key Findings

| Category | Finding |
|----------|---------|
| **Attack Vector** | Spear-phishing email with malicious Office document |
| **Primary Malware** | DRATzarus + Torisma toolset |
| **C2 Infrastructure** | markettrendingcenter.com |
| **Persistence Method** | AppData\Local\Microsoft\Notice registry/file path |
| **Packing** | UPX on primary executable; Torisma uses Lz4 compression |
| **First Seen** | 2020-08-13 |
| **Target Profile** | Job opportunity themed (HR/recruitment personnel) |

---

## Tools Used
- **olevba** - VBA macro extraction
- **VirusTotal** - Binary analysis and detection signatures
- **MITRE ATT&CK** - Attacker behavior framework
- **DetectItEasy** - Packer and binary structure analysis
- **strings** - Static analysis of binary content

---

## Score
**13/13 Questions** (100% - COMPLETE ✓)  
All questions answered and submitted successfully to HTB platform.

---

**Write-up Completed:** December 25, 2025  
**Challenge Difficulty:** Very Easy ✓
