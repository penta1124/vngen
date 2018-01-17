if [ "`whoami`" != "root" ]; then
    echo "Require root privilege"; exit 1
fi

if [ $# != 2 ]; then
    echo "usage: $0 NETNS:DEV[@ADDR] NETNS:DEV[@ADDR]"; exit 1
fi

cd `dirname $0`
ip link add veth0 type veth peer name veth1
bash set_interface.sh veth0 $1
bash set_interface.sh veth1 $2
