#!/bin/env bash
cd `dirname $0`

create_link() {
    if [ $# = 3 ]; then
        echo "sudo bash ../network/link.sh $2 $3"
        sudo bash ../network/link.sh $2 $3
    else
        echo "sudo bash ../network/bridge.sh $@"
        sudo bash ../network/bridge.sh $@
    fi
}

cat ../network.txt | while read line; do
    arr=(`echo $line`)
    create_link br${arr[0]} `bash network_filter.sh $line`
done
