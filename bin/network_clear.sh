#!/bin/env bash
cd `dirname $0`

cat ../network.txt | while read line; do
    arr=(`echo $line`)
    br=br${arr[0]}
    if sudo ip netns exec brns ip link show $br > /dev/null 2> /dev/null; then
        echo "Delete bridge $br"
        sudo ip netns exec brns ip link del $br
    fi

    for nsn in ${line#[0-9]* }; do
        ns=r$nsn
        if ip netns | grep -w $ns > /dev/null; then
            echo "Delete netns $ns"
            sudo ip netns del $ns
        fi
    done
done
