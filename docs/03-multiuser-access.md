# Multi-User Access Guide

How multiple developers can connect to the OpenClaw AI platform simultaneously.

---

## How It Works

All developers SSH tunnel into the Ubuntu server and access the same OpenClaw gateway through their own browser. Each person runs the tunnel on their own laptop.

```
Your Laptop ──SSH Tunnel──► Ubuntu Server (10.250.34.10)
                                    │
                              OpenClaw Gateway :18789
                                    │
                              AI Agent (Gemini / Qwen)
```

---

## Connection Steps (Every Developer)

### Mac / Linux
```bash
# Step 1: Open terminal and run SSH tunnel
ssh -N -L 18789:127.0.0.1:18789 edtech@10.250.34.10

# Step 2: Enter server password when prompted

# Step 3: Keep this terminal open (do not close it)

# Step 4: Open browser and go to:
http://localhost:18789

# Step 5: Enter token when prompted (get from admin)
```

### Windows (PowerShell or Git Bash)
```powershell
# Step 1: Open PowerShell
ssh -N -L 18789:127.0.0.1:18789 edtech@10.250.34.10

# Step 2: Enter password

# Step 3: Keep PowerShell open

# Step 4: Open Chrome/Edge and go to:
http://localhost:18789
```

> If SSH is not installed on Windows: Settings → Apps → Optional Features → Add OpenSSH Client

---

## Getting the Token (Admin Only)

Run this on the Ubuntu server:
```bash
openclaw dashboard
```

Copy the token value and share it with all developers via chat/email.

---

## Important Notes

| Rule | Why |
|------|-----|
| Each person needs their own SSH tunnel | Tunnels are per-connection, not shared |
| Keep the tunnel terminal open | Closing it disconnects your browser session |
| Token changes after server restart | Get new token from admin after each restart |
| All users share Gemini quota | Heavy usage from multiple users drains quota faster |

---

## How Many Users Can Connect?

- **No hard limit** on simultaneous SSH tunnels
- For **Gemini (cloud)**: all users share the same API quota (1,500 req/day free tier)
- For **local models (Qwen/Nemotron)**: all requests queue through the RTX 4090 — slower with more users
- **Recommended**: 3–5 developers for smooth performance

---

## Server Info

| Detail | Value |
|--------|-------|
| Server IP | 10.250.34.10 |
| Username | edtech |
| Dashboard Port | 18789 |
| SSH Command | `ssh -N -L 18789:127.0.0.1:18789 edtech@10.250.34.10` |
| Browser URL | `http://localhost:18789` |
