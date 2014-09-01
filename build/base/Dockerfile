FROM phusion/baseimage
MAINTAINER laurent@laurentroger.com
ENV DEBIAN_FRONTEND noninteractive

ADD apt.sources.list /etc/apt/apt.sources.list

RUN apt-get update
RUN apt-get dist-upgrade -y
RUN apt-get install -y curl erlang git make python openssh-server supervisor

# Shut up policy-rc.d
RUN echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d
# setup ssh
RUN echo root:discophusion | chpasswd
RUN mkdir -p /var/run/sshd
# Regenerate SSH host keys
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh
RUN ssh-keygen -A
## passwordless login for root
RUN mkdir -p /root/.ssh
RUN ssh-keygen -N '' -f /root/.ssh/id_dsa
RUN cat /root/.ssh/id_dsa.pub >> /root/.ssh/authorized_keys
RUN echo -n "localhost " > /root/.ssh/known_hosts
RUN cat /etc/ssh/ssh_host_rsa_key.pub >> /root/.ssh/known_hosts

## passwordless login for disco
RUN adduser --system disco --shell /bin/sh
RUN mkdir -p /home/disco/.ssh
RUN ssh-keygen -N '' -f /home/disco/.ssh/id_dsa
RUN cat /home/disco/.ssh/id_dsa.pub >> /home/disco/.ssh/authorized_keys
RUN echo -n "localhost " > /home/disco/.ssh/known_hosts
RUN cat /etc/ssh/ssh_host_rsa_key.pub >> /home/disco/.ssh/known_hosts
RUN chown disco -R /home/disco/.ssh

## install disco
RUN git clone https://github.com/discoproject/disco.git /disco
RUN cd /disco && git checkout tags/0.5.3
RUN cd /disco && git checkout master
RUN cd /disco && make
RUN cd /disco/lib && python setup.py install --user
RUN cd /disco && make install prefix=/usr/local

RUN chown -R disco /usr/local/var/disco

# to debug dns ...
RUN apt-get install -y dnsutils

VOLUME ["/D", "/L"]

