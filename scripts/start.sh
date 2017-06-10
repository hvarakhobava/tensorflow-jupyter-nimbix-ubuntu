#!/bin/bash

# open ports
iptables -A  INPUT -p tcp --dport 8888 -j ACCEPT
iptables -A  INPUT -p tcp --dport 6006 -j ACCEPT
iptables -A  INPUT -p tcp --dport 5901 -j ACCEPT
iptables -A  INPUT -p tcp --dport 443 -j ACCEPT

screen -d -m /run_jupyter.sh --allow-root
