if [ "`whoami`" != "root" ]; then
    echo "Require root privilege"; exit 1
fi

if [ $# -lt 2 ]; then
   echo "usage: $0 BRNAME NETNS:DEV[@ADDR] ..."; exit 1
fi

if [ -z "`ip netns | grep -w brns`" ]; then
    ip netns add brns
    ip netns exec brns ip link set lo up
fi

cd `dirname $0`
for arg in $@; do
    if [ -z "$br" ]; then
        br=$arg
        ip netns exec brns ip link add $br type bridge
        ip netns exec brns ip link set $br up
    else
        ns=${arg%%:*}
        veth=veth-$br-$ns
        ip link add veth0 type veth peer name $veth
        ip link set $veth netns brns
        ip netns exec brns ip link set $veth master $br
        ip netns exec brns ip link set $veth up
        bash set_interface.sh veth0 $arg
    fi
done
