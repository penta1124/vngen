#!/bin/env bash
cd `dirname $0`

cat ../network.txt | while read line; do
    cfg=`bash config_filter.sh $line`
    sudo bash ../quagga/create_config.sh $cfg \
        && echo "create config file ($cfg)"
done
