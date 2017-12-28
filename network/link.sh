if [ "`whoami`" != "root" ]; then
    echo "Require root privilege"; exit 1
fi

function set_interface() {
    eth=$1; t=$2; ns=${t%%:*}; t=${t##*:}; dev=${t%%@*}; ip=${t##*@}
    if [ -z "`ip netns | grep -w $ns`" ]; then
        ip netns add $ns
        ip netns exec $ns ip addr add dev lo 127.0.0.1/8
        ip netns exec $ns ip link set dev lo up
    fi
    ip link set $eth netns $ns
    ip netns exec $ns ip link set dev $eth name $dev
    if [ $ip != $dev ]; then
        ip netns exec $ns ip addr add dev $dev $ip
    fi
    ip netns exec $ns ip link set dev $dev up
}

while read line; do
    arr=($line)
    echo $line
    ip link add tmp-eth0 type veth peer name tmp-eth1
    set_interface tmp-eth0 ${arr[0]}
    set_interface tmp-eth1 ${arr[1]}
done
