if [ "`whoami`" != "root" ]; then
    echo "Require root privilege"; exit 1
fi

cd `dirname $0`/config

host=$1; id=$2
mkdir -p $host
cat base/zebra.conf\
    | sed "s/HOSTNAME/$host/g"\
    > $host/zebra.conf
cat base/ospfd.conf\
    | sed "s/HOSTNAME/$host/g"\
    | sed "s/ROUTER-ID/$id/g"\
    > $host/ospfd.conf
chown -R quagga:quagga $host
