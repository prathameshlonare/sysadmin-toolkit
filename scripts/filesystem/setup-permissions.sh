#!/bin/bash

# permission-fixer.sh - File permission auditing and fixing
# Usage: ./permission-fixer.sh <path> [mode]

set -e

PATH_ARG=${1:-"."}
MODE=${2:-""}

echo "====================================="
echo " Permission Fixer: $PATH_ARG"
echo "====================================="

# 1. Show current permissions
echo ""
echo "[1] CURRENT PERMISSIONS"
echo "-------------------------------------"
ls -la "$PATH_ARG" 2>/dev/null | head -20

# 2. Permission breakdown
echo ""
echo "[2] PERMISSION BREAKDOWN"
echo "-------------------------------------"
if [ -f "$PATH_ARG" ]; then
    STAT=$(stat -c "%a %U %G" "$PATH_ARG" 2>/dev/null || stat -f "%Lp %Su %Sg" "$PATH_ARG" 2>/dev/null)
    echo "File: $PATH_ARG"
    echo "Octal: $(echo $STAT | cut -d' ' -f1)"
    echo "Owner: $(echo $STAT | cut -d' ' -f2)"
    echo "Group: $(echo $STAT | cut -d' ' -f3)"
elif [ -d "$PATH_ARG" ]; then
    echo "Directory contents:"
    stat -c "%a %U %G %n" "$PATH_ARG"/* 2>/dev/null | head -10
fi

# 3. Find problematic permissions
echo ""
echo "[3] SECURITY CHECK"
echo "-------------------------------------"
echo "World-writable files:"
find "$PATH_ARG" -type f -perm -002 2>/dev/null | head -5 || echo "None found"

echo ""
echo "SUID files:"
find "$PATH_ARG" -type f -perm -4000 2>/dev/null | head -5 || echo "None found"

echo ""
echo "SGID files:"
find "$PATH_ARG" -type f -perm -2000 2>/dev/null | head -5 || echo "None found"

# 4. Fix permissions if mode provided
if [ -n "$MODE" ]; then
    echo ""
    echo "[4] FIXING PERMISSIONS"
    echo "-------------------------------------"
    echo "Setting mode $MODE on $PATH_ARG"
    chmod -R "$MODE" "$PATH_ARG"
    echo "Done! New permissions:"
    ls -la "$PATH_ARG" | head -5
else
    echo ""
    echo "[4] USAGE TIPS"
    echo "-------------------------------------"
    echo "Common modes:"
    echo "  755  → rwxr-xr-x (scripts, executables)"
    echo "  644  → rw-r--r-- (regular files)"
    echo "  600  → rw------- (private files)"
    echo "  700  → rwx------ (private directories)"
    echo ""
    echo "Fix example: $0 $PATH_ARG 755"
fi

echo ""
echo "====================================="
echo "  DONE"
echo "====================================="