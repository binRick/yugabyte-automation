set -e


REMOTE_HOST=xxxxxxxx

ssh root@$REMOTE_HOST docker images|grep '^centos '|grep ' latest '

docker ps -a |cut -d' ' -f1|grep -v CONTA|xargs docker rm

docker image rm centos:latest -f


time ssh -q root@$REMOTE_HOST \
	'unlink /root/centos-latest.tar; \
  	docker save centos:latest -o /root/centos-latest.tar'


time rsync root@${REMOTE_HOST}:centos-latest.tar ~/

time docker load < ~/centos-latest.tar
