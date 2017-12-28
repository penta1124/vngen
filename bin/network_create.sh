#!/bin/env bash
cd `dirname $0`
cat ../network.txt | bash network_filter.sh | sudo bash ../network/link.sh
