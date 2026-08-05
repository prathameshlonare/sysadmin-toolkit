# Architecture — sysadmin-toolkit

## Problem Statement

Server administrators spend **2-4 hours weekly** on repetitive tasks:
- Checking if critical services are running (nginx, mysql, sshd)
- Diagnosing why a server can't reach the internet
- Auditing file permissions for security compliance
- Monitoring which processes are consuming resources

**This toolkit automates the top 4 sysadmin tasks into a single, production-ready repository.**

---

## Why Bash?

| Factor | Bash | Python |
|--------|------|--------|
| Dependencies | None (pre-installed on all Linux) | Requires `pip install` |
| Portability | Runs everywhere | Needs Python 3.x |
| Startup time | Instant | Import overhead |
| System integration | Native (systemctl, ps, etc.) | Requires subprocess |

**Decision:** Bash for portability and zero-dependency deployment on production servers.

---

## Why These 4 Scripts?

Based on common interview questions + real server incidents:

| Script | Problem It Solves | Interview Topic |
|--------|-------------------|-----------------|
| monitor-service.sh | Services crash silently, no alerts | Service management, systemd |
| network-check.sh | "Is it DNS? Is it the firewall?" | Networking, troubleshooting |
| setup-permissions.sh | Security: SUID, world-writable files | Linux security, file permissions |
| process-manager.sh | "What's eating my CPU?" | Process management, resource monitoring |

---

## Folder Structure

```
sysadmin-toolkit/
├── scripts/
│   ├── filesystem/           # Permission management domain
│   │   ├── setup-permissions.sh
│   │   └── README.md
│   ├── network/              # Network diagnostics domain
│   │   ├── network-check.sh
│   │   └── README.md
│   ├── process/              # Process management domain
│   │   ├── process-manager.sh
│   │   └── README.md
│   └── system/               # Service health domain
│       ├── monitor-service.sh
│       └── README.md
├── docs/                     # Learning notes + architecture
├── .github/workflows/        # CI/CD pipeline
├── ARCHITECTURE.md           # This file
├── METRICS.md                # Impact metrics
└── README.md                 # Main documentation
```

**Design decision:** Organized by domain, not by function. Each folder = one sysadmin concern. This makes it easy to:
- Find the right script for the problem
- Add new scripts to a domain without cluttering
- Test domains independently

---

## Production Features

### Input Validation
All scripts validate arguments before execution:
```bash
if [ -z "$SERVICE" ]; then
    echo "Error: Service name required"
    show_help
    exit 1
fi
```

### Dry-Run Mode
Destructive scripts support `--dry-run` to preview changes:
```bash
if [ "$DRY_RUN" = 1 ]; then
    echo "[DRY-RUN] Would restart $service"
else
    systemctl restart "$service"
fi
```

### Logging
All operations logged with timestamps:
```bash
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}
```

### Alerting
Critical failures trigger notifications (email/Slack):
```bash
send_alert "$message" "CRITICAL"  # Emails admin + Slack channel
```

---

## Design Decisions

### 1. Monolithic Scripts (not modular functions)
Each script is self-contained. Why?
- Easier to copy a single script to a server
- No dependency between scripts
- Simpler to understand and maintain

### 2. systemctl as Primary Interface
Scripts assume systemd. Why?
- 95%+ of modern Linux uses systemd
- Fallback to ps/kill for non-systemd systems
- systemctl provides structured output

### 3. Log to File + stdout
Logs go to both `/var/log/` and terminal. Why?
- File: Audit trail, historical analysis
- Terminal: Real-time visibility during manual runs

---

## Security Considerations

| Risk | Mitigation |
|------|------------|
| Scripts run as root | Explicit root check, clear warnings |
| Destructive operations | Dry-run mode, confirmation prompts |
| Log file permissions | Write to `/var/log/` with proper ownership |
| No secrets in code | Environment variables for config |

---

## Future Enhancements

- [ ] Configuration file (YAML/TOML) for service lists
- [ ] Prometheus metrics export
- [ ] Web dashboard for monitoring
- [ ] Containerized deployment (Docker)
