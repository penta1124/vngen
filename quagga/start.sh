if [ "`whoami`" != "root" ]; then
    echo "Require root privilege"; exit 1
fi

dir=$(dirname $(pwd)/$0)/config
path=/var/run/quagga

ip netns exec $1 zebra -d -f $dir/$1/zebra.conf -i /var/run/quagga/$1_zebra.pid -A 127.0.0.1
ip netns exec $1 ospfd -d -f $dir/$1/ospfd.conf -i /var/run/quagga/$1_ospfd.pid -A 127.0.0.1
mv $path/zebra.vty $path/$1_zebra.vty
mv $path/ospfd.vty $path/$1_ospfd.vty
