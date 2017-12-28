if [ "`whoami`" != "root" ]; then
    echo "Require root privilege"; exit 1
fi

dir=$(dirname $(pwd)/$0)/config
while read line; do
    arr=($line); host=${arr[0]}; id=${arr[1]};
    mkdir -p $dir/$host
    cat $dir/base/zebra.conf\
        | sed "s/HOSTNAME/$host/g"\
        > $dir/$host/zebra.conf
    cat $dir/base/ospfd.conf\
        | sed "s/HOSTNAME/$host/g"\
        | sed "s/ROUTER-ID/$id/g"\
        > $dir/$host/ospfd.conf
    chown -R quagga:quagga $dir/$host
done
