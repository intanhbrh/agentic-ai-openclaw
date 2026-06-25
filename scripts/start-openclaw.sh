#!/bin/bash
# ============================================================
# OpenClaw Startup Script
# HELP International School — EdTech Department
# Usage: bash start-openclaw.sh
# ============================================================

echo "=============================="
echo "  OpenClaw AI Platform Startup"
echo "=============================="
echo ""

# Step 1: Start Ollama (local models)
echo "[1/3] Starting Ollama (local models)..."
if pgrep -x "ollama" > /dev/null; then
    echo "      Ollama already running."
else
    ollama serve &
    sleep 3
    echo "      Ollama started."
fi

# Step 2: Start OpenClaw gateway
echo "[2/3] Starting OpenClaw gateway..."
openclaw gateway start
sleep 3

# Step 3: Show status
echo "[3/3] Checking status..."
openclaw status

echo ""
echo "=============================="
echo "  OpenClaw is ready!"
echo "  Dashboard: http://127.0.0.1:18789"
echo ""
echo "  Run this on your laptop to connect:"
echo "  ssh -N -L 18789:127.0.0.1:18789 edtech@10.250.34.10"
echo ""
echo "  Get access token:"
echo "  openclaw dashboard"
echo "=============================="
