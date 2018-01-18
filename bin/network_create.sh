#!/bin/env bash
cd `dirname $0`

create() {
    if [ $# = 3 ]; then
        sudo bash ../network/create_link.sh $2 $3 \
            && echo "create link ($2 $3)"
    else
        sudo bash ../network/create_subnet.sh $@ \
            && echo "create subnet ($@)"
    fi
}

cat ../network.txt | while read line; do
    arr=(`echo $line`)
    create br${arr[0]} `bash network_filter.sh $line`
done
