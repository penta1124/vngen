if [ "`whoami`" != "root" ]; then
    echo "Require root privilege"; exit 1
fi

if [ -z "`ls /var/run/quagga/$1_zebra.vty 2> /dev/null`" ]; then
    echo "$1 not found"
    exit
fi
rm -f /var/run/quagga/zebra.vty
rm -f /var/run/quagga/ospfd.vty
ln /var/run/quagga/$1_zebra.vty /var/run/quagga/zebra.vty
ln /var/run/quagga/$1_ospfd.vty /var/run/quagga/ospfd.vty
vtysh
rm -f /var/run/quagga/zebra.vty
rm -f /var/run/quagga/ospfd.vty

