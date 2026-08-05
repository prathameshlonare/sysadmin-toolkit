#!/bin/bash

# monitor-services.sh — Monitor and auto-restart failed systemd services
# Usage: sudo ./monitor-services.sh [service1] [service2] ...

# --- Configuration ---
DRY_RUN=0
LOG_FILE="/var/log/service-monitor.log"

# --- Help function ---
show_help() {
    echo "Usage: sudo $0 [OPTIONS] [SERVICE1] [SERVICE2] ..."
    echo ""
    echo "Monitor and auto-restart failed systemd services."
    echo ""
    echo "Arguments:"
    echo "  SERVICE    Service name(s) to monitor (default: all failed services)"
    echo ""
    echo "Options:"
    echo "  -h, --help    Show this help message"
    echo "  -n, --dry-run Show what would be done without doing it"
    echo ""
    echo "Examples:"
    echo "  sudo $0                     # Check all failed services"
    echo "  sudo $0 nginx sshd          # Check specific services"
    echo "  sudo $0 --dry-run nginx     # Preview restart without doing it"
    echo "  sudo $0 -h                  # Show help"
}

# --- Parse arguments ---
SERVICES=()
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_help
            exit 0
            ;;
        -n|--dry-run)
            DRY_RUN=1
            shift
            ;;
        *)
            SERVICES+=("$1")
            shift
            ;;
    esac
done

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

check_service() {
    local service="$1"
    local status
    status=$(systemctl is-active "$service" 2>/dev/null)

    if [ "$status" = "failed" ]; then
        log "ALERT: $service is failed. Attempting restart..."
        if [ "$DRY_RUN" = 1 ]; then
            log "DRY-RUN: Would restart $service"
        else
            systemctl restart "$service" 2>/dev/null
            sleep 2
            local new_status
            new_status=$(systemctl is-active "$service" 2>/dev/null)
            if [ "$new_status" = "active" ]; then
                log "OK: $service restarted successfully."
            else
                log "CRITICAL: $service restart failed. Status: $new_status"
            fi
        fi
    elif [ "$status" = "active" ]; then
        log "OK: $service is running."
    else
        log "WARN: $service status: $status"
    fi
}

show_all_failed() {
    echo "=== Failed Services ==="
    systemctl list-units --type=service --state=failed --no-pager
    echo ""
}

main() {
    if [ "$(id -u)" -ne 0 ]; then
        echo "Error: Run as root (sudo)"
        exit 1
    fi

    log "Service monitor started."

    if [ ${#SERVICES[@]} -eq 0 ]; then
        log "No services specified. Listing all failed services..."
        show_all_failed
        echo "Monitoring all failed services..."
        mapfile -t failed_services < <(systemctl list-units --type=service --state=failed --no-legend --no-pager | awk '{print $1}')
        for service in "${failed_services[@]}"; do
            check_service "$service"
        done
    else
        for service in "${SERVICES[@]}"; do
            check_service "$service"
        done
    fi

    log "Service monitor completed."
}

main "$@"
