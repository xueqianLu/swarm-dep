#!/bin/bash
for i in $(seq 1 10000)
do
	echo "mon bee $i" >> mon.txt
	./chk.sh 
	sleep 300
done
