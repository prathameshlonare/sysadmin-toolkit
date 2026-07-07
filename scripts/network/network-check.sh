#!/bin/bash

# network-check.sh - Network diagnostic tool
# Usage: ./network-check.sh <host> [port]

set -e

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
