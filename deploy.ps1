# Script de déploiement production
# PowerShell

param(
    [string]$Environment = "production"
)

Write-Host "🚀 Déploiement Orio - $Environment" -ForegroundColor Cyan

# Vérifier que nous sommes sur la bonne branche
$branch = git branch --show-current
if ($branch -ne "main" -and $Environment -eq "production") {
    Write-Host "❌ ERREUR: Vous devez être sur la branche 'main' pour déployer en production" -ForegroundColor Red
    exit 1
}

# Pull les dernières modifications
Write-Host "`n📥 Pull des dernières modifications..." -ForegroundColor Yellow
git pull origin $branch

# Build et démarrage des containers
Write-Host "`n🐳 Build des images Docker..." -ForegroundColor Yellow
docker-compose -f docker-compose.prod.yml build --no-cache

Write-Host "`n🚀 Démarrage des containers..." -ForegroundColor Yellow
docker-compose -f docker-compose.prod.yml up -d

# Attendre que les services démarrent
Write-Host "`n⏳ Attente du démarrage des services..." -ForegroundColor Yellow
Start-Sleep -Seconds 15

# Migrations
Write-Host "`n📊 Exécution des migrations..." -ForegroundColor Yellow
docker exec -it orio-api php artisan migrate --force

# Optimisations Laravel
Write-Host "`n⚡ Optimisations Laravel..." -ForegroundColor Yellow
docker exec -it orio-api php artisan config:cache
docker exec -it orio-api php artisan route:cache
docker exec -it orio-api php artisan view:cache
docker exec -it orio-api php artisan optimize

Write-Host "`n✅ Déploiement terminé !" -ForegroundColor Green
Write-Host "`nServices:" -ForegroundColor Cyan
Write-Host "  • Frontend: http://localhost:3000" -ForegroundColor White
Write-Host "  • API:      http://localhost:8000" -ForegroundColor White
Write-Host "`nLogs:" -ForegroundColor Cyan
Write-Host "  docker-compose -f docker-compose.prod.yml logs -f" -ForegroundColor White
