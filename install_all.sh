#!/data/data/com.termux/files/usr/bin/bash
# Hermes Agent setup pack — one-shot installer
# Installs the same core packages as Phone 1

set -e

echo "=========================================="
echo " Hermes Agent Setup — Installing Phone 2"
echo "=========================================="

# Step 1: update termux
echo ""
echo "==> [1/7] pkg update..."
pkg update -y

# Step 2a: install key packages first (these pull most deps)
echo ""
echo "==> [2a/7] Installing 22 core packages..."
PACKAGES="termux-tools termux-api python python-pip python-numpy python-pandas python-pillow bash coreutils findutils curl openssh openssh-sftp-server git gh nodejs-lts deno ffmpeg ghostscript nano tesseract"
pkg install -y $PACKAGES

# Step 2b: install ALL other packages from packages_full.txt (252 total on Phone 1)
echo ""
echo "==> [2b/7] Installing all remaining packages from packages_full.txt..."
if [ -f packages_full.txt ]; then
    xargs -a packages_full.txt pkg install -y
else
    echo "  WARNING: packages_full.txt not found — installing only 22 key packages"
fi

# Step 3: storage permission (user must grant)
echo ""
echo "==> [3/7] Storage setup (grant permission when prompted)..."
termux-setup-storage || true

# Step 4: install uv/uvx via pip
echo ""
echo "==> [4/7] pip install uv + Hermes Python deps..."
pip install --upgrade pip
pip install uv
pip install yt-dlp pyyaml tabulate requests pillow numpy pandas

# Step 5: install Hermes Agent from git (into ~/.hermes/hermes-agent)
echo ""
echo "==> [5/7] Cloning Hermes Agent..."
mkdir -p ~/.hermes
cd ~
if [ -d ".hermes/hermes-agent" ]; then
    echo "  .hermes/hermes-agent exists — updating"
    cd .hermes/hermes-agent && git pull || true
else
    git clone https://github.com/NousResearch/hermes-agent.git ~/.hermes/hermes-agent
fi

cd ~/.hermes/hermes-agent
if [ -f "install.sh" ]; then
    bash install.sh
elif [ -f "setup.sh" ]; then
    bash setup.sh
else
    echo "  No install script found — try 'pip install .' from repo root"
    pip install .
fi

# Step 6: Hermes first run (creates ~/.hermes/)
echo ""
echo "==> [6/7] Running hermes setup..."
hermes --version
hermes setup 2>&1 | head -20 || true

# Step 7: verify
echo ""
echo "==> [7/7] Verification..."
echo "  python:  $(python --version 2>&1)"
echo "  node:    $(node --version 2>&1)"
echo "  deno:    $(deno --version 2>&1 | head -1)"
echo "  gh:      $(gh --version 2>&1 | head -1)"
echo "  git:     $(git --version 2>&1)"
echo "  ffmpeg:  $(ffmpeg -version 2>&1 | head -1)"
echo "  hermes:  $(hermes --version 2>&1 | head -1)"

echo ""
echo "=========================================="
echo " Setup complete!"
echo ""
echo " NEXT STEPS (must do manually):"
echo "   1) Copy ~/.hermes/config.yaml from Phone 1 backup"
echo "   2) Copy ~/.hermes/.env from Phone 1 backup"
echo "   3) Set up API keys: Gemini, OpenRouter, AWS, YouTube, TG bots"
echo "   4) hermes gateway start"
echo ""
echo " Config files live in: ~/.hermes/"
echo "=========================================="
