#!/bin/bash

bit_max=8
res=()
nb=$1
temp=""

for ((i=$((bit_max-1)); $i>=0; i-- )); do
    let reste=$nb-$((2**$i)) 
    if [[ $reste -ge 0 ]];then 
        nb=$reste
        res+=("1")
    else
        res+=("0")
    fi
done

echo ${res[@]}