#!/bin/env bash
cd `dirname $0`

cat ../router.txt | while read line; do
    r=`bash router_filter.sh $line`
    sudo bash ../quagga/stop.sh $r \
        && echo "stop router $r"
done
