#!/bin/bash

# define variable
res=1
number=0

# calcule la factorielle d'un nombre 
factorielle(){
    for ((i=1; i<=$1; i++))
        do let res=$res*$i
    done
}
ask_number(){

}
set_number(){

}

main(){
    if [ $# -ne 0]; then
        factorielle $1
        echo $res
    else

}