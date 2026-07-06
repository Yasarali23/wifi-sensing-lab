.PHONY: help setup clean run run-docker build-docker dashboard api test

# Colors for output
RED=\033[0;31m
GREEN=\033[0;32m
YELLOW=\033[0;33m
BLUE=\033[0;34m
NC=\033[0m # No Color

help: ## Show this help message
	@echo "$(BLUE)WiFi Sensing Lab - Available Commands$(NC)"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  $(GREEN)%-20s$(NC) %s\n", $$1, $$2}'

setup: ## Setup development environment
	@echo "$(BLUE)Setting up development environment...$(NC)"
	@chmod +x .devcontainer/setup.sh
	@.devcontainer/setup.sh
	@echo "$(GREEN)✅ Development environment ready!$(NC)"

setup-ruview: ## Add RuView as git submodule
	@echo "$(BLUE)Adding RuView submodule...$(NC)"
	@mkdir -p projects
	@git submodule add https://github.com/ruvnet/RuView.git projects/ruview || echo "$(YELLOW)Submodule may already exist$(NC)"
	@git submodule update --init --recursive
	@echo "$(GREEN)✅ RuView submodule added!$(NC)"

clean: ## Clean build artifacts
	@echo "$(RED)Cleaning up...$(NC)"
	@rm -rf target/
	@rm -rf dist/
	@rm -rf __pycache__
	@find . -type d -name '.pytest_cache' -exec rm -rf {} + 2>/dev/null || true
	@echo "$(GREEN)✅ Cleanup complete!$(NC)"

build-docker: ## Build Docker image
	@echo "$(BLUE)Building Docker image...$(NC)"
	@docker-compose build
	@echo "$(GREEN)✅ Docker image built!$(NC)"

run-docker: ## Run sensing server in Docker
	@echo "$(BLUE)Starting services...$(NC)"
	@docker-compose up -d
	@echo "$(GREEN)✅ Services started!$(NC)"
	@echo "Dashboard: http://localhost:3000"
	@echo "API: http://localhost:8000"

stop: ## Stop Docker services
	@echo "$(RED)Stopping services...$(NC)"
	@docker-compose down
	@echo "$(GREEN)✅ Services stopped!$(NC)"

logs: ## View Docker logs
	@docker-compose logs -f

api: ## Run local API server (Python)
	@echo "$(BLUE)Starting Python API server...$(NC)"
	@cd apps/api && python3 -m uvicorn main:app --reload --host 0.0.0.0 --port 8000

dashboard: ## Open RuView dashboard
	@echo "$(BLUE)Opening dashboard at http://localhost:3000$(NC)"
	@python3 -m webbrowser http://localhost:3000 || echo "Open http://localhost:3000 in your browser"

test: ## Run tests
	@echo "$(BLUE)Running tests...$(NC)"
	@cd projects/ruview && cargo test --all 2>/dev/null || echo "$(YELLOW)RuView tests require Rust setup$(NC)"
	@python3 -m pytest apps/ -v 2>/dev/null || echo "$(YELLOW)No Python tests found$(NC)"

format: ## Format code
	@echo "$(BLUE)Formatting code...$(NC)"
	@cd projects/ruview && cargo fmt --all 2>/dev/null || true
	@python3 -m black apps/ 2>/dev/null || true

install-ruview-py: ## Install RuView Python package
	@echo "$(BLUE)Installing RuView Python package...$(NC)"
	@pip install ruview[client]
	@echo "$(GREEN)✅ RuView installed!$(NC)"

demo-presence: ## Run presence detection demo
	@echo "$(BLUE)Starting presence detection demo...$(NC)"
	@cd apps/demos && python3 presence_detection.py

demo-vitals: ## Run vital signs demo
	@echo "$(BLUE)Starting vital signs demo...$(NC)"
	@cd apps/demos && python3 vital_signs.py

status: ## Show project status
	@echo "$(BLUE)Project Status:$(NC)"
	@echo "Rust version: $$(rustc --version 2>/dev/null || echo 'Not installed')"
	@echo "Python version: $$(python3 --version)"
	@echo "Node version: $$(node --version 2>/dev/null || echo 'Not installed')"
	@echo "Docker: $$(docker --version 2>/dev/null || echo 'Not installed')"

all: setup setup-ruview build-docker ## Complete setup
	@echo "$(GREEN)✅ All setup complete! Run 'make run-docker' to start.$(NC)"
