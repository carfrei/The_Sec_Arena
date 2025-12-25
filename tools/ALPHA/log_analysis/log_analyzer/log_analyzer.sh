#!/bin/bash
# Log Analyzer - Generic log pattern extraction and analysis tool
# Usage: ./log_analyzer.sh -f <log_file> -p <pattern> [options]

set -euo pipefail

show_usage() {
    cat << 'EOF'
Log Analyzer - Extract and analyze patterns in log files

Usage: log_analyzer.sh -f <log_file> -p <pattern> [options]

Required:
  -f, --file FILE           Log file to analyze
  -p, --pattern PATTERN     Search pattern (regex or literal)

Options:
  -c, --context LINES       Lines of context before/after (default: 0, must be >= 0)
  -C, --count               Count matching lines
  -s, --stats               Show statistics (count, first/last)
  -e, --extract FIELD       Extract field N (1-based, must be > 0)
  -u, --unique              Show only unique values
  -h, --help                Show this help

Examples:
  log_analyzer.sh -f /var/log/auth.log -p "Failed password" -C
  log_analyzer.sh -f /var/log/auth.log -p "Failed" -e 11 -u -C
  log_analyzer.sh -f /var/log/syslog -p "ERROR" -s

EOF
    exit 0
}

# Initialize
LOG_FILE=""
PATTERN=""
CONTEXT=0
COUNT=0
STATS=0
EXTRACT_FIELD=""
UNIQUE=0
ACTION_COUNT=0

# Parse arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        -f|--file)
            LOG_FILE="$2"
            shift 2
            ;;
        -p|--pattern)
            PATTERN="$2"
            shift 2
            ;;
        -c|--context)
            if ! [[ "$2" =~ ^[0-9]+$ ]]; then
                echo "Error: -c LINES must be non-negative integer, got: $2" >&2
                exit 1
            fi
            CONTEXT="$2"
            shift 2
            ;;
        -C|--count)
            COUNT=1
            ((ACTION_COUNT++))
            shift
            ;;
        -s|--stats)
            STATS=1
            ((ACTION_COUNT++))
            shift
            ;;
        -e|--extract)
            if ! [[ "$2" =~ ^[0-9]+$ ]] || [[ "$2" -lt 1 ]]; then
                echo "Error: -e FIELD must be positive integer, got: $2" >&2
                exit 1
            fi
            EXTRACT_FIELD="$2"
            ((ACTION_COUNT++))
            shift 2
            ;;
        -u|--unique)
            UNIQUE=1
            shift
            ;;
        -h|--help)
            show_usage
            ;;
        *)
            echo "Error: Unknown option: $1" >&2
            show_usage
            ;;
    esac
done

# Validate mandatory arguments
if [[ -z "$LOG_FILE" || -z "$PATTERN" ]]; then
    echo "Error: -f and -p are required" >&2
    show_usage
fi

if [[ $ACTION_COUNT -eq 0 ]]; then
    echo "Error: at least one action required (-C, -s, or -e)" >&2
    show_usage
fi

# Validate log file
if [[ ! -f "$LOG_FILE" ]]; then
    echo "Error: Log file not found: $LOG_FILE" >&2
    exit 1
fi

if [[ ! -s "$LOG_FILE" ]]; then
    echo "Error: Log file is empty: $LOG_FILE" >&2
    exit 1
fi

if [[ ! -r "$LOG_FILE" ]]; then
    echo "Error: Log file not readable: $LOG_FILE" >&2
    exit 1
fi

# Report header
echo "=== Log Analysis Report ==="
echo "File: $LOG_FILE"
echo "Pattern: $PATTERN"
[[ $CONTEXT -gt 0 ]] && echo "Context: $CONTEXT lines before/after"
echo ""

# Read log file once
if [[ $CONTEXT -gt 0 ]]; then
    matched_lines=$(grep -A "$CONTEXT" -B "$CONTEXT" "$PATTERN" "$LOG_FILE" 2>/dev/null || true)
else
    matched_lines=$(grep "$PATTERN" "$LOG_FILE" 2>/dev/null || true)
fi

# COUNT action
if [[ $COUNT -eq 1 ]]; then
    echo "[*] Matching lines:"
    count=$(echo "$matched_lines" | grep -c . || echo "0")
    echo "  Total matches: $count"
    echo ""
fi

# STATS action
if [[ $STATS -eq 1 ]]; then
    echo "[*] Statistics:"
    total=$(echo "$matched_lines" | grep -c . || echo "0")
    if [[ "$total" -gt 0 ]]; then
        first=$(echo "$matched_lines" | head -1 | awk '{print $1, $2, $3}')
        last=$(echo "$matched_lines" | tail -1 | awk '{print $1, $2, $3}')
        echo "  Total occurrences: $total"
        echo "  First: $first"
        echo "  Last: $last"
    else
        echo "  Total occurrences: 0"
    fi
    echo ""
fi

# EXTRACT action
if [[ -n "$EXTRACT_FIELD" ]]; then
    echo "[*] Extracted field #$EXTRACT_FIELD:"
    if [[ -z "$matched_lines" ]]; then
        echo "  (no matches)"
    else
        if [[ $UNIQUE -eq 1 ]]; then
            echo "$matched_lines" | awk -v field="$EXTRACT_FIELD" '{print $field}' | sort -u | head -20
        else
            echo "$matched_lines" | awk -v field="$EXTRACT_FIELD" '{print $field}' | head -20
        fi
    fi
    echo ""
fi

# Show matching lines
echo "[*] Matching lines (first 10):"
if [[ -z "$matched_lines" ]]; then
    echo "  (no matches)"
else
    echo "$matched_lines" | head -10
fi
