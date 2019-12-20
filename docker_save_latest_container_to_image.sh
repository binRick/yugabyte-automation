time docker commit $(docker ps -a|grep centos:latest|head -n1|cut -d' ' -f1) centos:latest
