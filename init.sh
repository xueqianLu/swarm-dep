#!/bin/bash

source env.sh

N=${1:-$number}

for i in $(seq 1 $N)
do
	nodedir="${basedir}node$i"
	cp nodetemp -r $nodedir
	chown bee:bee $nodedir -R
	chmod 777 $nodedir
done
