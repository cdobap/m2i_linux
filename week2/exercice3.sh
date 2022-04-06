#!/bin/bash

echo "entrer un nombre"

read nbre

res=1

for (( i=0 ; i<$nbre ; i++ )); do
    let res=$res*$nbre
done
echo $res

#total=$nbre

# if [ $nbre -gt 0 ]; then
#     i=1
#     while [ $i -lt $nbre ]; do
#         let "total=$total*$nbre"
#         let "i=$i+1"
#     done
#     echo $total
# fi