#!/bin/env bash
cd `dirname $0`

cat ../network.txt | while read line; do
    arr=`bash config_filter.sh $line`
    sudo rm -rf ../quagga/config/${arr[0]} \
        && echo "delete config file (${arr[0]})"
done
