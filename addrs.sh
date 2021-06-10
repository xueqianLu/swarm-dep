#!/bin/bash
source env.sh

N=${1:-$number}

for i in $(seq 1 $N)
do
	apiport=$(($bapiport + $i*3))
	p2pport=$(($bp2pport + $i*3))
	debugport=$(($bdbgport + $i*3))
	nodedir="${basedir}node$i"
	containname="bee-$groups-node-$i"
	idx=$i
	addr=`curl -s http://localhost:$debugport/addresses | jq .ethereum`
	echo "node-$i $addr"
done

