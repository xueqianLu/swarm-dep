#!/bin/bash
source env.sh

N=${1:-$number}

for i in $(seq 1 $N)
do
	containname="bee-$groups-node-$i"
	echo $containname
	docker logs $containname > logs/$containname.log
done
