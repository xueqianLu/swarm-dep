#!/bin/bash
source env.sh
idx=${1:-1}
containname="bee-$groups-node-$idx"
sudo tail -f `docker inspect --format='{{.LogPath}}' $containname`
