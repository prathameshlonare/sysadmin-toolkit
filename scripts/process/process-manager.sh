#!/bin/bash

# process-monitor.sh - Process monitoring and management
# Usage: ./process-monitor.sh [process_name] [--kill <pid>]

set -e

# --- Help function ---
show_help() {
    echo "Usage: $0 [COMMAND] [OPTIONS]"
    echo ""
    echo "Process monitoring and management tool."
    echo ""
    echo "Commands:"
    echo "  list          Show top processes by CPU/MEM (default)"
    echo "  tree          Show process tree"
    echo "  search NAME   Search for a process by name"
    echo "  kill PID      Kill a process gracefully (SIGTERM then SIGKILL)"
    echo "  services      List running systemd services"
    echo "  failed        Show failed systemd services"
    echo "  uptime        Show system uptime and CPU cores"
    echo ""
    echo "Options:"
    echo "  -h, --help    Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0                     # Show top processes"
    echo "  $0 search nginx        # Find nginx processes"
    echo "  $0 kill 1234           # Kill process 1234"
    echo "  $0 --help              # Show help"
}

# --- Parse arguments ---
if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    show_help
    exit 0
fi

ACTION=${1:-"list"}
ARG=${2:-""}

ACTION=${1:-"list"}
ARG=${2:-""}

echo "====================================="
echo " Process Monitor"
echo "====================================="

case "$ACTION" in
    list|ps)
        echo ""
        echo "[1] TOP PROCESSES BY CPU"
        echo "-------------------------------------"
        ps aux --sort=-%cpu 2>/dev/null | head -11

        echo ""
        echo "[2] TOP PROCESSES BY MEMORY"
        echo "-------------------------------------"
        ps aux --sort=-%mem 2>/dev/null | head -11
        ;;

    tree)
        echo ""
        echo "PROCESS TREE"
        echo "-------------------------------------"
        ps auxf 2>/dev/null | head -30 || pstree -p 2>/dev/null | head -30
        ;;

    search)
        if [ -z "$ARG" ]; then
            echo "Usage: $0 search <process_name>"
            exit 1
        fi
        echo ""
        echo "SEARCHING FOR: $ARG"
        echo "-------------------------------------"
        ps aux | grep "$ARG" | grep -v grep
        ;;

    kill)
        if [ -z "$ARG" ]; then
            echo "Usage: $0 kill <pid>"
            exit 1
        fi
        echo ""
        echo "PROCESS INFO (PID: $ARG)"
        echo "-------------------------------------"
        ps -p "$ARG" -o pid,ppid,user,%cpu,%mem,cmd 2>/dev/null

        echo ""
        echo "KILLING PROCESS $ARG"
        echo "-------------------------------------"
        kill -15 "$ARG" 2>/dev/null && echo "Sent SIGTERM to $ARG" || echo "Failed to kill $ARG"
        sleep 2
        kill -0 "$ARG" 2>/dev/null && echo "Process still alive, sending SIGKILL..." && kill -9 "$ARG" 2>/dev/null || echo "Process terminated"
        ;;

    services)
        echo ""
        echo "RUNNING SERVICES"
        echo "-------------------------------------"
        systemctl list-units --type=service --state=running 2>/dev/null | head -15 || echo "systemctl not available"
        ;;

    failed)
        echo ""
        echo "FAILED SERVICES"
        echo "-------------------------------------"
        systemctl --failed 2>/dev/null || echo "systemctl not available"
        ;;

    uptime)
        echo ""
        echo "SYSTEM UPTIME & LOAD"
        echo "-------------------------------------"
        uptime
        echo ""
        echo "CPU INFO:"
        nproc 2>/dev/null && echo " cores"
        ;;

    *)
        echo "Usage: $0 [list|tree|search|kill|services|failed|uptime]"
        echo ""
        echo "Commands:"
        echo "  list          Show top processes (default)"
        echo "  tree          Show process tree"
        echo "  search <name> Search for a process"
        echo "  kill <pid>    Kill a process gracefully"
        echo "  services      List running services"
        echo "  failed        Show failed services"
        echo "  uptime        Show system uptime and load"
        echo "Unknown command: $ACTION"
        echo "Use '$0 --help' for usage"
        exit 1
        ;;
esac

echo ""
echo "====================================="
echo "  DONE"
echo "====================================="
