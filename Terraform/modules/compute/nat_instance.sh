#!/bin/bash
echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf  
sysctl -p
yum install iptables-services -y
systemctl start iptables
systemctl enable iptables
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -F FORWARD
service iptables save