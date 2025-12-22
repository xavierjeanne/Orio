#!/bin/bash

echo "=== Docker Containers Status ==="
docker ps -a

echo -e "\n=== Docker Compose Status ==="
cd /var/www/orio
docker-compose -f docker-compose.prod.yml ps

echo -e "\n=== API Container Logs (last 50 lines) ==="
docker logs --tail 50 orio-api 2>&1 || echo "API container not found"

echo -e "\n=== Frontend Container Logs (last 50 lines) ==="
docker logs --tail 50 orio-frontend 2>&1 || echo "Frontend container not found"

echo -e "\n=== Nginx Error Logs (last 20 lines) ==="
sudo tail -n 20 /var/log/nginx/error.log

echo -e "\n=== Check Ports ==="
sudo netstat -tlnp | grep -E ':(3000|8000|5432|6379)'

echo -e "\n=== Docker Networks ==="
docker network ls
docker network inspect orio_default 2>&1 || echo "Network not found"
