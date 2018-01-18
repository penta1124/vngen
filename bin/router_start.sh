#!/bin/env bash
cd `dirname $0`

cat ../router.txt | while read line; do
    r=`bash router_filter.sh $line`
    sudo bash ../quagga/start.sh $r \
        && echo "start router $r"
done
