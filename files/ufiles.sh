#!/bin/bash
source env.sh
nodeidx=${1:-0}
FILENUM=${2:-100}
FILESIZE=${3:-1000}

apiport=$(($bapiport + $nodeidx - 1))

batchid=`curl http://${pubip}:$apiport/stamps | jq -r .stamps[0].batchID`
if [ "$batchid" == "" ];then
	echo "node_$nodeidx have no batchid, exited"
	exit
fi

echo "use batchid $batchid "

prefix="no${nodeidx}"

genfiles -n $FILENUM -s $FILESIZE -p $prefix
for f in $(seq 0 $FILENUM)
do
	File="${prefix}_random_$f.txt"
	curl -s -F file=@$File -H "Swarm-Postage-Batch-Id: $batchid" -H "Content-Type: text/plain" -v http://${pubip}:$apiport/bzz >> upload_node_$nodeidx.log 2>&1
done

grep "< Swarm-Tag" ./upload_node_$nodeidx.log > tags_node_$nodeidx.log

curl -s http://${pubip}:$apiport/stamps
rm ${prefix}*.txt
