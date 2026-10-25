# Hermes Agent on Android (Termux) — Version Snapshots

Captured from Phone 1 on 2026-10-25.

## Core
| Component | Version | Install method |
|-----------|---------|----------------|
| Termux | 0.119.0-beta.3 | F-Droid APK |
| Android | 16 (SDK 36) | System |
| Kernel | 6.6.118-android15-8 | System |
| Architecture | aarch64 | ARM 64-bit |

## Languages & Runtime
| Component | Version | Install method |
|-----------|---------|----------------|
| Python | 3.14.6 | `pkg install python` |
| Node.js | LTS | `pkg install nodejs-lts` |
| Deno | 2.9.7 | `pkg install deno` |
| uv | — | `pip install uv` |

## CLI Tools
| Tool | Version | Install method |
|------|---------|----------------|
| git | 2.55.0 | `pkg install git` |
| gh | 2.101.0 | `pkg install gh` |
| curl | 8.22.0 | `pkg install curl` |
| ffmpeg | 8.1.2 | `pkg install ffmpeg` |
| ghostscript | 10.07.1 | `pkg install ghostscript` |
| nano | — | `pkg install nano` |
| tesseract | — | `pkg install tesseract` |
| ripgrep | 14.x | `pkg install ripgrep` |

## Hermes
| Component | Version | Path |
|-----------|---------|------|
| Hermes Agent | v0.21.1 | ~/.hermes/hermes-agent |
| Hermes config | — | ~/.hermes/config.yaml |
| Hermes secrets | — | ~/.hermes/.env |
| Hermes profile | default | — |

## Python packages (66 total)
See `pip_full.txt` for full list. Key:
- boto3 (AWS SDK) — 1.43.111
- requests — 2.34.2
- yt-dlp — 2026.8.19
- pyyaml — 6.0.3
- pandas — 3.0.6
- numpy — 2.4.4
- pillow — 12.3.0
- tabulate — 0.10.0
- edge-tts — 7.2.8
- google-api-python-client — 2.201.0

## NPM globals
- @anthropic-ai/claude-code@2.1.273
- 9router@0.5.69
- corepack@0.35.0
- npm@11.19.1
- termux-mcp@1.0.0
- rea-agents@6.4.0

## Termux-specific setup
- `termux-setup-storage` run once (SD card access)
- `pkg install termux-api` for phone APIs
- `termux-wake-lock` to prevent sleep during long ops

## Known Termux gotchas
- Python 3.14: no wheels for numpy/pandas/PyTorch — use `pkg install python-numpy python-pandas`
- `/tmp` writes fail — use `$HOME` paths
- Voice clone / ML audio — needs Google Colab (no local ML wheels)
- litellm fails on py3.14 (<3.14 requirement)
- No `browser_exec` tool available on Termux
