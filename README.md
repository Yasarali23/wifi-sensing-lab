# 🛰️ WiFi Sensing Lab

A comprehensive platform for WiFi-based spatial intelligence and human pose estimation using **RuView**.

## 🎯 What is This?

This project integrates [RuView](https://github.com/ruvnet/RuView) — a WiFi DensePose sensing platform — with a complete development and deployment stack optimized for **GitHub Codespaces**.

**Key Capabilities:**
- 🫁 **Vital Signs Monitoring** - Breathing and heart rate detection (contactless)
- 👤 **Presence Detection** - Through-wall occupancy sensing
- 💀 **Pose Estimation** - 17-point body skeleton from WiFi signals
- 🧱 **Through-Wall Sensing** - Works in darkness, through walls, no cameras
- 🏠 **Smart Home Ready** - Home Assistant + Matter integration

## 🚀 Quick Start (Codespaces)

### Option 1: One-Command Setup
```bash
make all
make run-docker
```

### Option 2: Step-by-Step

**1. Setup environment**
```bash
make setup
```

**2. Add RuView submodule**
```bash
make setup-ruview
```

**3. Build and run Docker services**
```bash
make build-docker
make run-docker
```

**4. Open dashboard**
```bash
make dashboard
```
Dashboard opens at: **http://localhost:3000**

## 📁 Project Structure

```
wifi-sensing-lab/
├── .devcontainer/          # Codespace configuration
│   ├── devcontainer.json   # Container specs
│   └── setup.sh            # Auto-setup script
├── projects/
│   └── ruview/             # RuView submodule (main sensing engine)
├── apps/
│   ├── api/                # Python FastAPI backend
│   ├── dashboard/          # Web UI (React/Vue)
│   └── demos/              # Example applications
├── data/                   # CSI data & models
├── config/                 # Configuration files
├── Makefile                # Development commands
├── docker-compose.yml      # Service orchestration
└── README.md              # This file
```

## 🔧 Available Commands

```bash
make help              # Show all commands
make setup             # Install dependencies
make setup-ruview      # Clone RuView submodule
make build-docker      # Build Docker images
make run-docker        # Start all services
make stop              # Stop services
make logs              # View service logs
make clean             # Clean build artifacts
make test              # Run tests
make status            # Show system status
```

## 🎮 Demo Applications

### Presence Detection
```bash
make demo-presence
```
Detects people through walls using WiFi signals.

### Vital Signs
```bash
make demo-vitals
```
Monitors breathing and heart rate contactlessly.

## 📊 Services & Ports

| Service | Port | Purpose |
|---------|------|----------|
| RuView Dashboard | 3000 | Real-time visualization |
| WiFi CSI Stream | 5006 | CSI data streaming |
| API Server | 8000 | REST API |
| MQTT Broker | 1883 | Message exchange |

## 🔌 Hardware Setup (Optional)

For live WiFi sensing with real hardware:

```bash
# Flash ESP32-S3 ($9)
python -m esptool --chip esp32s3 --port COM9 --baud 460800 \
  write_flash 0x0 bootloader.bin 0x8000 partition-table.bin

# Provision WiFi
python firmware/esp32-csi-node/provision.py --port COM9 \
  --ssid "YourWiFi" --password "secret" --target-ip 192.168.1.20
```

Or use Docker simulation:
```bash
make run-docker
# Uses `CSI_SOURCE=simulated` by default
```

## 📚 Documentation

- **[RuView Docs](projects/ruview/README.md)** - Full project documentation
- **[Setup Guide](docs/SETUP.md)** - Detailed installation instructions
- **[Codespace Guide](docs/CODESPACE.md)** - GitHub Codespaces tips
- **[API Reference](apps/api/README.md)** - REST API docs
- **[Architecture](docs/ARCHITECTURE.md)** - System design

## 🔐 Home Assistant Integration

Add to Home Assistant:
```yaml
mqtt:
  broker: mqtt-broker
  port: 1883
  username: homeassistant
  password: your_password
```

RuView publishes entities:
- `sensor.breathing_rate` (BPM)
- `sensor.heart_rate` (BPM)
- `binary_sensor.presence_detection`
- `sensor.room_occupancy`

## 🤖 AI Models

Pretrained models from Hugging Face:

```bash
# Download pretrained weights
huggingface-cli download ruvnet/wifi-densepose-pretrained \
  --local-dir models/wifi-densepose-pretrained

# Quantized versions available:
# - model-q2.bin (4 KB)   - Ultra-light
# - model-q4.bin (8 KB)   - Recommended
# - model-q8.bin (16 KB)  - Better accuracy
# - model.safetensors (48 KB) - Full precision
```

## 🧪 Testing

```bash
# Run all tests
make test

# Python tests
python3 -m pytest apps/ -v

# Rust tests (requires RuView setup)
cd projects/ruview && cargo test --all
```

## 📊 Benchmarks

| Metric | Performance |
|--------|-------------|
| Breathing Detection | 6-30 BPM, real-time |
| Heart Rate | 40-120 BPM, real-time |
| Presence Accuracy | 82.3% (temporal-triplet) |
| Pose PCK@20 | ~2.5% (zero-shot), 35%+ (supervised) |
| Fall Detection | <200ms latency |
| Throughput | 164K embeddings/sec |
| Model Size | 8 KB (int4 quantized) |

## 🛠️ Development

### Code Formatting
```bash
make format
```

### View Logs
```bash
make logs
```

### Check Status
```bash
make status
```

## 🐛 Troubleshooting

### Port Already in Use
```bash
# Find process using port
lsof -i :3000

# Kill process
kill -9 <PID>
```

### Docker Issues
```bash
# Rebuild containers
make clean
make build-docker

# View logs
make logs
```

### Codespace Storage
Clean old data:
```bash
rm -rf data/csi-cache
rm -rf models/cache
```

## 📄 License

MIT License - See [LICENSE](LICENSE)

RuView itself is also MIT licensed - See [projects/ruview/LICENSE](projects/ruview/LICENSE)

## 🤝 Contributing

1. Create a branch: `git checkout -b feature/your-feature`
2. Commit changes: `git commit -am 'Add feature'`
3. Push: `git push origin feature/your-feature`
4. Open a Pull Request

## 📞 Support

- **GitHub Issues**: [Report bugs](../../issues)
- **Discussions**: [Ask questions](../../discussions)
- **RuView Docs**: [Official docs](projects/ruview/README.md)
- **RuView Issues**: [RuView issues](https://github.com/ruvnet/RuView/issues)

## 🎓 Learn More

- [RuView GitHub](https://github.com/ruvnet/RuView)
- [WiFi DensePose Paper](https://arxiv.org/abs/2309.12775)
- [Cognitum Seed](https://cognitum.one)
- [Home Assistant Integration](https://www.home-assistant.io/)

---

**Made with ❤️ for WiFi sensing enthusiasts**
