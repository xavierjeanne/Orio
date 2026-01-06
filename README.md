# 🎉 Orio - Agrégateur d'événements

Plateforme de découverte et d'agrégation d'événements avec géolocalisation.

## 🎯 Vision

Orio permet aux utilisateurs de découvrir facilement les événements qui se passent autour d'eux grâce à une interface intuitive avec carte interactive, filtres intelligents et notifications personnalisées.

## 🗺️ Roadmap

### ✅ Phase 1 — Fondation (EN COURS)
- [x] Repo GitHub
- [x] Docker compose minimal
- [x] Laravel API
- [x] Next.js Frontend

### 📋 Phase 2 — Core métier
- [ ] Authentification + RBAC (Role-Based Access Control)
- [ ] Gestion des événements (Events)
- [ ] Gestion des lieux (Venues)
- [ ] Système de géolocalisation

### 🎨 Phase 3 — UX
- [ ] Carte interactive
- [ ] Système de filtres avancés
- [ ] Optimisation SEO

### 🤖 Phase 4 — Automatisation
- [ ] Scraper Python pour agrégation automatique
- [ ] Tâches CRON
- [ ] Système de notifications

## 🏗️ Architecture

```
orio/
├── api/              # Backend Laravel (PHP 8.3)
├── frontend/         # Frontend Next.js (TypeScript)
├── scraper/          # Scraper Python (à venir)
└── docker-compose.yml
```

## 🚀 Démarrage rapide

### Prérequis
- Docker & Docker Compose
- Git

### Installation

1. Cloner le repository
```bash
git clone https://github.com/xavierjeanne/orio.git
cd orio
```

2. Copier les fichiers d'environnement
```bash
# Windows (PowerShell)
Copy-Item .env.example .env
Copy-Item api/.env.example api/.env

# Linux/Mac
cp .env.example .env
cp api/.env.example api/.env
```

3. Démarrer les services avec Docker
```bash
# Environnement de développement (avec Adminer)
docker compose --profile dev up -d --build

# Environnement de production (sans Adminer)
docker compose -f docker-compose.prod.yml up -d --build
```

> ⚠️ **Note** : Les dépendances (Composer et npm) sont installées automatiquement lors du build Docker

4. Initialiser Laravel (première fois uniquement)
```bash
# Générer la clé d'application
docker exec orio-api php artisan key:generate

# Lancer les migrations
docker exec orio-api php artisan migrate

# (Optionnel) Remplir avec des données de test
docker exec orio-api php artisan db:seed
```

### Accès aux services

- **Frontend** : http://localhost:3000
- **API** : http://localhost:8000
- **PostgreSQL** : localhost:5432 (user: `orio`, password: `orio_password`, db: `orio`)
- **Redis** : localhost:6379
- **Adminer** (gestion BDD - DEV uniquement) : http://localhost:8081

> ⚠️ **Sécurité** : Adminer est disponible uniquement en mode développement via le profil `--profile dev`. Il n'est pas inclus en production pour des raisons de sécurité.

## 🧪 Tests et Qualité du Code

### Vérifications manuelles

```bash
# Tous les tests et linters
npm run precommit

# Tests uniquement
npm run test              # Backend + Frontend
npm run test:backend      # PHPUnit (Laravel)
npm run test:frontend     # ESLint (Next.js)

# Linters uniquement
npm run lint              # Backend + Frontend (mode check)
npm run lint:fix          # Backend + Frontend (auto-fix)
npm run lint:backend      # Laravel Pint
npm run lint:frontend     # ESLint
```

### Avec Makefile (Linux/Mac/WSL)

```bash
make help          # Afficher toutes les commandes
make precommit     # Lancer tous les tests et linters
make test          # Tests backend + frontend
make lint          # Vérifier le code style
make lint-fix      # Corriger automatiquement le code style
```

### Git Hook Pre-commit

Un **hook pre-commit** a été configuré pour exécuter automatiquement les vérifications avant chaque commit :
- ✅ Laravel Pint (style PHP)
- ✅ PHPUnit (tests backend)
- ✅ ESLint (style TypeScript)

Le commit sera **bloqué** si une vérification échoue. Pour contourner temporairement (déconseillé) :
```bash
git commit --no-verify -m "message"
```

## 📚 Documentation

- [Documentation API](./api/README.md)
- [Documentation Frontend](./frontend/README.md)

## 🛠️ Stack technique

### Backend
- **Laravel 12** - Framework PHP
- **PHP 8.3** - Langage backend
- **PostgreSQL 15** - Base de données
- **Redis 7** - Cache & Queues
- **Sanctum** - Authentification API

### Frontend
- **Next.js 14** - Framework React avec App Router
- **TypeScript** - Langage typé
- **Tailwind CSS** - Framework CSS (à intégrer)

### DevOps
- **Docker** - Containerisation
- **Docker Compose** - Orchestration locale

### À venir
- **Python** - Scraper d'événements
- **Leaflet/Mapbox** - Cartes interactives
- **Meilisearch/Algolia** - Recherche avancée

## 🔄 CI/CD

Le projet utilise **GitHub Actions** pour l'intégration et le déploiement continus.

### Workflows automatisés
- ✅ Tests backend (Laravel + PHPUnit)
- ✅ Tests frontend (Next.js + ESLint)
- 🐳 Build Docker automatique
- 🔒 Audit de sécurité
- 🚀 Déploiement automatique sur `main`

![Backend CI](https://github.com/xavierjeanne/orio/actions/workflows/backend-ci.yml/badge.svg)
![Frontend CI](https://github.com/xavierjeanne/orio/actions/workflows/frontend-ci.yml/badge.svg)

📖 Voir [CI-CD.md](./CI-CD.md) pour plus de détails

## 🚀 Déploiement

### Déploiement local (production)
```bash
# Windows
.\deploy.ps1

# Linux/Mac
chmod +x deploy.sh
./deploy.sh
```

### Déploiement sur VPS
Voir le guide complet dans [CI-CD.md](./CI-CD.md)

## 🤝 Contribution

Ce projet est en développement actif. Les contributions seront les bienvenues une fois la phase 1 complétée.

### Workflow de contribution
1. Fork le projet
2. Créer une branche (`git checkout -b feature/AmazingFeature`)
3. Commit les changements (`git commit -m 'feat: Add AmazingFeature'`)
4. Push vers la branche (`git push origin feature/AmazingFeature`)
5. Ouvrir une Pull Request

## 📄 Licence

À définir

## 👤 Auteur

Xavier Jeanne - [GitHub](https://github.com/xavierjeanne)