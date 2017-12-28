#!/bin/env bash
cd `dirname $0`
cat ../router.txt | bash router_filter.sh | sudo bash ../network/delete.sh
