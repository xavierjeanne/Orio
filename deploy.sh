#!/bin/bash
# Script de déploiement pour serveur Linux/VPS

set -e

ENV=${1:-production}
BRANCH=${2:-main}

echo "🚀 Déploiement Orio - $ENV"

# Couleurs
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Vérifier que nous sommes sur la bonne branche
CURRENT_BRANCH=$(git branch --show-current)
if [ "$CURRENT_BRANCH" != "$BRANCH" ] && [ "$ENV" == "production" ]; then
    echo -e "${RED}❌ ERREUR: Vous devez être sur la branche '$BRANCH' pour déployer en production${NC}"
    exit 1
fi

# Pull les dernières modifications
echo -e "\n${YELLOW}📥 Pull des dernières modifications...${NC}"
git pull origin $BRANCH

# Copier le fichier .env si nécessaire
if [ ! -f .env ]; then
    echo -e "\n${YELLOW}📝 Création du fichier .env...${NC}"
    cp .env.example .env
    echo -e "${RED}⚠️  N'oubliez pas de configurer les variables d'environnement dans .env${NC}"
    exit 1
fi

# Build des images Docker
echo -e "\n${YELLOW}🐳 Build des images Docker...${NC}"
docker-compose -f docker-compose.prod.yml build --no-cache

# Arrêter les anciens containers
echo -e "\n${YELLOW}🛑 Arrêt des anciens containers...${NC}"
docker-compose -f docker-compose.prod.yml down

# Démarrer les nouveaux containers
echo -e "\n${YELLOW}🚀 Démarrage des nouveaux containers...${NC}"
docker-compose -f docker-compose.prod.yml up -d

# Attendre que les services démarrent
echo -e "\n${YELLOW}⏳ Attente du démarrage des services...${NC}"
sleep 15

# Migrations
echo -e "\n${YELLOW}📊 Exécution des migrations...${NC}"
docker exec orio-api php artisan migrate --force

# Optimisations Laravel
echo -e "\n${YELLOW}⚡ Optimisations Laravel...${NC}"
docker exec orio-api php artisan config:cache
docker exec orio-api php artisan route:cache
docker exec orio-api php artisan view:cache
docker exec orio-api php artisan optimize

# Nettoyage
echo -e "\n${YELLOW}🧹 Nettoyage des images inutilisées...${NC}"
docker image prune -f

echo -e "\n${GREEN}✅ Déploiement terminé !${NC}"
echo -e "\n${CYAN}Services:${NC}"
echo -e "  • Frontend: http://localhost:3000"
echo -e "  • API:      http://localhost:8000"
echo -e "\n${CYAN}Logs:${NC}"
echo -e "  docker-compose -f docker-compose.prod.yml logs -f"
echo -e "\n${CYAN}Status:${NC}"
docker-compose -f docker-compose.prod.yml ps
