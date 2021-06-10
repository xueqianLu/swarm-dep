#!/bin/bash
i=$1
source env.sh
containname="bee-$groups-node-$i"

now=`date +"%Y-%m-%dT%H:%M:%S"`
docker logs -f -t --since="$now" $containname
