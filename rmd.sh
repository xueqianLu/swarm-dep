#!/bin/bash

source env.sh
Off=${1:-0}
N=${2:-1}

for i in $(seq 0 $N)
do
	idx=$(($Off + $i))
	containname="bee-$groups-node-$idx"
	echo "docker stop $containname"
	docker stop $containname
	docker rm $containname 
done

