
[[ ! -d ~/yugabyte ]] && mkdir ~/yugabyte
[[ ! -d ~/.local/bin ]] && mkdir -p ~/.local/bin
echo $PATH|grep ~/.local/bin -q || export PATH=~/.local/bin:$PATH

command -v docker-compose >/dev/null 2>&1 || yum -y install docker-compose
[[ ! -f yugabyte-2.0.8.0-linux.tar.gz ]] && wget https://downloads.yugabyte.com/yugabyte-2.0.8.0-linux.tar.gz
[[ ! -d yugabyte-2.0.8.0 ]] && tar zxvf yugabyte-2.0.8.0-linux.tar.gz

[[ -f yugabyte-2.0.8.0/.post_install.sh.completed ]] || yugabyte-2.0.8.0/bin/post_install.sh

echo yugabyte-2.0.8.0/bin/
ls --color=auto yugabyte-2.0.8.0/bin/

echo $PATH|grep $(pwd)/yugabyte-2.0.8.0/bin -q || export PATH=$(pwd)/yugabyte-2.0.8.0/bin:$PATH





[[ -f ~/.local/bin/yb-docker-ctl ]] || wget -q4 https://raw.githubusercontent.com/yugabyte/yugabyte-db/master/bin/yb-docker-ctl -O ~/.local/bin/yb-docker-ctl
chmod +x ~/.local/bin/yb-docker-ctl


