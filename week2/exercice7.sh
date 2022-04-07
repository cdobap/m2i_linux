#!/bin/bash

# this script calculate the "factorielle" of a number that you give in param or asking for one
# date 22-04-07
# author: 
# write in franglish

# define variable
res=1
number=0

# calcule la factorielle d'un nombre 
factorielle(){
    for ((i=1; i<=$1; i++))
        do let res=$res*$i
    done
}
# ask a number
ask_number(){
    echo "enter a number"
    read numb
    set_number $numb

}
# check if it s a number and if it is call the factorielle function
set_number(){
        if [[ $1 =~ ^[0-9]+$ ]]; then
            factorielle $1
            echo $res
        else
            echo 'not a number'
            ask_number
        fi
}

main(){
    # check if there is param and call the function that check if its a number
    if [ $# -ne 0 ]; then
        set_number $1
    else
    # if no args ask a number
        ask_number
    fi
}

main $@