
REMOTE_HOST=xxxxxxxx

time sh -c "docker ps -a |cut -d' ' -f1|grep -v CONTA|xargs docker rm; docker image rm centos:latest;  time ssh -q root@$REMOTE_HOST 'unlink /root/centos-latest.tar; docker save centos:latest -o /root/centos-latest.tar' && rsync root@${REMOTE_HOST}:centos-latest.tar ~/ && time docker load < ~/centos-latest.tar"
