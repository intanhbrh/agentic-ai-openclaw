#!/bin/bash
# ============================================================
# Switch AI Model Script
# Usage: bash switch-model.sh
# ============================================================

echo "Select AI Model:"
echo "1) Google Gemini 2.5 Flash (cloud — fast, needs API quota)"
echo "2) Qwen 3.5 9B (local — unlimited, medium speed)"
echo "3) Nemotron-3-Nano-30B (local — unlimited, slower, best quality)"
echo ""
read -p "Enter choice [1-3]: " choice

case $choice in
  1)
    echo "Switching to Gemini 2.5 Flash..."
    openclaw config set agents.defaults.model.primary "google/gemini-2.5-flash"
    ;;
  2)
    echo "Switching to Qwen 3.5 9B (local)..."
    openclaw config set agents.defaults.model.primary "ollama/qwen3.5:9b"
    ;;
  3)
    echo "Switching to Nemotron-3-Nano-30B (local)..."
    openclaw config set agents.defaults.model.primary "ollama/nemotron-3-nano:30b"
    ;;
  *)
    echo "Invalid choice. No changes made."
    exit 1
    ;;
esac

echo "Restarting gateway to apply changes..."
openclaw gateway restart
echo "Done! Model switched successfully."
openclaw status
