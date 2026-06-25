# Troubleshooting Guide

Common issues encountered during setup and daily use.

---

## OpenClaw Issues

| Problem | Likely Cause | Fix |
|---------|-------------|-----|
| `openclaw: command not found` | PATH not updated | `npm install -g openclaw@latest` |
| Gateway not running | Server restarted | `openclaw gateway start` |
| Missing gateway auth token | Token expired | `openclaw dashboard` to get new token |
| Agent failed before reply | Gemini quota exceeded (error 429) | Switch to local: `openclaw config set agents.defaults.model.primary "ollama/qwen3.5:9b"` |
| Gateway disconnected in TUI | Gateway crashed | `openclaw gateway restart` |
| Unknown model error | Old session using deleted model | Start new session in dashboard |

---

## Connection Issues

| Problem | Likely Cause | Fix |
|---------|-------------|-----|
| `ssh: Connection refused` | SSH not running on server | `sudo systemctl start ssh` |
| `http://localhost:18789` blank | SSH tunnel not open | Re-run `ssh -N -L 18789:127.0.0.1:18789 edtech@10.250.34.10` |
| Browser shows "Cannot connect" | Tunnel terminal was closed | Keep the SSH terminal open |
| Token rejected | Token changed after restart | Run `openclaw dashboard` on server for new token |

---

## Docker / NemoClaw Issues

| Problem | Likely Cause | Fix |
|---------|-------------|-----|
| Docker GPU patch failed | NVIDIA container toolkit missing | `sudo apt-get install -y nvidia-container-toolkit` then `sudo nvidia-ctk runtime configure --runtime=docker` |
| Permission denied on Docker | User not in docker group | `sudo usermod -aG docker $USER` then log out/in |
| Sandbox does not start | OpenShell gateway not running | `openshell sandbox list` and check logs |
| OpenShell gateway fails on systemd | Known Linux bug — Docker socket not accessible to user services | Run manually: `bash ~/start-openshell.sh` |

---

## GPU Issues

| Problem | Likely Cause | Fix |
|---------|-------------|-----|
| `nvidia-smi` not found | Driver not installed | `sudo ubuntu-drivers autoinstall` then reboot |
| CUDA out of memory | Model too large for VRAM | Use `qwen3.5:9b` instead of 30B model |
| Docker can't see GPU | Default runtime not set | Add `"default-runtime": "nvidia"` to `/etc/docker/daemon.json` |

---

## Ollama Issues

| Problem | Likely Cause | Fix |
|---------|-------------|-----|
| Ollama not responding | Service stopped | `ollama serve &` |
| Model not found | Not downloaded yet | `ollama pull qwen3.5:9b` |
| Slow responses | GPU not being used | Check `nvidia-smi` shows Ollama using GPU |

---

## Known Bugs (NemoClaw Early-Stage)

> NemoClaw was announced at GTC 2026 and is still early-stage software.

1. **OpenShell gateway systemd user service cannot access Docker socket** — This is a known Linux bug. Workaround: disable the systemd service and run the gateway manually with `DOCKER_HOST` exported.

2. **Missing authorization header at step 4/8 of onboard** — Caused by gateway certificate/token mismatch after reinstall. Fix: remove all gateway registrations and re-register cleanly.

3. **Blueprint max_openshell_version mismatch** — When NemoClaw and OpenShell versions are out of sync. Fix: update NemoClaw via `git pull && npm install && sudo npm install -g .`

---

## Full Reset (When Everything Is Broken)

```bash
# Kill all gateway processes
pkill -f openshell-gat

# Remove broken gateway registrations
openshell gateway remove nemoclaw
openshell gateway remove openshell

# Clear state (backs up first)
cp -r ~/.openclaw ~/.openclaw-backup
mv ~/.openclaw ~/.openclaw-old

# Fresh onboard
openclaw onboard
nemoclaw onboard
```
