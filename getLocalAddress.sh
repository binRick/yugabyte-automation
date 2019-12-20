ifconfig $(netstat -rn|grep ^0.0.0.0|tr -s ' '|cut -d' ' -f8)|grep inet|grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b"|head -n1
