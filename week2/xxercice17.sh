#!/bin/bash

# this script ask 2 numbers, min & max
# generate a secret random number between those numbers
# ask the user to find the secret number
# 22/04/07

min_num=""
max_num=""
random_number=""
res=""

# ask min number
ask_min_num(){
echo "enter a number"
read n_min
if [[ $n_min =~ ^[0-9]+$ ]]; then
    min_num=$n_min
    return
else
    echo "not a number"
    ask_min_num
fi
}
# ask max_number
ask_max_num(){
echo "enter a number greater than the last one"
read n_max
if [[ $n_max =~ ^[0-9]+$ ]] && [[ $n_max -gt $min_num ]]; then
    max_num=$n_max
    return
else
    echo "wrong entry"
    ask_max_num
fi
}

# get a random number between n_min and n_max=($n_min+$diff)
set_random_num(){
    let diff=$max_num-$min_num
    random_number=$[ $RANDOM % $diff + $min_num ]
}

# loop to find the secret num
loop_secret_num(){
    while [[ $res -ne $random_number ]]; do 
        echo "try to find the secret number:"
        read res
        if [[ $res -lt $random_number ]]; then
            echo "too low"
        elif [[ $res -gt $random_number ]]; then
            echo "too high"
        elif
            [[ $res -eq $random_number ]]; then
            echo "congrats!!"
        else
            echo "not a number"
        fi
    done
}

main(){
    ask_min_num
    ask_max_num
    set_random_num
    loop_secret_num
}

main