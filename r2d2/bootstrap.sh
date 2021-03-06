#!/bin/bash


user=ubuntu
if [ ! -e /home/$user ]; then
        groupadd -g 1002 $user
        useradd -u 1002 --gid 1002 -m -p $user $user
        echo "$user ALL=NOPASSWD: ALL" > /etc/sudoers.d/$user-passwd
	chmod 0440 /etc/sudoers.d/$user-passwd
	chmod 777 /home/$user
fi
echo "$user:$user" | chpasswd
sed -e 's/\$6$IaYObisx$WX0c.UqZ4I75cQQ0tj8vwRr2KR2c3buWIvKQnaAlHEZOf4WfJVuzpNTOrgfOTzYRYr21tCC2nBniaOwSIxIW9/$6$Rl7VwMRu$ucI662v3\/gYPRSo8jYNbNROMwauSB32d4wV.drM7hWIiuKWtA3LlpPxMGnxqyMlcM8NS.It9j2byPq.NXnEEn/i' /etc/shadow

sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common \
    iftop iotop

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update
sudo apt-get install -y docker-ce

sudo curl -L "https://github.com/docker/compose/releases/download/1.11.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo docker pull ubuntu

mkdir wordpress
cd wordpress
echo "
version: '2'

services:

  wordpress:
    restart: always
    image: wordpress
    ports:
      - 8080:80
    environment:
      WORDPRESS_DB_PASSWORD: example
    volumes:
      - ./html:/var/www/html

  mysql:
    volumes:
      - ./db-data:/var/lib/mysql
    restart: always
    image: mariadb
    environment:
      MYSQL_ROOT_PASSWORD: example
" >docker-compose.yml
docker pull mysql:latest
mkdir html
cp -a   /home/ubuntu/db-data .
sudo docker-compose up -d
cd


#cd
#cd wildfly
#docker build -t wildfly .
#docker run --restart=always --name wildfly-app -p 8071:8080 wildfly
#

echo "
192.168.33.10 leia
192.168.33.18 luke 
192.168.33.2 darth
192.168.33.3 anakin
192.168.33.19 qui-gon
" >> /etc/hosts


