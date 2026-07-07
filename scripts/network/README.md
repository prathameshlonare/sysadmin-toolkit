# network-check.sh

A quick network diagnostic tool for checking connections, DNS, and ports.

---

## What Does This Script Do?

When your website or app isn't working, the problem is usually network-related. This script helps you:

1. **Test** if a server is reachable (ping)
2. **Check** if DNS is working (domain name → IP address)
3. **See** if a port is open (like port 80 for websites)
4. **Test** if HTTP is responding

---

## When Do You Need This?

- Website shows "Cannot be reached"
- API returns errors
- SSH connection fails
- You want to check if a server is online

---

## How to Use

### Step 1: Make it executable

```bash
chmod +x network-check.sh
```

### Step 2: Run it

**Check if google.com is reachable:**
```bash
./network-check.sh google.com
```

**Check if a specific port is open:**
```bash
./network-check.sh google.com 443
```

**Check your own server:**
```bash
./network-check.sh myserver.com 80
```

---

## What You'll See

```
=====================================
 Network Check: google.com
=====================================

[1] PING TEST
-------------------------------------
rtt min/avg/max/mdev = 12.3/13.1/14.2/0.8 ms

[2] DNS RESOLUTION
-------------------------------------
142.250.190.78

[3] PORT CHECK (Port 80)
-------------------------------------
Port 80 is LISTENING

[4] HTTP STATUS
-------------------------------------
HTTP Status: 200

=====================================
  DONE
=====================================
```

---

## Understanding the Results

### Ping Test

| Result | What It Means |
|--------|---------------|
| Shows time (e.g., 12.3 ms) | Server is reachable |
| 100% packet loss | Server is down or blocking ping |
| Request timeout | Server is unreachable |

### DNS Resolution

| Result | What It Means |
|--------|---------------|
| Shows IP address | DNS is working |
| Empty or error | DNS problem |

### Port Check

| Result | What It Means |
|--------|---------------|
| "Port X is LISTENING" | Service is running on that port |
| "Port X is NOT listening" | Nothing running on that port |

### HTTP Status

| Code | What It Means |
|------|---------------|
| 200 | OK — working perfectly |
| 301/302 | Redirect — moved to another URL |
| 403 | Forbidden — you don't have access |
| 404 | Not Found — page doesn't exist |
| 500 | Server Error — something broke |

---

## Common Checks

**Check if a website is up:**
```bash
./network-check.sh example.com 80
```

**Check if HTTPS is working:**
```bash
./network-check.sh example.com 443
```

**Check if SSH is running:**
```bash
./network-check.sh myserver.com 22
```

**Check if MySQL is accessible:**
```bash
./network-check.sh dbserver.com 3306
```

---

## Troubleshooting

**Problem: "Port is NOT listening"**
- The service might be stopped
- Try: `sudo systemctl start nginx`

**Problem: "HTTP Status: 500"**
- Server is running but has an error
- Check server logs

**Problem: "DNS resolution failed"**
- DNS server might be down
- Try: `ping 8.8.8.8` (Google's DNS)
