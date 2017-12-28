if [ "`whoami`" != "root" ]; then
    echo "Require root privilege"; exit 1
fi

dir=$(dirname $(pwd)/$0)/config
path=/var/run/quagga
while read line; do
    arr=($line); host=${arr[0]};
    ip netns exec $host zebra -d -f $dir/$host/zebra.conf -i /var/run/quagga/${host}_zebra.pid -A 127.0.0.1
    ip netns exec $host ospfd -d -f $dir/$host/ospfd.conf -i /var/run/quagga/${host}_ospfd.pid -A 127.0.0.1
    mv $path/zebra.vty $path/${host}_zebra.vty
    mv $path/ospfd.vty $path/${host}_ospfd.vty
done
