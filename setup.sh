#/bin/sh

# install some tools
sudo yum install -y git vim gcc glibc-static telnet

sudo yum install -y epel-release
sudo yum install -y python-pip
sudo pip install docker-compose

# install docker
curl -fsSL get.docker.com -o get-docker.sh
sh get-docker.sh

# start docker service
sudo groupadd docker
sudo gpasswd -a vagrant docker
sudo systemctl start docker
sudo service docker start

rm -rf get-docker.sh
