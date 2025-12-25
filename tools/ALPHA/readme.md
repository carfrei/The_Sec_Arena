# ALPHA - Experimental & Development

Tools in this stage are **functional but untested in production environments**. Use for learning, testing, and feedback only.

## Status Criteria

**ALPHA tools:**
- ✅ Code complete and functional
- ✅ Documentation present
- ✅ Known limitations documented
- ❌ NOT tested on target OS (Parrot OS 6.4)
- ❌ NOT used in real scenarios
- ❌ No feedback from users
- ❌ Potential bugs or edge cases

## Tools

### [Log Analysis Suite](log_analysis/)

Defensive tools for SSH brute-force detection and generic log parsing.

- **Status**: ALPHA (ready for testing)
- **Testing needed**: Full execution on Parrot OS 6.4
- **Known issues**: See individual tool READMEs

## Promotion Criteria (ALPHA → BETA)

Tools move to BETA when:
1. ✅ Tested successfully on Parrot OS 6.4
2. ✅ No crashes or unexpected behavior
3. ✅ Output validated against real logs
4. ✅ Minor bugs (if any) documented
5. ✅ Used in at least one real scenario

## How to Test

1. **Prerequisites:**
   ```bash
   chmod +x log_analysis/*/
   *.sh
   ```

2. **Test brute_force_checker:**
   ```bash
   sudo ./log_analysis/brute_force_checker/brute_force_checker.sh /var/log/auth.log
   ```

3. **Test log_analyzer:**
   ```bash
   ./log_analysis/log_analyzer/log_analyzer.sh -f /var/log/auth.log -p "Failed" -C
   ```

4. **Report findings:**
   - Note any errors, crashes, or unexpected output
   - Performance on large files (>10MB)
   - Field extraction accuracy on your system

## Feedback

Report issues or suggestions for each tool in its own README under "Known Issues" section.

---

**Last Updated:** December 25, 2025
