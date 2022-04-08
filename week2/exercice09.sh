#!/bin/bash

# this script create an array that contains number given in params or in input
# it sorts those numbers and print them on the terminal

array_number=()

append_arg(){
    for arg in $@; do
        array_number+=($arg)
    done
}

bubble_sort(){
    #echo "$@ je suis dans la bulle"
    #echo "${#@} je suis dans la bulle"
    for ((i=0; i<${#@}; i++)); do                 
        for ((j=0; j<${#@}; j++)); do       
        #echo ${array_number[j]}
            if  [[ $((j+1)) -lt ${#@} ]] && [ ${array_number[j]} -gt ${array_number[$((j+1))]} ]; then
                #swap
                temp=${array_number[j]}
                array_number[j]=${array_number[$((j+1))]}
                array_number[$((j+1))]=$temp
            fi
        done
    done
}



if [[ $# -ne 0 ]]; then
    append_arg $@
    echo ${array_number[@]}
    bubble_sort ${array_number[@]}
    echo ${array_number[@]}
else
    echo "no arg"
fi
