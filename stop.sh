#!/bin/bash

source env.sh
Off=${1:-0}
N=${2:-1}

for i in $(seq 1 $N)
do
	idx=$(($Off + $i - 1))
	containname="bee-$groups-node-$idx"
	echo "docker stop $containname"
	docker stop $containname 
done

