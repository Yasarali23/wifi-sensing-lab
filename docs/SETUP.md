# 📖 Setup & Installation Guide

## System Requirements

### Minimum (Codespaces)
- 2 vCPU
- 4 GB RAM
- 10 GB storage
- Internet connection

### Recommended (Local)
- 4 vCPU
- 8 GB RAM
- 20 GB storage
- Docker Engine 20.10+
- Python 3.9+
- Rust 1.70+

## Installation

### Option 1: GitHub Codespaces (Easiest)

1. Go to your repository
2. Click **Code** → **Codespaces** → **Create codespace on main**
3. Wait for container to build
4. Run:
   ```bash
   make all
   make run-docker
   ```

### Option 2: Local Development

#### Prerequisites
```bash
# macOS
brew install rust python node docker

# Ubuntu/Debian
sudo apt-get install -y build-essential python3 node docker.io

# Windows (WSL2)
wsl --install
# Then follow Ubuntu instructions
```

#### Clone & Setup
```bash
# Clone repository
git clone https://github.com/Yasarali23/wifi-sensing-lab.git
cd wifi-sensing-lab

# Setup environment
make setup

# Add RuView
make setup-ruview

# Start services
make build-docker
make run-docker
```

## Verification

```bash
# Check all tools
make status

# Expected output:
# Rust version: rustc 1.75.0
# Python version: Python 3.11.x
# Node version: v18.x.x
# Docker: Docker version 24.x.x
```

## Environment Configuration

### Create `.env` file
```bash
cat > .env << EOF
# RuView Configuration
RUST_LOG=debug
CSI_SOURCE=simulated
DEMO_MODE=true

# API Configuration
API_HOST=0.0.0.0
API_PORT=8000
API_LOG_LEVEL=info

# MQTT Configuration
MQTT_HOST=mqtt-broker
MQTT_PORT=1883
MQTT_USER=user
MQTT_PASSWORD=password

# Database
DATA_PATH=./data
MODELS_PATH=./models
EOF
```

## Running Services

### Docker Compose (Recommended)
```bash
# Start all services
docker-compose up -d

# View logs
docker-compose logs -f

# Stop services
docker-compose down
```

### Individual Services
```bash
# Terminal 1: API Server
cd apps/api
python3 -m uvicorn main:app --reload

# Terminal 2: RuView (if building locally)
cd projects/ruview
cargo run --release

# Terminal 3: Dashboard (if building locally)
cd apps/dashboard
npm install && npm run dev
```

## Accessing Services

| Service | URL | Purpose |
|---------|-----|----------|
| Dashboard | http://localhost:3000 | Real-time visualization |
| API Docs | http://localhost:8000/docs | Interactive API |
| MQTT | localhost:1883 | Message broker |

## RuView Installation

### Option A: Docker (No Installation)
```bash
# Already included in docker-compose.yml
make run-docker
```

### Option B: Python Package
```bash
# Install from PyPI
pip install ruview[client]

# Or from source
cd projects/ruview
pip install -e .
```

### Option C: Cargo/Rust
```bash
cd projects/ruview
cargo build --release
cargo run --bin wifi-densepose-sensing-server
```

## First Run Checklist

- [ ] Container/environment set up
- [ ] `make status` shows all tools installed
- [ ] `docker ps` shows running containers
- [ ] Dashboard accessible at http://localhost:3000
- [ ] API docs at http://localhost:8000/docs
- [ ] RuView logs show no errors

## Common Issues

### Issue: "Permission denied" for Docker
```bash
sudo usermod -aG docker $USER
newgrp docker
```

### Issue: Port 3000 already in use
```bash
# Find & kill process
lsof -i :3000 | grep LISTEN | awk '{print $2}' | xargs kill -9

# Or use different port
DOCKER_PORT=3001 docker-compose up
```

### Issue: Out of disk space
```bash
# Docker cleanup
docker system prune -a

# Remove old containers
docker container prune
```

### Issue: Python package conflicts
```bash
# Create fresh venv
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

## Next Steps

1. ✅ Follow setup above
2. ✅ Run `make run-docker`
3. ✅ Visit http://localhost:3000
4. ✅ Explore demos: `make demo-presence`
5. ✅ Read: [API Reference](../apps/api/README.md)
6. ✅ Read: [RuView Docs](../projects/ruview/README.md)

---

**Need help?** Check [Codespaces guide](CODESPACE.md) or [RuView docs](../projects/ruview/README.md)
