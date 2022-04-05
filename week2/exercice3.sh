#!/bin/bash

echo "entrer un nombre"

read nbre
echo $nbre
# for ((i=0 ; $nbre ; i++))
#     do echo $i
# done
total=$nbre

if [ $nbre -gt 0 ]; then
    i=1
    while [ $i -lt $nbre ]; do
        let "total=$total*$nbre"
        let "i=$i+1"
    done
    echo $total
else
    i=-1
    while [ $i -gt $nbre ]; do
        let "total=$total*$nbre"
        let "i=$i-1"
    done
    echo $total
fi