FROM discophusion/discobase

# install pycurl
RUN apt-get install -y python-pycurl

# install disco as node
RUN cd /disco && make install-node prefix=/usr/local

# add environment variable
ENV DISCO_HOME "/usr/local/lib/disco"

# modify DEBIAN_FRONTEND to text
ENV DEBIAN_FRONTEND text

ADD test.sh /

# expose ssh
EXPOSE 22/tcp

CMD ["/sbin/my_init"]
