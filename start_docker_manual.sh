echo -ne "Loading Setup  "
source  setup.sh >/dev/null 2>&1
echo -e "OK\n\n"

set -e

echo -ne "Destroying current Docker Cluster  "
time yb-docker-ctl destroy >/dev/null 2>/dev/null
echo -e "OK\n\n"


echo Updating Container Image to Latest
time docker pull yugabytedb/yugabyte >/dev/null
echo -e "OK\n\n"

echo Starting Three Node Cluster
time yb-docker-ctl create --rf 3 >/dev/null 2>&1
echo -e "OK\n\n"

echo -ne "Adding A New Node to Cluster  "
time yb-docker-ctl add_node >/dev/null 2>&1
echo -e "OK\n\n"

echo -ne "Listening Ports  \n"
./get_listening_ports_docker.sh|grep '^[0-9]'
echo -e "OK\n\n"

docker ps
yb-docker-ctl status
