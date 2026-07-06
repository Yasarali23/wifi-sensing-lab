# 🚀 GitHub Codespaces Setup Guide

## Quick Start

1. **Open Codespace** (automatically configured via `.devcontainer/devcontainer.json`)
2. **Wait** for container to build (~2-3 minutes)
3. **Run setup**:
   ```bash
   make all
   ```
4. **Start services**:
   ```bash
   make run-docker
   ```
5. **Open dashboard** at `http://localhost:3000`

## What's Pre-installed

✅ Rust 1.75+
✅ Python 3.11
✅ Node.js 18
✅ Docker & Docker Compose
✅ VS Code Extensions:
- Rust Analyzer
- Python + Pylance
- Docker
- Makefile Tools
- GitHub Copilot

## Environment Variables

Automatically set in Codespace:
```bash
RUST_LOG=debug
CSI_SOURCE=simulated  # Use demo data, no hardware
DEMO_MODE=true
```

## Storage Limits

Codespaces provide **32 GB** total:

```bash
# Check usage
df -h /workspaces/

# Clear cache if needed
rm -rf ~/.cargo/registry/cache
rm -rf ~/.cache/pip
rm -rf data/csi-large-datasets
```

## Port Forwarding

Automatically exposed ports:
- **3000** - RuView Dashboard
- **5006** - WiFi CSI Stream
- **8000** - API Server
- **8080** - Dev server

Browse them directly from the Ports tab in Codespace.

## Commands

```bash
# Setup everything
make all

# Start services
make run-docker

# View logs
make logs

# Stop services
make stop

# Run demos
make demo-presence
make demo-vitals

# Check status
make status
```

## Tips & Tricks

### 1. Keep Codespace Running
- Codespaces auto-suspend after 30 minutes of inactivity
- Access from: `github.com/codespaces`

### 2. SSH into Codespace (Optional)
```bash
gh codespace ssh -c <codespace-name>
```

### 3. Rebuild Container
```bash
# In VS Code Command Palette (Ctrl+Shift+P):
Codespaces: Rebuild Container
```

### 4. View Container Logs
```bash
gh codespace logs
```

### 5. Sync with GitHub
```bash
git pull origin main
git push origin your-branch
```

## Bandwidth Optimization

Codespaces use shared bandwidth. To optimize:

1. **Use docker-compose.override.yml** - Lighter configs for dev
2. **Cache Python packages**:
   ```bash
   pip install --cache-dir ~/.cache/pip <packages>
   ```
3. **Skip large models initially**:
   ```bash
   # Don't run `make install-ruview-py` until needed
   ```

## Troubleshooting

### Container Fails to Build
```bash
# Rebuild from scratch
gh codespace rebuild
```

### Port 3000 Not Responding
```bash
# Check if service is running
make logs

# Restart services
make stop
make run-docker
```

### Out of Storage
```bash
# Clean Docker cache
docker system prune -a

# Clean pip cache
rm -rf ~/.cache/pip
```

### Slow Performance
- Codespaces run on 2-core machines by default
- Consider upgrading to 4-core for better performance
- Check `top` or `docker stats` to see resource usage

## Development Workflow

```bash
# 1. Create branch
git checkout -b feature/my-feature

# 2. Make changes
# ... edit files ...

# 3. Test
make test

# 4. Format
make format

# 5. Commit
git add .
git commit -m "Add my feature"

# 6. Push
git push origin feature/my-feature

# 7. Create PR on GitHub
```

## VS Code Customization

Edit `.devcontainer/devcontainer.json` to add more:

```json
{
  "customizations": {
    "vscode": {
      "extensions": [
        "eamodio.gitlens",
        "ms-vscode.makefile-tools",
        "redhat.vscode-yaml"
      ]
    }
  }
}
```

Then rebuild: `Codespaces: Rebuild Container`

## Next Steps

1. ✅ Run `make all` to setup
2. ✅ Run `make run-docker` to start services
3. ✅ Open dashboard: http://localhost:3000
4. ✅ Explore demos: `make demo-presence`
5. ✅ Read docs: [docs/SETUP.md](SETUP.md)

---

**Happy coding! 🎉**
