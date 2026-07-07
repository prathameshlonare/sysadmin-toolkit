# setup-permissions.sh

A script to check and fix file permissions on Linux.

---

## What Does This Script Do?

When you work with Linux servers, you often see "Permission denied" errors. This happens when files have wrong permissions. This script helps you:

1. **See** what permissions a file or folder has
2. **Find** security problems (like files everyone can write to)
3. **Fix** permissions with one command

---

## When Do You Need This?

- After downloading files from the internet
- When setting up a web server
- When SSH keys show "Permission denied"
- When your script won't run

---

## How to Use

### Step 1: Make it executable

```bash
chmod +x setup-permissions.sh
```

### Step 2: Run it

**Check permissions of a file:**
```bash
./setup-permissions.sh /etc/passwd
```

**Fix permissions of a script:**
```bash
./setup-permissions.sh ./myscript.sh 755
```

**Fix permissions of a private key:**
```bash
./setup-permissions.sh ~/.ssh/id_rsa 600
```

---

## What the Numbers Mean

| Number | Permission | Use For |
|--------|------------|---------|
| 755 | rwxr-xr-x | Scripts, executables |
| 644 | rw-r--r-- | Regular files |
| 600 | rw------- | Private keys, secrets |
| 700 | rwx------ | Private folders |

---

## What You'll See

**When checking:**
```
[1] CURRENT PERMISSIONS
-------------------------------------
-rw-r--r-- 1 user user 4096 Jul 01 10:00 file.txt

[2] PERMISSION BREAKDOWN
-------------------------------------
Octal: 644
Owner: user
Group: user
```

**When fixing:**
```
[4] FIXING PERMISSIONS
-------------------------------------
Setting mode 755 on ./script.sh
Done! New permissions:
-rwxr-xr-x 1 user user 4096 Jul 01 10:00 script.sh
```

---

## Security Check

The script also finds dangerous files:

- **World-writable files** — files everyone can change (security risk)
- **SUID files** — files that run as root (can be dangerous)
- **SGID files** — files with group privileges

---

## Real Example

```bash
# You just downloaded a script
./setup-permissions.sh download-script.sh
# Output: -rw-r--r-- (can't run it)

# Fix it
./setup-permissions.sh download-script.sh 755
# Output: -rwxr-xr-x (now you can run it)

# Run it
./download-script.sh
```
