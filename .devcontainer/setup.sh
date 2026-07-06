#!/bin/bash
set -e

echo "🚀 Setting up WiFi Sensing Lab..."

# Update packages
sudo apt-get update
sudo apt-get install -y \
  build-essential \
  cmake \
  git \
  pkg-config \
  libssl-dev \
  curl \
  wget \
  jq

# Install Rust toolchain
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env

# Install Python dependencies
python3 -m pip install --upgrade pip
python3 -m pip install \
  numpy \
  scipy \
  matplotlib \
  jupyter \
  paho-mqtt \
  websockets \
  aiohttp \
  pydantic \
  click

# Setup RuView submodule
echo "📦 Initializing RuView submodule..."
cd /workspaces/wifi-sensing-lab
git submodule update --init --recursive projects/ruview 2>/dev/null || echo "Note: RuView submodule not yet added"

echo "✅ Setup complete! Run 'make help' to see available commands."
