FROM discophusion/discobase

# install disco as node
RUN cd /disco && make install-node prefix=/usr/local

ADD test.sh /

# expose ssh
EXPOSE 22/tcp

CMD ["/sbin/my_init"]
