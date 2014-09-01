#!/bin/bash -ev

docker build -t discophusion/discobase build/base
docker build -t discophusion/discomaster build/master
docker build -t discophusion/discotest build/test
docker build -t discophusion/dnsmasq build/dnsmasq

rm /D/dnsmasq.hosts

# make sure the old one is gone
docker kill discomaster || true
docker rm discomaster || true

docker run \
    -d \
    -t \
    -p 2222:22 \
    -p 8989:8989 \
    -v /D:/D \
    -v /L:/L \
    --name discomaster \
    --hostname discomaster \
    --dns=[8.8.8.8] \
    discophusion/discomaster

docker port discomaster 22
docker port discomaster 8989

docker run \
    -t \
    -i \
    --rm \
    --link=discomaster:discomaster \
    --volumes-from discomaster \
    --hostname discotest \
    --dns=[8.8.8.8] \
    discophusion/discotest \
    /bin/sh /test.sh

# DNS setup
NIC="docker0"
HOST_IP=$(ifconfig $NIC | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}')
docker kill dns-server || true
docker rm dns-server || true
docker run \
    -v /D/dnsmasq.hosts:/dnsmasq.hosts \
    --name dns-server \
    -p $HOST_IP:53:5353/udp \
    -d
    discophusion/dnsmasq
