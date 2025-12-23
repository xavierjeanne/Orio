# Script pour démarrer les containers sur le VPS
$VPS_HOST = "xavierjeanne.fr"
$VPS_USER = "ubuntu"
$VPS_PORT = "56653"

Write-Host "=== Démarrage des containers sur VPS ===" -ForegroundColor Cyan

$commands = "cd /var/www/orio && docker-compose -f docker-compose.prod.yml up -d --build && echo '' && echo '=== Containers démarrés ===' && docker-compose -f docker-compose.prod.yml ps"

ssh -p $VPS_PORT "${VPS_USER}@${VPS_HOST}" $commands
