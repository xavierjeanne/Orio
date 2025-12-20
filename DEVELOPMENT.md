# Guide de développement Orio

## Commandes utiles

### Docker

```bash
# Démarrer tous les services
docker-compose up -d

# Arrêter tous les services
docker-compose down

# Voir les logs
docker-compose logs -f

# Reconstruire les images
docker-compose build

# Redémarrer un service spécifique
docker-compose restart api
docker-compose restart frontend
```

### Laravel (API)

```bash
# Accéder au container
docker exec -it orio-api bash

# Migrations
php artisan migrate
php artisan migrate:fresh --seed

# Créer un modèle avec migration et controller
php artisan make:model Event -mcr

# Créer un controller
php artisan make:controller EventController

# Lancer les tests
php artisan test

# Nettoyer le cache
php artisan cache:clear
php artisan config:clear
php artisan route:clear
```

### Next.js (Frontend)

```bash
# Accéder au container
docker exec -it orio-frontend sh

# Installer une dépendance
npm install [package-name]

# Lancer en mode dev
npm run dev

# Build pour production
npm run build
npm start
```

## Structure du projet

### API Laravel

```
api/
├── app/
│   ├── Http/Controllers/     # Controllers
│   ├── Models/               # Modèles Eloquent
│   └── Services/             # Logique métier
├── database/
│   ├── migrations/           # Migrations DB
│   └── seeders/              # Données de test
├── routes/
│   └── api.php              # Routes API
└── tests/                   # Tests
```

### Frontend Next.js

```
frontend/
├── src/
│   ├── app/                 # App Router (Next.js 14)
│   │   ├── layout.tsx      # Layout principal
│   │   └── page.tsx        # Page d'accueil
│   ├── components/         # Composants réutilisables
│   ├── lib/               # Utilitaires
│   └── types/             # Types TypeScript
└── public/                # Fichiers statiques
```

## Conventions de code

### Git

```bash
# Format des commits
feat: Ajouter authentification utilisateur
fix: Corriger bug géolocalisation
docs: Mettre à jour README
refactor: Restructurer services events
test: Ajouter tests pour Event model
```

### Branches

- `main` - Production
- `develop` - Développement
- `feature/nom-feature` - Nouvelles fonctionnalités
- `fix/nom-bug` - Corrections de bugs

## Prochaines étapes (Phase 2)

1. **Authentification**
   - Setup Laravel Sanctum
   - Endpoints register/login/logout
   - Middleware d'auth
   - Gestion des rôles (admin, user, organizer)

2. **Modèles de données**
   ```
   Users (avec roles)
   Events (titre, description, date, lieu)
   Venues (nom, adresse, coordonnées GPS)
   Categories
   ```

3. **API REST**
   - GET /api/events - Liste des événements
   - POST /api/events - Créer un événement
   - GET /api/events/{id} - Détails d'un événement
   - GET /api/venues - Liste des lieux
