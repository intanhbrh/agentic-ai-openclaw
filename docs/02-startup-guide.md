# Daily Startup Guide

Every time the Ubuntu server restarts or powers on, follow these steps.

---

## Startup Sequence

### Step 1 — Log into Server
Sit at the machine or SSH in from your laptop:
```bash
ssh edtech@10.250.34.10
```

### Step 2 — Start Ollama (Local Models Only)
Skip this if you are only using Gemini.
```bash
ollama serve &
ollama list   # Verify models are available
```

### Step 3 — Start OpenClaw Gateway
```bash
openclaw gateway start
openclaw status   # Verify running
```

Expected output:
```
Gateway service: running
Dashboard: http://127.0.0.1:18789/
```

### Step 4 — Get Access Token
```bash
openclaw dashboard
```

Copy the token and share with all developers who need access today.

> ⚠️ The token changes every restart. Always run `openclaw dashboard` after startup.

---

## Quick Summary Table

| Step | Command | Notes |
|------|---------|-------|
| 1 | `ssh edtech@10.250.34.10` | Log into server |
| 2 | `ollama serve &` | Local models only |
| 3 | `openclaw gateway start` | Start the AI platform |
| 4 | `openclaw status` | Verify everything running |
| 5 | `openclaw dashboard` | Get token for users |

---

## Shutdown / Stop

```bash
openclaw gateway stop
# Ollama stops automatically when terminal closes
```

---

## Set a Permanent Token (Avoid Resharing Every Restart)

```bash
# Generate a strong random token
openssl rand -hex 24

# Set it permanently
openclaw config set gateway.auth.token "your-token-here"
openclaw gateway restart
```

Now the same token works every time — no need to reshare after restart.
