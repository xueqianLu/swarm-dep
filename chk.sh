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
	peers=`curl -s http://127.0.0.1:$debugport/peers | jq '.peers | length' `
	if [ "$peers" == "" ]; then  
		echo "restart $containname"
		docker restart $containname
	fi

done
