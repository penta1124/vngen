if [ "`whoami`" != "root" ]; then
    echo "Require root privilege"; exit 1
fi

eth=$1; t=$2; ns=${t%%:*}; t=${t##*:}; dev=${t%%@*}; ip=${t##*@}
if [ -z "`ip netns | grep -w $ns`" ]; then
    ip netns add $ns
    ip netns exec $ns ip link set lo up
fi
ip link set $eth netns $ns
ip netns exec $ns ip link set $eth name $dev
if [ $ip != $dev ]; then
    ip netns exec $ns ip addr add $ip dev $dev
fi
ip netns exec $ns ip link set $dev up
