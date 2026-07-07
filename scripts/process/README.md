# process-manager.sh

A tool to find, monitor, and manage running processes on Linux.

---

## What Does This Script Do?

When a program crashes or your server is slow, you need to find which process is causing the problem. This script helps you:

1. **Find** which process is using too much CPU or memory
2. **Search** for a specific process by name
3. **Kill** stuck or broken processes
4. **Check** which services are running

---

## When Do You Need This?

- Server is slow and you need to find the culprit
- A process is stuck and won't stop
- You want to check if a service is running
- You need to see what's using your server's resources

---

## How to Use

### Step 1: Make it executable

```bash
chmod +x process-manager.sh
```

### Step 2: Run it with a command

**See top processes by CPU:**
```bash
./process-manager.sh list
```

**Find a specific process:**
```bash
./process-manager.sh search nginx
```

**Kill a process by ID:**
```bash
./process-manager.sh kill 1234
```

**See all running services:**
```bash
./process-manager.sh services
```

---

## All Commands

| Command | What It Does | Example |
|---------|--------------|---------|
| `list` | Show top processes by CPU and memory | `./process-manager.sh list` |
| `tree` | Show process tree (parent → child) | `./process-manager.sh tree` |
| `search <name>` | Find processes by name | `./process-manager.sh search python` |
| `kill <PID>` | Stop a process gracefully | `./process-manager.sh kill 1234` |
| `services` | List all running services | `./process-manager.sh services` |
| `failed` | Show failed services | `./process-manager.sh failed` |
| `uptime` | Show how long server has been running | `./process-manager.sh uptime` |

---

## What You'll See

**When listing top processes:**
```
TOP PROCESSES BY CPU
-------------------------------------
USER       PID %CPU %MEM COMMAND
root      1234 15.2  8.5 nginx: worker
www-data  5678 12.1  6.2 python app.py
prathamesh 901  2.3  1.1 bash
```

**When searching:**
```
SEARCHING FOR: nginx
-------------------------------------
root      1234  0.0  0.1 /usr/sbin/nginx
www-data  5678 12.1  6.2 nginx: worker process
```

---

## Common Scenarios

### "My server is slow"

```bash
# Find what's using CPU
./process-manager.sh list

# Check the top process
ps aux --sort=-%cpu | head -5
```

### "nginx won't start"

```bash
# Check if nginx is running
./process-manager.sh search nginx

# Check if port 80 is in use
ss -tlnp | grep :80
```

### "I need to restart a service"

```bash
# Check service status
./process-manager.sh services

# Restart it
sudo systemctl restart nginx
```

---

## How to Kill a Process

**Always try graceful kill first:**
```bash
./process-manager.sh kill 1234
```

**If that doesn't work, force kill:**
```bash
kill -9 1234
```

**Kill by name (all matching):**
```bash
pkill -9 python
```

---

## Zombie Processes

Zombies are dead processes that haven't been cleaned up. Find them:

```bash
./process-manager.sh zombies
```

If you find zombies, their parent process needs to be restarted.
