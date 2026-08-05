#!/bin/bash

# network-check.sh - Network diagnostic tool
# Usage: ./network-check.sh <host> [port]

set -e

# --- Help function ---
show_help() {
    echo "Usage: $0 [OPTIONS] [HOST] [PORT]"
    echo ""
    echo "Network diagnostic tool - checks connectivity to a host."
    echo ""
    echo "Arguments:"
    echo "  HOST        Target hostname (default: google.com)"
    echo "  PORT        Target port (default: 80)"
    echo ""
    echo "Options:"
    echo "  -h, --help  Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0                      # Check google.com:80"
    echo "  $0 example.com          # Check example.com:80"
    echo "  $0 example.com 443      # Check example.com:443"
    echo "  $0 -h                   # Show help"
}

# --- Parse arguments ---
if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    show_help
    exit 0
fi

HOST=${1:-"google.com"}
PORT=${2:-"80"}

echo "====================================="
echo " Network Check: $HOST"
echo "====================================="

# 1. Ping test
echo ""
echo "[1] PING TEST"
echo "-------------------------------------"
ping -c 4 "$HOST" 2>/dev/null | tail -1 || echo "Ping failed - host unreachable"

# 2. DNS resolution
echo ""
echo "[2] DNS RESOLUTION"
echo "-------------------------------------"
dig +short "$HOST" 2>/dev/null || nslookup "$HOST" 2>/dev/null | grep "Address:" | tail -1 || echo "DNS resolution failed"

# 3. Port check
echo ""
echo "[3] PORT CHECK (Port $PORT)"
echo "-------------------------------------"
timeout 5 bash -c "echo >/dev/tcp/$HOST/$PORT" 2>/dev/null && echo "Port $PORT is LISTENING" || echo "Port $PORT is NOT listening"

# 4. HTTP status
echo ""
echo "[4] HTTP STATUS"
echo "-------------------------------------"
HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" --connect-timeout 5 "http://$HOST:$PORT" 2>/dev/null || echo "000")
echo "HTTP Status: $HTTP_STATUS"

echo ""
echo "====================================="
echo "  DONE"
echo "====================================="
