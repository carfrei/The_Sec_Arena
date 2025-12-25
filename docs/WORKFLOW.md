# Workflow - How We Work

Documentación de cómo documentamos y completamos desafíos en The Sec Arena.

---

## 1. Completing a Challenge

### Phase: Reconnaissance
1. Read the challenge carefully
2. Note all questions/tasks
3. Identify required tools/knowledge
4. Plan approach

### Phase: Analysis
1. Gather evidence/logs
2. Run tools (grep, awk, custom scripts)
3. Document findings
4. Answer each question

### Phase: Verification
1. Verify all answers
2. Cross-check against other evidence
3. Ensure no logical gaps
4. Note any ambiguities

---

## 2. Documenting Work

### Write-Up Format

Each completed challenge gets a `readme.md` in its folder with:

**Header:**
```markdown
# [Challenge Name]

**Platform:** HackTheBox / TryHackMe / etc
**Difficulty:** Very Easy / Easy / Medium / Hard
**Category:** Forensics / Penetration Testing / Reverse Engineering
**Date Completed:** YYYY-MM-DD
**Time Spent:** Xh Ym
```

**Content Sections:**
```markdown
## Tasks (N/N completed)

### Task 1: [Question]
**Answer:** [Answer with evidence]
**Analysis:** [Why this is correct]

### Task 2: ...

## Timeline (if applicable)

[Events in chronological order]

## Attack Analysis

- What happened
- How attacker got in
- What was compromised
- Defenses that would have prevented it

## MITRE ATT&CK Mapping

- [Tactic]: [Technique]
- [Tactic]: [Technique]

## Key Learnings

- What you learned
- What was surprising
- What you'd do differently

## Recommendations

- Defensive measures
- Detection strategies
- Hardening steps

## Resources Used

- Tools: tool_name, tool_name
- References: [link], [link]
```

---

## 3. Tool Development

### Stages

**ALPHA:**
- ✅ Code complete
- ✅ Documentation done
- ❌ NOT tested on Parrot OS yet
- ❌ Known to have limitations
- Action: Write `readme.md` with examples and known issues

**BETA:**
- ✅ Tested on Parrot OS
- ✅ Works in real scenarios
- 🟡 Gathering feedback
- Action: Move from ALPHA/ to BETA/

**RELEASE:**
- ✅ 3+ months stable
- ✅ Positive user feedback
- ✅ Production-ready
- Action: Move from BETA/ to RELEASE/

### Tool README sections

Every tool gets a `readme.md` with:
- What it does
- How to use (with examples)
- Output explanation
- Known limitations
- Installation/requirements
- Workflows

---

## 4. Quality Standards

### Code
- ✅ Error handling (set -euo pipefail for bash)
- ✅ Input validation
- ✅ Clear variable names
- ✅ Comments on complex logic
- ✅ Proper use of tools (grep, awk, sed)

### Documentation
- ✅ Clear and complete
- ✅ Examples that work
- ✅ Honest about limitations
- ✅ Proper formatting (markdown)
- ✅ Actual evidence/screenshots where relevant

### Organization
- ✅ Consistent folder structure
- ✅ Proper file naming
- ✅ Progress tracking
- ✅ Clear status indicators

---

## 5. File Naming

```
Challenges:
  sherlocks/very_easy/01_Brutus/readme.md
  machines/easy/machine_name/readme.md

Tools:
  tools/ALPHA/tool_name/
    tool_name.sh
    readme.md

Docs:
  docs/
    WORKFLOW.md (this file)
    CONTRIBUTING.md
```

---

## 6. Progress Tracking

### Main README badges show:
- Completed vs Total for each category
- Current stage of tools
- Overall portfolio progress

### Category READMEs show:
- Progress table with dates
- Next challenges to attempt
- Skills required

---

## 7. Git Commits

```
Format: "[category] Short description"

Examples:
[sherlock] 01_Brutus - Forensics Very Easy (8/8 tasks)
[tools] brute_force_checker moved to ALPHA
[docs] Add workflow documentation
[machines] Create difficulty-based structure
```

---

**Last Updated:** December 25, 2025
