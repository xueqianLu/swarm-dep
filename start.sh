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
	
	echo $idx
	docker run \
		-d \
		--name=$containname \
		--net=host \
		-v $nodedir:/home/bee/.bee \
		--restart=always \
		-it ethersphere/bee:latest \
		start \
		--p2p-addr 0.0.0.0:$p2pport \
		--api-addr 0.0.0.0:$apiport \
		--debug-api-addr 0.0.0.0:$debugport \
		--nat-addr 110.188.25.40:$p2pport \
		--welcome-message="kt swarm pool $groups node $idx" \
		--verbosity 5 \
		--config /home/bee/.bee/bee.yaml
done

