export DISCO_MASTER_HOST=${DISCOMASTER_PORT_8989_TCP_ADDR}
export DISCO_PROXY=http://${DISCOMASTER_PORT_8999_TCP_ADDR}:8999

# update DNS
NIC="eth0"
TEST_IP=$(ifconfig $NIC | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}')
echo $TEST_IP discotest >> /D/dnsmasq.hosts

env
su -c "python /disco/examples/util/count_words.py" disco
exit
