# Ubuntu + RTX 4090 Setup Guide

Full installation guide for OpenClaw + NemoClaw on Ubuntu with NVIDIA RTX 4090.

---

## Hardware Requirements

| Requirement | Minimum | Recommended | Our Setup |
|-------------|---------|-------------|-----------|
| GPU VRAM | 8 GB | 24 GB | RTX 4090 — 24 GB ✓ |
| System RAM | 4 GB | 32 GB+ | ~62 GB ✓ |
| Free Disk | 50 GB | 100 GB+ | 429 GB ✓ |
| OS | Ubuntu 22.04 | Ubuntu 24.04+ | Ubuntu 26.04 ✓ |

### Check your system first:
```bash
free -h          # Check RAM
df -h /          # Check disk space
nproc            # Check CPU cores
lspci | grep -i nvidia  # Verify GPU detected
```

---

## Step 1 — Update System

```bash
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y curl wget git build-essential ca-certificates gnupg lsb-release
```

---

## Step 2 — Install NVIDIA Drivers + CUDA

```bash
# Check if driver already installed
nvidia-smi

# Install recommended driver
sudo ubuntu-drivers autoinstall

# Reboot after install
sudo reboot
```

After reboot, verify:
```bash
nvidia-smi       # Should show RTX 4090
nvcc --version   # Should show CUDA version
```

If CUDA toolkit missing:
```bash
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/cuda-keyring_1.1-1_all.deb
sudo dpkg -i cuda-keyring_1.1-1_all.deb
sudo apt-get update
sudo apt-get install -y cuda-toolkit-12-6
echo 'export PATH=/usr/local/cuda/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
```

---

## Step 3 — Install Node.js 22+

> ⚠️ Do NOT use `sudo apt install nodejs` — the Ubuntu repo version is too old.

```bash
curl -fsSL https://deb.nodesource.com/setup_24.x | sudo -E bash -
sudo apt-get install -y nodejs
node --version   # Should show v22.x or v24.x
npm --version
```

---

## Step 4 — Install Docker

```bash
sudo apt-get install -y docker.io
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker $USER
newgrp docker
docker run hello-world  # Test
```

---

## Step 5 — Install NVIDIA Container Toolkit

Allows Docker containers to access the RTX 4090 GPU:

```bash
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
  sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
  sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
sudo apt-get update
sudo apt-get install -y nvidia-container-toolkit
sudo nvidia-ctk runtime configure --runtime=docker
sudo systemctl restart docker

# Set NVIDIA as default Docker runtime
sudo nano /etc/docker/daemon.json
# Add: "default-runtime": "nvidia"
sudo systemctl restart docker

# Test GPU inside Docker
docker run --rm --gpus all nvidia/cuda:12.4.0-base-ubuntu22.04 nvidia-smi
```

---

## Step 6 — Install Ollama (Local Model Server)

```bash
curl -fsSL https://ollama.ai/install.sh | sh
ollama pull nemotron-3-nano:30b   # ~18 GB download
ollama pull qwen3.5:9b            # Faster alternative
ollama serve &
```

---

## Step 7 — Install OpenClaw

```bash
curl -fsSL https://openclaw.ai/install.sh | bash
# OR
npm install -g openclaw@latest

openclaw --version
```

During onboarding:
- Security risks → accept
- Setup type → Quickstart
- AI provider → Skip for now (using local Ollama)

---

## Step 8 — Install OpenShell

```bash
git clone https://github.com/NVIDIA/OpenShell.git
cd OpenShell
./install.sh
cd ..
```

---

## Step 9 — Install NemoClaw

```bash
git clone https://github.com/NVIDIA/NemoClaw.git
cd NemoClaw
./install.sh
# OR if ./install.sh missing:
npm install
sudo npm install -g .
cd ..
```

Verify:
```bash
nemoclaw --version
```

---

## Step 10 — Run Onboarding

```bash
nemoclaw onboard
```

Follow prompts:
- Continue → **y**
- Inference provider → **7 (Local Ollama)**
- Model → **nemotron-3-nano:30b** or **qwen3.5:9b**
- Sandbox name → **my-assistant**
- Web search → **n**

---

## Step 11 — Configure Gemini (Optional, Cloud Model)

```bash
openclaw models auth login --provider google
# Enter your Google AI Studio API key

openclaw config set agents.defaults.model.primary "google/gemini-2.5-flash"
openclaw gateway restart
```

---

## Step 12 — Start and Test

```bash
openclaw gateway start
openclaw status
openclaw tui
```

Type `hello` and the agent should respond!
