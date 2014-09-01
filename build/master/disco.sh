#!/bin/sh

# update DNS
NIC="eth0"
MASTER_IP=$(ifconfig $NIC | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}')
echo $MASTER_IP discomaster >> /D/dnsmasq.hosts

# launch disco
exec /sbin/setuser disco /usr/local/bin/disco nodaemon -v >>/L/disco.log 2>&1

