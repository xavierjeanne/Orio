.PHONY: help test lint lint-fix test-backend test-frontend lint-backend lint-frontend build up down

help: ## Affiche l'aide
	@echo "Commandes disponibles:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'

test: ## Lance tous les tests
	@echo "🧪 Running all tests..."
	@docker exec orio-api php artisan test
	@docker exec orio-frontend npm run lint

test-backend: ## Lance les tests backend
	@docker exec orio-api php artisan test

test-frontend: ## Lance les tests frontend
	@docker exec orio-frontend npm run lint

lint: ## Vérifie le code style
	@echo "🔍 Checking code style..."
	@docker exec orio-api vendor/bin/pint --test
	@docker exec orio-frontend npm run lint

lint-fix: ## Corrige le code style automatiquement
	@echo "🔧 Fixing code style..."
	@docker exec orio-api vendor/bin/pint
	@docker exec orio-frontend npm run lint

lint-backend: ## Vérifie le code style backend
	@docker exec orio-api vendor/bin/pint --test

lint-frontend: ## Vérifie le code style frontend
	@docker exec orio-frontend npm run lint

build: ## Build les containers Docker
	docker compose --profile dev build

up: ## Démarre les containers
	docker compose --profile dev up -d

down: ## Arrête les containers
	docker compose down

logs: ## Affiche les logs
	docker compose logs -f

precommit: lint test ## Vérifie avant commit (lint + tests)
