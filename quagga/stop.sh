if [ "`whoami`" != "root" ]; then
    echo "Require root privilege"; exit 1
fi

path=/var/run/quagga
while read line; do
    arr=($line); host=${arr[0]};
    zebra=$path/${host}_zebra
    ospfd=$path/${host}_ospfd
    if [ -z "`ls $zebra.pid 2> /dev/null`" ]; then
        echo "$host not found"
    else
        kill `cat $zebra.pid`
        kill `cat $ospfd.pid`
        rm $zebra.pid
        rm $zebra.vty
        rm $ospfd.pid
        rm $ospfd.vty
    fi
done
