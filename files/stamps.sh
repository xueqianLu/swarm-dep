#!/bin/bash
source env.sh
N=${1:-$number}


for i in $(seq 1 $N)
do
	apiport=$(($bapiport + $i*3))
	p2pport=$(($bp2pport + $i*3))
	debugport=$(($bdbgport + $i*3))
	stamps=`curl -s http://${public_ip}:${apiport}/stamps`
	echo "node $i $stamps"
done
