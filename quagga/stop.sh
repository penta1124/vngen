if [ "`whoami`" != "root" ]; then
    echo "Require root privilege"; exit 1
fi

path=/var/run/quagga
zebra=$path/$1_zebra
ospfd=$path/$1_ospfd

if [ -z "`ls $zebra.pid 2> /dev/null`" ]; then
    echo "router $1 not found"
    exit 1
else
    kill `cat $zebra.pid`
    kill `cat $ospfd.pid`
    rm $zebra.pid
    rm $zebra.vty
    rm $ospfd.pid
    rm $ospfd.vty
fi
