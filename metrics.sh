#!/bin/bash
source env.sh

N=${1:-$number}
pernode_uncashed_cnt=0
pernode_uncashed_amount=0
total_uncashed_cnt=0
total_uncashed_amount=0

function getPeers() {   
    api=$1
    curl -s "$api/chequebook/cheque" | jq -r '.lastcheques | .[].peer'  
}

function getUncashedAmount() {  
    api=$1
    curl -s "$api/chequebook/cashout/$2" | jq '.uncashedAmount'  
}

function calcAllUncashed() {
    pernode_uncashed_cnt=0
    pernode_uncashed_amount=0
    local api=$1
    for peer in $(getPeers $1)
    do
        local uncashedAmount=$(getUncashedAmount $api $peer)
        if (( "$uncashedAmount" > 0 ))
        then
            pernode_uncashed_cnt=$(($pernode_uncashed_cnt + 1))
            pernode_uncashed_amount=$(($pernode_uncashed_amount + $uncashedAmount))
            total_uncashed_cnt=$(($total_uncashed_cnt + 1))
            total_uncashed_amount=$(($total_uncashed_amount + $uncashedAmount))
        fi
    done
}

for i in $(seq 1 $N)
do
    apiport=$(($bapiport + $i - 1))
    p2pport=$(($bp2pport + $i - 1))
    debugport=$(($bdbgport + $i - 1))
    nodedir="${basedir}node$i"
    api="http://127.0.0.1:$debugport"
    peers=`curl -s http://127.0.0.1:$debugport/peers | jq '.peers | length' `
    calcAllUncashed $api
    echo "node-$i 连接数:$peers     有效支票数:${pernode_uncashed_cnt}      价值:${pernode_uncashed_amount}"
done
echo "总票数:$total_uncashed_cnt    总价值:$total_uncashed_amount"
