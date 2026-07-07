#!/bin/bash

# monitor-services.sh — Monitor and auto-restart failed systemd services
# Usage: sudo ./monitor-services.sh [service1] [service2] ...
# If no services specified, monitors all enabled services

LOG_FILE="/var/log/service-monitor.log"

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

check_service() {
    local service="$1"
    local status
    status=$(systemctl is-active "$service" 2>/dev/null)

    if [ "$status" = "failed" ]; then
        log "ALERT: $service is failed. Attempting restart..."
        systemctl restart "$service" 2>/dev/null
        sleep 2
        local new_status
        new_status=$(systemctl is-active "$service" 2>/dev/null)
        if [ "$new_status" = "active" ]; then
            log "OK: $service restarted successfully."
        else
            log "CRITICAL: $service restart failed. Status: $new_status"
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

    if [ $# -eq 0 ]; then
        log "No services specified. Listing all failed services..."
        show_all_failed
        echo "Monitoring all failed services..."
        mapfile -t failed_services < <(systemctl list-units --type=service --state=failed --no-legend --no-pager | awk '{print $1}')
        for service in "${failed_services[@]}"; do
            check_service "$service"
        done
    else
        for service in "$@"; do
            check_service "$service"
        done
    fi

    log "Service monitor completed."
}

main "$@"
