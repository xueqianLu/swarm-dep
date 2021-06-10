#!/bin/bash
source env.sh
nodeidx=${1:-0}
FILENUM=${2:-100}
FILESIZE=${3:-1000}

apiport=$(($bapiport + $nodeidx*3))
#batchids=("608839781802bb020ca9b7fe0737895ae2ea99485b9d2c684b3c646177cc8d65" "0b20f46137e9dc3d3eb30ae8926f07e4b09fe31874703174844619e4b178e11e" "39e010e7338d80b58aceaf426985c8e127c6aceaf4e402e84b30c97285d19835" "e987860a7228df2d63857153c514d12806f7d310b3d4a6af7ca4d5660a554f3f" "c6b5729c11898541c1b2ad87df71ac4f82b8034dd92f07daae7eac232dfa68b1" "bd0c3786738df21bd1d60e086f894d5d602fdf15c9f53d0487605b9341c4646d" "ea013f4a71e0e78b3422343c0c8beea8a3065e23a34d4ca73b4eea0e61d9f1ba" "6ed54b7ddee395559549ed3c641d1782fcea6c3d7a2bfba295c6bdb4f1643cbb" "d685a6b03afb05ef9a47def514660114e39e628114d44ee545f9495a50c35784")

batchid=${batchids[$(($nodeidx - 1))]}
echo "use batchid $batchid "

prefix="no${nodeidx}_"

genfiles -n $FILENUM -s $FILESIZE -p $prefix
for f in $(seq 0 $FILENUM)
do
	File="${prefix}random_$f.txt"
	curl -s -F file=@$File -H "Swarm-Postage-Batch-Id: $batchid" -H "Content-Type: text/plain" -v http://localhost:$apiport/bzz >> upload_node_$nodeidx.log 2>&1
done

grep "< Swarm-Tag" ./upload_node_$nodeidx.log > tags_node_$nodeidx.log

curl -s http://localhost:$apiport/stamps
rm ${prefix}*.txt
