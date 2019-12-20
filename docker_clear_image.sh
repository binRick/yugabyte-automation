time docker ps -a|grep centos:latest|cut -d' ' -f1|xargs docker rm; docker image rm centos:latest
