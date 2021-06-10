#!/bin/bash
source env.sh

N=${1:-$number}

for i in $(seq 1 $N)
do
	apiport=$(($bapiport + $i*3))
	p2pport=$(($bp2pport + $i*3))
	debugport=$(($bdbgport + $i*3))
	peers=`curl -s http://localhost:$debugport/peers | jq '.peers | length'`
	echo "node-$i peers $peers"
done
