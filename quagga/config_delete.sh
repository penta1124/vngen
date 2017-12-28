if [ "`whoami`" != "root" ]; then
    echo "Require root privilege"; exit 1
fi

dir=$(dirname $(pwd)/$0)/config
while read line; do
    arr=($line); host=${arr[0]};
    echo "rm -rf $dir/$host"
    rm -rf $dir/$host
done
