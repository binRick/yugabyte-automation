set -e
. setup.sh >/dev/null

MASTER_CMD="./bin/yb-master                                     \
      --master_addresses 172.151.22.109:7100          \
      --fs_data_dirs /mnt/data                        \
      --replication_factor=1                          \
      --rpc_bind_addresses 172.151.22.109:7100        \
      --server_broadcast_addresses 52.12.222.212:7100 \
      --use_private_ip=cloud                          \
      2>&1 > yb-master.out "


echo $MASTER_CMD
