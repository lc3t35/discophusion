Docker files for Disco
----------------------
Based on github.com/gijzelaerr/discodocker

The idea is to use https://github.com/phusion/baseimage-docker rather
than ubuntu and supervisord to launch disco.

First create /L and /D on your host

You can try :
# run.sh
It will build the images, run a master and a test node with count_word.py

you can watch from the docker host what happens inside with
# tail -f /L/disco.log
# docker logs -f discomaster

Or if you want more control, launch a master :
% docker stop discomaster
% docker rm discomaster
% launch_master

Launch a test in interactive mode :
% launch_test bash
