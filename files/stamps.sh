#!/bin/bash
source env.sh
N=${1:-$number}


for i in $(seq 1 $N)
do
	apiport=$(($bapiport + $i - 1))
	p2pport=$(($bp2pport + $i - 1))
	debugport=$(($bdbgport + $i - 1))
	stamps=`curl -s http://${pubip}:${apiport}/stamps`
	echo "node $i $stamps"
done
