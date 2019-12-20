
set -e
docker-compose up -d

./start_redis_server.py

IP=$(./getLocalAddress.sh)

echo YugaByte DB Admin:     http://$IP:7000/
echo YugaByte Dashboard:    http://$IP:9000/
