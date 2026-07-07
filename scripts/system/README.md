# monitor-service.sh

A service watchdog that automatically restarts failed services.

---

## What Does This Script Do?

When a service crashes on your server (like nginx or mysql), this script:

1. **Detects** that the service has failed
2. **Restarts** it automatically
3. **Logs** what happened

Think of it as a bodyguard for your services — it watches and fixes problems.

---

## When Do You Need This?

- You have a production server that needs to stay online
- You want services to auto-restart when they crash
- You need a log of what services failed and when

---

## How to Use

### Step 1: Make it executable

```bash
chmod +x monitor-service.sh
```

### Step 2: Run with sudo (required)

**Check all failed services:**
```bash
sudo ./monitor-service.sh
```

**Check specific services:**
```bash
sudo ./monitor-service.sh nginx sshd
```

**Check multiple services:**
```bash
sudo ./monitor-service.sh nginx docker postgresql redis
```

---

## What You'll See

**When a service is healthy:**
```
2026-07-06 10:00:01 - Service monitor started.
2026-07-06 10:00:01 - OK: nginx is running.
2026-07-06 10:00:01 - OK: sshd is running.
2026-07-06 10:00:01 - Service monitor completed.
```

**When a service has failed:**
```
2026-07-06 10:00:01 - Service monitor started.
2026-07-06 10:00:01 - ALERT: nginx is failed. Attempting restart...
2026-07-06 10:00:04 - OK: nginx restarted successfully.
2026-07-06 10:00:04 - Service monitor completed.
```

**When restart fails:**
```
2026-07-06 10:00:01 - ALERT: postgresql is failed. Attempting restart...
2026-07-06 10:00:04 - CRITICAL: postgresql restart failed. Status: failed
```

---

## Why Run with Sudo?

This script needs root access because:
- It reads service status
- It restarts services
- It writes to `/var/log/service-monitor.log`

---

## Run Automatically with Cron

To check services every 5 minutes:

```bash
# Open crontab
crontab -e

# Add this line
*/5 * * * * /path/to/monitor-service.sh nginx sshd mysql
```

---

## Log File

All activity is logged to:
```
/var/log/service-monitor.log
```

**View the log:**
```bash
cat /var/log/service-monitor.log
```

**Watch it in real-time:**
```bash
tail -f /var/log/service-monitor.log
```

---

## Common Services to Monitor

| Service | Command |
|---------|---------|
| Web server | `sudo ./monitor-service.sh nginx` |
| Database | `sudo ./monitor-service.sh mysql` |
| SSH | `sudo ./monitor-service.sh sshd` |
| Docker | `sudo ./monitor-service.sh docker` |
| Redis | `sudo ./monitor-service.sh redis` |

---

## Troubleshooting

**"Error: Run as root (sudo)"**
- Add `sudo` before the command

**"Service restart failed"**
- Check why the service won't start: `sudo systemctl status <service>`
- Check logs: `sudo journalctl -u <service> -n 50`
