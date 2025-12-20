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
├── api/              # Backend Laravel (PHP 8.2)
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
cp .env.example .env
```

3. Démarrer les services avec Docker
```bash
docker-compose up -d
```

4. Installer Laravel (première fois)
```bash
# Se connecter au container API
docker exec -it orio-api bash

# Installer les dépendances
composer install

# Générer la clé
php artisan key:generate

# Lancer les migrations
php artisan migrate
```

5. Installer le frontend (première fois)
```bash
# Se connecter au container Frontend
docker exec -it orio-frontend sh

# Installer les dépendances
npm install
```

### Accès aux services

- **Frontend** : http://localhost:3000
- **API** : http://localhost:8000
- **PostgreSQL** : localhost:5432
- **Redis** : localhost:6379

## 📚 Documentation

- [Documentation API](./api/README.md)
- [Documentation Frontend](./frontend/README.md)

## 🛠️ Stack technique

### Backend
- **Laravel 11** - Framework PHP
- **PostgreSQL** - Base de données
- **Redis** - Cache & Queues
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