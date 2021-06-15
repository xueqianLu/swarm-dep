#!/bin/bash
source env.sh
FILENUM=100

N=${1:-$number}
FILENUM=${2:-100}
FILESIZE=${3:-1000}

for i in $(seq 1 $N)
do
	echo "upload node $i"
	./ufiles.sh $i $FILENUM $FILESIZE &
done
