# Script d'arrêt Orio
# PowerShell

Write-Host "🛑 Arrêt d'Orio..." -ForegroundColor Yellow

docker-compose down

Write-Host "`n✅ Tous les services sont arrêtés." -ForegroundColor Green
