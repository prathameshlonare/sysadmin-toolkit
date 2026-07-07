# Linux File System Exploration

A reference guide to the Linux directory structure. Created on Day 2 of the 100-Day DevOps Journey.

---

## Top-Level Directory Map

Every Linux server follows the same directory layout. Learn this map and you'll never be lost.

| Directory | Purpose | Example Files |
|-----------|---------|---------------|
| `/bin` | Essential binaries | ls, cp, cat, grep |
| `/boot` | Kernel files | vmlinuz, grub |
| `/dev` | Device files | /dev/sda, /dev/null |
| `/etc` | **Configurations** | nginx.conf, ssh/sshd_config |
| `/home` | User directories | /home/prathamesh |
| `/lib` | Shared libraries | .so files |
| `/media` | Removable media mount | USB drives |
| `/mnt` | Temporary mount points | Manual mounts |
| `/opt` | Third-party software | /opt/google/chrome |
| `/proc` | **Virtual — live system** | cpuinfo, meminfo |
| `/root` | Root user's home | /root |
| `/run` | Runtime data | PID files, sockets |
| `/sbin` | System binaries (admin) | iptables, reboot |
| `/sys` | Kernel/device info | /sys/class/net/ |
| `/tmp` | Temporary (cleared on reboot) | scratch files |
| `/usr` | User programs | /usr/bin, /usr/local |
| `/var` | **Variable data (logs)** | /var/log/syslog |

---

## The 4 Directories You'll Use Most

### 1. `/etc` — Configuration Files

```bash
ls -la /etc/nginx/          # Nginx config
ls -la /etc/ssh/            # SSH config
ls -la /etc/docker/         # Docker config
```

### 2. `/var/log` — Log Files

```bash
ls -la /var/log/            # All logs
tail -f /var/log/syslog     # Watch system log
cat /var/log/auth.log       # Login attempts
```

### 3. `/home` — Your Stuff

```bash
ls -la ~/                   # Your files
ls -la ~/.ssh/              # SSH keys
```

### 4. `/proc` — Live System Info

```bash
cat /proc/cpuinfo           # CPU details
cat /proc/meminfo           # Memory usage
cat /proc/loadavg           # System load
cat /proc/uptime            # How long running
```

---

## Commands Used

```bash
ls -la /                    # List all directories
du -sh /* 2>/dev/null       # Check sizes
cat /proc/cpuinfo           # CPU info
cat /proc/meminfo           # Memory info
file /etc/passwd            # Identify file types
```

---

## Quick Reference

"If I need to find X, I look in Y:"

| Need | Look in |
|------|---------|
| Config file | `/etc` |
| Log file | `/var/log` |
| User's stuff | `/home` |
| CPU/memory info | `/proc` |
| Binary | `/bin` or `/usr/bin` |
| Temporary files | `/tmp` |

---

## Finding Large Files

```bash
# Find what's using disk
du -sh /* 2>/dev/null

# Find files larger than 100MB
find / -type f -size +100M 2>/dev/null

# Find files modified in last 7 days
find . -mtime -7
```

---

*Created: Day 2 of 100-Day DevOps Journey*
