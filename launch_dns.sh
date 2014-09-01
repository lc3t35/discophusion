NIC="docker0"
HOST_IP=$(ifconfig $NIC | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}')
docker kill dns-server || true
docker rm dns-server || true
docker run -t -i --rm -v /D/dnsmasq.hosts:/D/dnsmasq.hosts --name dns-server -p $HOST_IP:53:5353/udp discophusion/dnsmasq $*
