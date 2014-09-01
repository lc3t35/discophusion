FROM ubuntu
VOLUME [ "/dnsmasq.hosts" ]
ENV DEBIAN_FRONTEND noninteractive
ADD apt.sources.list /etc/apt/apt.sources.list

# Shut up policy-rc.d
RUN echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d

RUN apt-get update
RUN apt-get dist-upgrade -y
RUN apt-get install -y --force-yes dnsmasq-base dnsutils

ADD dnsmasq.conf /etc/dnsmasq.conf
ADD resolv.dnsmasq.conf /etc/resolv.dnsmasq.conf
EXPOSE 5353/udp
CMD ["/usr/sbin/dnsmasq", "-d"]
#ENTRYPOINT ["/usr/sbin/dnsmasq"]
