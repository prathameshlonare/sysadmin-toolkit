# Linux Commands Cheat Sheet

Quick reference for essential Linux commands. Part of sysadmin-toolkit.

---

## Navigation

| Command | What it does |
|---------|--------------|
| `pwd` | Print working directory |
| `cd /path` | Go to directory |
| `cd ..` | Go up one level |
| `cd ~` | Go home |
| `cd -` | Go to previous directory |

---

## Listing Files

| Command | What it does |
|---------|--------------|
| `ls` | Basic listing |
| `ls -la` | List all files (long format, hidden) |
| `ls -lh` | Human-readable sizes |
| `ls -ltr` | Sort by date (newest last) |
| `ls -la /etc` | List config files |
| `ls -la /var/log` | List log files |

---

## File Operations

| Command | What it does |
|---------|--------------|
| `touch file` | Create empty file |
| `touch file{1..5}.txt` | Create multiple files |
| `mkdir -p a/b/c` | Create nested directories |
| `cp file dest` | Copy file |
| `cp -r dir/ dest/` | Copy directory |
| `mv old new` | Rename or move |
| `rm file` | Delete file |
| `rm -rf dir/` | Force delete directory |

**WARNING:** `rm -rf` has no undo. Triple-check before running.

---

## Viewing Files

| Command | What it does |
|---------|--------------|
| `cat file` | Dump entire file |
| `cat -n file` | With line numbers |
| `head -20 file` | First 20 lines |
| `tail -20 file` | Last 20 lines |
| `tail -f file` | Follow in real-time (Ctrl+C to stop) |
| `less file` | Page through (Space=next, b=prev, /search, q=quit) |

---

## Searching

| Command | What it does |
|---------|--------------|
| `grep "text" file` | Search for text in file |
| `grep -i "text" file` | Case-insensitive |
| `grep -r "text" dir/` | Search recursively |
| `grep -n "text" file` | Show line numbers |
| `grep -c "text" file` | Count matches |
| `grep -v "text" file` | Invert (exclude lines) |
| `find . -name "*.ext"` | Find files by extension |
| `find / -name "*.log"` | Find all .log files |
| `find . -type f -size +100M` | Find large files |
| `find . -mtime -7` | Modified in last 7 days |
| `find . -empty` | Find empty files/dirs |

---

## Pipes & Redirection

| Command | What it does |
|---------|--------------|
| `cmd1 \| cmd2` | Pipe output to next command |
| `cmd > file` | Overwrite file |
| `cmd >> file` | Append to file |

### Examples

```bash
ls -la /etc | grep ".conf"           # Find config files
ps aux | grep nginx                  # Find nginx processes
cat /etc/passwd | wc -l              # Count users
du -sh /* 2>/dev/null | sort -rh | head -5  # Top 5 largest dirs
find / -type f -size +50M 2>/dev/null | head -10  # Large files
```

---

## System Info

| Command | What it does |
|---------|--------------|
| `cat /proc/cpuinfo` | CPU information |
| `cat /proc/meminfo` | Memory information |
| `cat /proc/loadavg` | System load |
| `cat /proc/uptime` | Uptime |
| `cat /etc/hostname` | Server name |
| `uname -a` | System info |
| `df -h` | Disk usage |
| `du -sh /*` | Directory sizes |
| `free -h` | Memory usage |
| `uptime` | Uptime + load |

---

## Permissions

| Command | What it does |
|---------|--------------|
| `chmod 755 file` | rwxr-xr-x (scripts) |
| `chmod 644 file` | rw-r--r-- (regular files) |
| `chmod 600 file` | rw------- (private keys) |
| `chmod +x script.sh` | Add execute permission |
| `chown user:group file` | Change owner |
| `chown -R user:group dir/` | Recursive chown |

### Permission Numbers

| Number | Permission | Meaning |
|--------|------------|---------|
| 7 | rwx | Read + Write + Execute |
| 6 | rw- | Read + Write |
| 5 | r-x | Read + Execute |
| 4 | r-- | Read only |
| 0 | --- | No permission |

---

## Process Management

| Command | What it does |
|---------|--------------|
| `ps aux` | List all processes |
| `ps aux --sort=-%cpu` | Sort by CPU |
| `ps aux --sort=-%mem` | Sort by memory |
| `ps aux \| grep name` | Find process |
| `top` | Real-time monitoring |
| `htop` | Better top (if installed) |
| `kill PID` | Graceful kill (SIGTERM) |
| `kill -9 PID` | Force kill (SIGKILL) |
| `pkill name` | Kill by name |
| `jobs` | List background jobs |
| `fg %1` | Bring job to foreground |
| `bg %1` | Resume in background |

---

## Networking

| Command | What it does |
|---------|--------------|
| `ss -tlnp` | See listening ports |
| `curl -I url` | Test HTTP endpoint |
| `curl -o /dev/null -s -w "%{http_code}" url` | Get status code only |
| `dig +short domain` | DNS resolution |
| `nslookup domain` | Simple DNS lookup |
| `ping -c 4 host` | Test connectivity |
| `traceroute host` | Trace packet path |
| `ip addr show` | Network interfaces |

---

## Top 10 Daily Commands

1. `ls -la` — see everything
2. `cd /path` — navigate
3. `pwd` — where am I?
4. `grep -r "text" .` — search everything
5. `find . -name "*.py"` — find files
6. `cat file` — read file
7. `tail -f /var/log/syslog` — watch logs
8. `ps aux | grep name` — find process
9. `du -sh /*` — check disk usage
10. `history` — see command history

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
| Running processes | `ps aux` |
| Listening ports | `ss -tlnp` |

---

*Created: Day 3 of 100-Day DevOps Journey*
