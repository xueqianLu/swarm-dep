#!/bin/bash
source env.sh

N=${1:-$number}

for i in $(seq 1 $N)
do
	apiport=$(($bapiport + $i*3))
	p2pport=$(($bp2pport + $i*3))
	debugport=$(($bdbgport + $i*3))
	curl -v -H "Gas-Price:900000000000" -XPOST  http://localhost:$apiport/stamps/10000000/20 > stamp_node_${i}.log
done
