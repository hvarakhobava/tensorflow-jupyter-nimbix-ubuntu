#!/bin/bash
#start ssh
sudo service ssh start

# open ports
sudo iptables -A  INPUT -p tcp --dport 8888 -j ACCEPT
sudo iptables -A  INPUT -p tcp --dport 6006 -j ACCEPT
sudo iptables -A  INPUT -p tcp --dport 5901 -j ACCEPT
sudo iptables -A  INPUT -p tcp --dport 443 -j ACCEPT

sudo cp -r /root/.jupyter /home/nimbix/
sudo chown -R nimbix /home/nimbix/.jupyter
jupyter-notebook & tensorboard --logdir=/tmp/tensorboard

