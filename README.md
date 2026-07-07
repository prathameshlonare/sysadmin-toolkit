# sysadmin-toolkit

A collection of bash scripts for Linux system administration tasks. Created as part of 100-Day DevOps Learning Journey.

---

## 📁 Project Structure

```
sysadmin-toolkit/
├── scripts/
│   ├── filesystem/
│   │   ├── setup-permissions.sh       # Fix file permissions
│   │   └── README.md                  # [Read this](scripts/filesystem/README.md)
│   ├── process/
│   │   ├── process-manager.sh         # Find and kill processes
│   │   └── README.md                  # [Read this](scripts/process/README.md)
│   ├── network/
│   │   ├── network-check.sh           # Test connections and ports
│   │   └── README.md                  # [Read this](scripts/network/README.md)
│   └── system/
│       ├── monitor-service.sh         # Auto-restart failed services
│       └── README.md                  # [Read this](scripts/system/README.md)
├── docs/
│   ├── linux-fs-exploration.md        # Linux filesystem notes
│   └── linux-commands-cheatsheet.md   # Quick command reference
└── README.md                          # You are here
```

---

## 🚀 Scripts Overview

Click the links to read detailed documentation for each script:

| Script | What It Does | Link |
|--------|--------------|------|
| **setup-permissions.sh** | Check and fix file permissions | [Read →](scripts/filesystem/README.md) |
| **process-manager.sh** | Find, monitor, and kill processes | [Read →](scripts/process/README.md) |
| **network-check.sh** | Test network connections and ports | [Read →](scripts/network/README.md) |
| **monitor-service.sh** | Auto-restart failed services | [Read →](scripts/system/README.md) |

---

## 📚 Documentation

| File | What It Contains | Link |
|------|------------------|------|
| **linux-fs-exploration.md** | Linux directory structure guide | [Read →](docs/linux-fs-exploration.md) |
| **linux-commands-cheatsheet.md** | Quick reference for essential commands | [Read →](docs/linux-commands-cheatsheet.md) |

---

## 🎯 Learning Progress

| Day | Topic | File | Status |
|-----|-------|------|--------|
| 2 | File System | linux-fs-exploration.md | ✅ |
| 3 | Linux Commands | linux-commands-cheatsheet.md | ✅ |
| 4 | Permissions | setup-permissions.sh | ✅ |
| 5 | Process Mgmt | process-manager.sh | ✅ |
| 6 | Networking | network-check.sh | ✅ |
| 6 | Service Monitor | monitor-service.sh | ✅ |

---

## 🛠️ Requirements

- Bash 4.0+
- Linux/macOS (WSL2 for Windows)
- Standard utils: `ps`, `ss`, `dig`, `curl`, `find`, `stat`

---

## 📝 License

Part of 100-Day DevOps Learning Journey by Prathamesh Lonare.
