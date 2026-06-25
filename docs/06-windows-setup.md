# Windows + WSL2 Setup Guide

How to set up OpenClaw + NemoClaw on Windows using WSL2.

---

## Prerequisites

- Windows 10/11 with WSL2 enabled
- Docker Desktop installed
- Ollama installed (Windows native)

---

## Daily Startup

### Terminal 1 — Windows Command Prompt
```cmd
REM Check Ollama is running
ollama list

REM If nothing shows, restart Ollama:
taskkill /F /IM ollama.exe
ollama serve
```

### Terminal 2 — WSL2 (Win + R → type `wsl` → Enter)
```bash
# Connect to sandbox
nemoclaw my-assistant connect

# Wait for: sandbox@xxxxxxxx:~$

# Start OpenClaw
openclaw tui

# Bottom bar should show: connected | inference/qwen2.5:7b
```

---

## Troubleshooting

### Gateway Issues — Kill and Restart
```bash
# Find gateway process ID
ps aux | grep openshell

# Kill it (replace 2601 with actual PID)
kill -9 2601

# Verify gone
ps aux | grep openshell

# Restart
nemoclaw onboard --no-gpu
```

### Sandbox Does Not Exist
```bash
# Create fresh sandbox
nemoclaw onboard --no-gpu

# Follow prompts:
# Inference: 7 (Local Ollama)
# Model: qwen2.5:7b
# Sandbox name: my-assistant
# Web search: n
```

### Docker GPU Patch Failed
```bash
# Delete failed sandbox
openshell sandbox delete my-assistant

# Onboard with GPU patch disabled
NEMOCLAW_DOCKER_GPU_PATCH=0 nemoclaw onboard --gpu

# If still failing:
NEMOCLAW_DOCKER_GPU_PATCH=0 nemoclaw onboard --no-gpu
```

### OpenClaw Not Responding
```bash
# Fix Ollama plugin inside sandbox
cp /sandbox/.openclaw/openclaw.json /sandbox/.openclaw/openclaw.json.bak

python3 -c "
import json
with open('/sandbox/.openclaw/openclaw.json', 'r') as f:
    config = json.load(f)
config['plugins']['entries']['ollama']['enabled'] = True
config['models']['providers']['inference']['baseUrl'] = 'http://host.docker.internal:11434'
with open('/sandbox/.openclaw/openclaw.json', 'w') as f:
    json.dump(config, f, indent=2)
print('done')"

openclaw tui
```

### HEARTBEAT.md Blocking Responses
```bash
echo 'HEARTBEAT_OK' > /sandbox/.openclaw/workspace/HEARTBEAT.md
openclaw tui
```

---

## GPU Setup (Windows — RTX 4090)

### Check GPU Status
```cmd
nvidia-smi
```

### Force Ollama to Use GPU
```cmd
REM Run as Administrator
taskkill /F /IM ollama.exe
set CUDA_VISIBLE_DEVICES=0
ollama serve
```

### Enable GPU in NemoClaw (WSL2)
```bash
# Install NVIDIA container toolkit
sudo apt-get update
sudo apt-get install -y nvidia-container-toolkit

# Regenerate CDI file
sudo nvidia-ctk cdi generate --output=/etc/cdi/nvidia.yaml

# Verify
sudo nvidia-ctk cdi list
# Should show: nvidia.com/gpu=all

# Onboard with GPU
nemoclaw onboard --gpu
```

---

## Full Reset (Windows)
```bash
# In WSL2:
ps aux | grep openshell
kill -9 <PID>
openshell sandbox delete my-assistant
NEMOCLAW_DOCKER_GPU_PATCH=0 nemoclaw onboard --no-gpu
nemoclaw my-assistant connect
# Inside sandbox:
openclaw tui
```
