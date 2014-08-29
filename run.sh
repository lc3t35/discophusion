#!/bin/bash -ev

docker build -t discophusion/discobase build/base
docker build -t discophusion/discomaster build/master
docker build -t discophusion/discotest build/test

# make sure the old one is gone
docker stop discomaster || true
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
    discophusion/discotest \
    /bin/sh /test.sh
