FROM discophusion/discobase

# requirements for proxy
RUN apt-get install -y python-pycurl lighttpd

# install disco as master
RUN cd /disco && make install prefix=/usr/local

# needed for running disco services
RUN mkdir /etc/service/disco
# don't forget to verify disco.sh is executable
ADD disco.sh /etc/service/disco/run
RUN chmod a+x /etc/service/disco/run

ADD disco-settings.py /etc/disco/settings.py

# expose ssh and disco ports
EXPOSE 22/tcp 8989/tcp 8999/tcp

VOLUME ["/home/disco"]

CMD ["/sbin/my_init"]

