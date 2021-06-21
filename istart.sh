#!/bin/bash

source env.sh
N=${1:-$number}

for i in $(seq 1 $N)
do
	apiport=$(($bapiport + $i - 1))
	p2pport=$(($bp2pport + $i - 1))
	debugport=$(($bdbgport + $i - 1))
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
		-it ethersphere/bee:$bversion \
		start \
		--p2p-addr 0.0.0.0:$p2pport \
		--api-addr 0.0.0.0:$apiport \
		--debug-api-addr 0.0.0.0:$debugport \
		--nat-addr $pubip:$p2pport \
		--welcome-message="swarm pool $groups node $idx" \
		--verbosity 5 \
		--swap-endpoint $swap_endpoint \
		--config /home/bee/.bee/bee.yaml
done

