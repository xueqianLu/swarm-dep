#!/bin/bash

source env.sh

N=${1:-$number}

if [ ! -d $basedir ]; then
	  mkdir -p $basedir 
fi

for i in $(seq 1 $N)
do
	nodedir="${basedir}node$i"
	cp tempnode -r $nodedir
	#chown bee:bee $nodedir -R
	chmod 777 $nodedir
done
