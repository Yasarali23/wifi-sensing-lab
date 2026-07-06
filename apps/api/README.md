# WiFi Sensing API Server

FastAPI-based REST API for WiFi-based spatial intelligence.

## Quick Start

### Docker
```bash
docker-compose up api-server
```

### Local
```bash
pip install -r requirements.txt
python main.py
```

## API Documentation

Interactive docs available at: **http://localhost:8000/docs**

## Endpoints

### Health & Status
- `GET /health` - Health check
- `GET /status` - System status
- `GET /` - API info

### Sensing Data
- `GET /api/v1/presence?room_id=kitchen` - Get occupancy
- `GET /api/v1/vitals?person_id=0` - Get breathing/heart rate
- `GET /api/v1/pose?person_id=0` - Get body pose
- `POST /api/v1/sensing` - Submit sensing data

### Configuration
- `GET /api/v1/config` - Get current config

## Development

```bash
# Install dev dependencies
pip install -r requirements.txt pytest pytest-asyncio

# Run tests
pytest -v

# Run with auto-reload
python main.py
```

## Environment Variables

```bash
RUVIEW_HOST=localhost      # RuView server host
RUVIEW_PORT=5006          # RuView CSI port
API_LOG_LEVEL=debug       # Log level
CSI_SOURCE=simulated      # CSI data source
```
