# 🤖 Agentic AI — OpenClaw + NemoClaw Setup 

---

## 📌 What Is This?

This repository documents my **Agentic AI research and deployment** (April–July 2026).

The goal was to set up, configure, and evaluate an **Agentic AI platform** that goes beyond simple chatbot interaction — allowing AI to plan tasks, write code, manage files, and execute multi-step workflows autonomously.

**Stack used:**
- [OpenClaw](https://openclaw.ai) — AI agent framework
- [NemoClaw](https://github.com/NVIDIA/NemoClaw) — NVIDIA security & orchestration layer
- [OpenShell](https://github.com/NVIDIA/OpenShell) — sandboxed runtime
- [Ollama](https://ollama.ai) — local model serving
- **NVIDIA RTX 4090** — 24 GB VRAM GPU for local inference
- **Ubuntu 26.04 LTS** — host operating system

---

## 🖥️ Server Specifications

| Component | Details |
|-----------|---------|
| OS | Ubuntu 26.04 LTS (hostname: AI-testing) |
| GPU | NVIDIA RTX 4090 — 24 GB VRAM |
| RAM | ~62 GB |
| Storage | 468 GB SSD |
| AI Framework | OpenClaw 2026.6.10 |
| Dashboard Port | 18789 |

---

## 📁 Repository Structure

```
agentic-ai-openclaw/
│
├── README.md                        ← You are here
├── docs/
│   ├── 01-setup-ubuntu.md           ← Full Ubuntu + RTX 4090 setup guide
│   ├── 02-startup-guide.md          ← Daily startup sequence
│   ├── 03-multiuser-access.md       ← How multiple developers connect
│   ├── 04-model-comparison.md       ← Gemini vs local models comparison
│   ├── 05-troubleshooting.md        ← Common issues and fixes
│   └── 06-windows-setup.md          ← Setup guide for Windows + WSL2
├── scripts/
│   ├── start-openclaw.sh            ← One-command startup script
│   └── switch-model.sh              ← Script to switch AI models
└── examples/
    └── demo-prompts.md              ← Example agentic AI prompts to try
```

---

## 🚀 Quick Start

### For the Server Admin (Ubuntu)
```bash
# 1. Start local models (optional)
ollama serve &

# 2. Start OpenClaw gateway
openclaw gateway start

# 3. Get access token for users
openclaw dashboard
```

### For Developers (Any Laptop)
```bash
# Run this on your laptop terminal
ssh -N -L 18789:127.0.0.1:18789 edtech@10.250.34.10

# Then open in browser:
http://localhost:18789
# Enter the token when prompted
```

---

## 🤖 AI Models Tested

| Model | Type | Speed | Notes |
|-------|------|-------|-------|
| Google Gemini 2.5 Flash | Cloud | ⚡ Fast (2–5s) | Free tier: 1,500 req/day |
| Qwen 3.5 9B | Local (RTX 4090) | 🐢 Medium (10–20s) | Unlimited, no quota |
| Nemotron-3-Nano-30B | Local (RTX 4090) | 🐢 Slower (20–40s) | Best quality locally |

---

## 🔑 Key Learning Outcomes

- How Agentic AI differs from traditional chatbots
- Linux system administration and GPU driver setup
- Docker container management and sandboxing
- AI model deployment and configuration (local + cloud)
- Multi-user AI platform administration
- Troubleshooting complex AI infrastructure issues

---

## 📖 Documentation

See the [`docs/`](./docs/) folder for full step-by-step guides.

---

## 👩‍💻 Author

**Nur Habriah Binti Azizan**  
Student ID: 1231301467  
Faculty of Computing and Informatics — Multimedia University (MMU) April–July 2026  
