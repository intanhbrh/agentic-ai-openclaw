# AI Model Comparison

Comparison of models tested during the Agentic AI research phase.

---

## Models Tested

| Model | Type | Speed | Quota | Best For |
|-------|------|-------|-------|----------|
| Google Gemini 2.5 Flash | Cloud | ⚡ 2–5 sec | 1,500 req/day (free) | Live demos, fast responses |
| Qwen 3.5 9B | Local (RTX 4090) | 🟡 10–20 sec | Unlimited | Daily dev work, no quota concerns |
| Nemotron-3-Nano-30B | Local (RTX 4090) | 🐢 20–40 sec | Unlimited | Highest quality local output |

---

## How to Switch Models

```bash
# Switch to Gemini 2.5 Flash (cloud)
openclaw config set agents.defaults.model.primary "google/gemini-2.5-flash"
openclaw gateway restart

# Switch to Qwen (local, backup)
openclaw config set agents.defaults.model.primary "ollama/qwen3.5:9b"
openclaw gateway restart

# Switch to Nemotron (local, highest quality)
openclaw config set agents.defaults.model.primary "ollama/nemotron-3-nano:30b"
openclaw gateway restart
```

---

## Gemini Free Tier Limits

- ~1,500 requests per day
- ~1 million tokens per day
- Resets every 24 hours
- When quota runs out: agent fails with error 429

**Backup command when Gemini quota runs out:**
```bash
openclaw config set agents.defaults.model.primary "ollama/qwen3.5:9b"
openclaw gateway restart
```

---

## Key Findings

1. **Gemini 2.5 Flash** is significantly faster than local models — best for demos and presentations
2. **Local models** (Qwen/Nemotron) are unlimited but slower — best for development work
3. **RTX 4090** handles Nemotron-30B comfortably at 4-bit quantization (~24 GB VRAM)
4. For **multi-user** scenarios, local models are more sustainable (no shared quota)
5. Cloud models require internet — local models work fully offline

---

## Other Providers Worth Exploring

| Provider | Models | Notes |
|----------|--------|-------|
| Anthropic | Claude Sonnet 4.6, Opus 4.6 | Excellent for complex coding tasks |
| OpenAI | GPT-5.4 Mini, GPT-4o | Reliable API, good general performance |
| Google | Gemini 3 Flash, Gemini 3.1 Pro | Long context window, free tier available |
| Ollama | Gemma 4, Qwen3.5, Llama 3.3 | Local/private inference, no API costs |
