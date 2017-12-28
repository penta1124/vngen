if [ "`whoami`" != "root" ]; then
    echo "Require root privilege"; exit 1
fi

while read line; do
    arr=($line); ns=${arr[0]};
    echo "ip netns del $ns"
    ip netns del $ns
done
