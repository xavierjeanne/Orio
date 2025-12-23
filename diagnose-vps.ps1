# Script de diagnostic VPS
$VPS_HOST = "xavierjeanne.fr"
$VPS_USER = "ubuntu"
$VPS_PORT = "56653"

Write-Host "=== Diagnostic VPS Orio ===" -ForegroundColor Cyan

$commands = @"
cd /var/www/orio && echo '=== État des containers ===' && docker-compose -f docker-compose.prod.yml ps && echo '' && echo '=== Logs API ===' && docker-compose -f docker-compose.prod.yml logs --tail 30 api && echo '' && echo '=== Logs Frontend ===' && docker-compose -f docker-compose.prod.yml logs --tail 30 frontend && echo '' && echo '=== Git status ===' && git log -1 --oneline
"@

ssh -p $VPS_PORT "${VPS_USER}@${VPS_HOST}" $commands
