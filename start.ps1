# Script de démarrage rapide Orio
# PowerShell

Write-Host "🚀 Démarrage d'Orio..." -ForegroundColor Cyan

# Démarrer Docker Compose
Write-Host "`n📦 Démarrage des containers Docker..." -ForegroundColor Yellow
docker-compose up -d

# Attendre que les services soient prêts
Write-Host "`n⏳ Attente du démarrage des services (10 secondes)..." -ForegroundColor Yellow
Start-Sleep -Seconds 10

Write-Host "`n✅ Orio est prêt !" -ForegroundColor Green
Write-Host "`nServices disponibles:" -ForegroundColor Cyan
Write-Host "  • Frontend: http://localhost:3000" -ForegroundColor White
Write-Host "  • API:      http://localhost:8000" -ForegroundColor White
Write-Host "  • Database: localhost:5432" -ForegroundColor White
Write-Host "`nCommandes utiles:" -ForegroundColor Cyan
Write-Host "  docker-compose logs -f      # Voir les logs" -ForegroundColor White
Write-Host "  docker-compose down         # Arrêter" -ForegroundColor White
Write-Host "  docker-compose restart      # Redémarrer" -ForegroundColor White
