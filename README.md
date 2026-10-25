# Hermes Agent Setup Pack — Phone 1 → Phone 2

Snapshot of Termux + Hermes setup on Phone 1 (Oct 25, 2026) for cloning onto Phone 2.

## What's here

| File | Purpose |
|------|---------|
| `install_all.sh` | **One-shot installer** — pkg + pip + Hermes clone |
| `README.md` | This file |
| `VERSIONS.md` | Version snapshot (Termux 0.119.0-beta.3, Python 3.14, etc.) |
| `packages_key.txt` | ~24 Termux packages actually used directly |
| `packages_full.txt` | All 252 Termux packages (incl. auto-deps) |
| `pip_full.txt` | `pip freeze` — 66 Python packages |
| `npm_global.txt` | `npm list -g` output |
| `config_sample.yaml` | Hermes config template (secrets redacted) |
| `env_vars_sample.txt` | Non-secret env var reference |

## Quick setup on Phone 2

```bash
# 1. Install Termux (F-Droid, version 0.119.0-beta.3 preferred)

# 2. Open Termux and clone this repo
pkg update -y
pkg install -y git
git clone https://github.com/makwanaalpesh811-a11y/hermes-setup-pack.git
cd hermes-setup-pack

# 3. Run the installer (10-20 min, ~2GB download)
bash install_all.sh

# 4. Restore config + secrets from Phone 1 backup
#    (Google Drive / Dropbox — DO NOT commit these)
#    ~/.hermes/config.yaml
#    ~/.hermes/.env
#    ~/.gh_token
#    ~/.youtube_token.json

# 5. Start Hermes gateway
hermes gateway start
```

## What MUST be done manually (not in this repo)

- **API keys** — Gemini, OpenRouter, AWS Bedrock, YouTube OAuth, Telegram bots
- **`~/.hermes/config.yaml`** — contains tokens, must copy from backup
- **`~/.hermes/.env`** — secrets file
- **`~/.gh_token`** — GitHub personal access token
- **`~/.youtube_token.json`** — YouTube OAuth token
- **User memory / skills** — `~/.hermes/memories/`, `~/.hermes/skills/`

## Version targets (from Phone 1)

- **Termux**: 0.119.0-beta.3 (F-Droid)
- **Android**: 16 (SDK 36)
- **Python**: 3.14.6
- **Node.js**: LTS
- **Deno**: 2.9.7
- **gh CLI**: 2.101+
- **ffmpeg**: 8.1.2
- **git**: 2.55
- **Hermes Agent**: v0.21.1 (git clone)

## Termux gotchas to know upfront

1. **Python 3.14 has no wheels** for numpy/pandas/PyTorch/scipy/librosa — must use `pkg install python-numpy python-pandas` (not pip)
2. **`/tmp` writes fail** — always use `$HOME` paths
3. **litellm fails on py3.14** — needs Python <3.14
4. **ML audio / voice cloning** — no local wheels, needs Google Colab
5. **`browser_exec` not available** on Termux — browser tool won't work
6. **`pkg install` first** — some packages need Termux:Extra or other repos

## Directory structure

```
hermes-setup-pack/
├── README.md              ← this file
├── VERSIONS.md            ← version snapshot
├── install_all.sh         ← one-shot installer
├── packages_key.txt       ← 24 core packages
├── packages_full.txt      ← 252 all packages
├── pip_full.txt           ← 66 Python packages
├── npm_global.txt         ← npm globals
├── config_sample.yaml     ← sanitized Hermes config
└── env_vars_sample.txt    ← env var reference
```
