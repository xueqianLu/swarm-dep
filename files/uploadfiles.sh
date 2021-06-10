#!/bin/bash
FILENUM=100

N=${1:-9}
FILENUM=${2:-100}
FILESIZE=${3:-1000}

for i in $(seq 1 $N)
do
	./ufiles.sh $i $FILENUM $FILESIZE  &
done
