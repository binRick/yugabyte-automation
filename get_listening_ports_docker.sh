netstat -alntp | grep LISTEN|grep docker-proxy|tr -s ' '|cut -d' ' -f4|sed 's/://g'
