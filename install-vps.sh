#!/bin/bash
# Script d'installation d'Orio sur le serveur existant
# À exécuter sur votre VPS avec nginx déjà installé

set -e

echo "🚀 Installation d'Orio sur orio.xavierjeanne.fr"

# Couleurs
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# 1. Créer le dossier du projet
echo -e "\n${YELLOW}📁 Création du dossier du projet...${NC}"
sudo mkdir -p /var/www/orio
sudo chown $USER:$USER /var/www/orio
cd /var/www/orio

# 2. Cloner le repo (si pas déjà fait)
if [ ! -d ".git" ]; then
    echo -e "\n${YELLOW}📥 Clone du repository...${NC}"
    git clone https://github.com/xavierjeanne/orio.git .
else
    echo -e "\n${YELLOW}📥 Pull des dernières modifications...${NC}"
    git pull origin main
fi

# 3. Configurer l'environnement
echo -e "\n${YELLOW}⚙️  Configuration de l'environnement...${NC}"
if [ ! -f ".env" ]; then
    cp .env.example .env
    echo -e "${YELLOW}⚠️  Fichier .env créé. Veuillez le configurer maintenant.${NC}"
    read -p "Appuyez sur Entrée après avoir configuré le .env..."
fi

# 4. Configurer Nginx
echo -e "\n${YELLOW}🌐 Configuration Nginx...${NC}"
sudo cp nginx/orio.xavierjeanne.fr.conf /etc/nginx/sites-available/orio.xavierjeanne.fr

# Créer le lien symbolique si nécessaire
if [ ! -L "/etc/nginx/sites-enabled/orio.xavierjeanne.fr" ]; then
    sudo ln -s /etc/nginx/sites-available/orio.xavierjeanne.fr /etc/nginx/sites-enabled/
fi

# Tester la config Nginx
echo -e "\n${YELLOW}🧪 Test de la configuration Nginx...${NC}"
sudo nginx -t

# 5. Vérifier que Docker est installé
if ! command -v docker &> /dev/null; then
    echo -e "\n${YELLOW}🐳 Installation de Docker...${NC}"
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    sudo usermod -aG docker $USER
    rm get-docker.sh
fi

if ! command -v docker-compose &> /dev/null; then
    echo -e "\n${YELLOW}🐳 Installation de Docker Compose...${NC}"
    sudo apt install docker-compose -y
fi

# 6. Configurer le pare-feu (si non configuré)
echo -e "\n${YELLOW}🔥 Configuration du pare-feu...${NC}"
if command -v ufw &> /dev/null; then
    sudo ufw allow 56653/tcp
    sudo ufw allow 80/tcp
    sudo ufw allow 443/tcp
fi

# 7. Build et démarrage des containers
echo -e "\n${YELLOW}🐳 Build des images Docker...${NC}"
docker-compose -f docker-compose.prod.yml build

echo -e "\n${YELLOW}🚀 Démarrage des containers...${NC}"
docker-compose -f docker-compose.prod.yml up -d

# Attendre que les services démarrent
echo -e "\n${YELLOW}⏳ Attente du démarrage des services...${NC}"
sleep 10

# 8. Configuration Laravel
echo -e "\n${YELLOW}🔑 Génération de la clé Laravel...${NC}"
docker exec orio-api php artisan key:generate --force

echo -e "\n${YELLOW}📊 Exécution des migrations...${NC}"
docker exec orio-api php artisan migrate --force

echo -e "\n${YELLOW}⚡ Optimisation Laravel...${NC}"
docker exec orio-api php artisan config:cache
docker exec orio-api php artisan route:cache
docker exec orio-api php artisan view:cache

# 9. Redémarrer Nginx
echo -e "\n${YELLOW}🔄 Redémarrage de Nginx...${NC}"
sudo systemctl restart nginx

# 10. SSL avec Let's Encrypt
echo -e "\n${YELLOW}🔒 Configuration SSL...${NC}"
read -p "Voulez-vous configurer SSL avec Let's Encrypt? (o/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Oo]$ ]]; then
    sudo certbot --nginx -d orio.xavierjeanne.fr
fi

# Résumé
echo -e "\n${GREEN}✅ Installation terminée!${NC}"
echo -e "\n${GREEN}Services:${NC}"
echo -e "  • Frontend: http://orio.xavierjeanne.fr"
echo -e "  • API:      http://orio.xavierjeanne.fr/api"
echo -e "\n${GREEN}Commandes utiles:${NC}"
echo -e "  • Logs: docker-compose -f docker-compose.prod.yml logs -f"
echo -e "  • Restart: docker-compose -f docker-compose.prod.yml restart"
echo -e "  • Stop: docker-compose -f docker-compose.prod.yml down"
echo -e "\n${YELLOW}N'oubliez pas de:${NC}"
echo -e "  1. Configurer le DNS: orio.xavierjeanne.fr → IP de votre serveur"
echo -e "  2. Mettre à jour les variables d'environnement dans .env"
echo -e "  3. Créer un utilisateur admin: docker exec orio-api php artisan make:admin"
