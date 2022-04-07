#!/bin/bash

# this is a script to calculate the result of an operation of two numbers
# write in franglish
# author: 
# date: 22-04-06

# definition des variables
nombre1=0
operateur=""
nombre2=0

# check number of params and call appropriate function
check_params(){
    if [ $# -ne 0 ]; then
        # there is one param "7+1"
        if [ $# -eq 1 ]; then
            # function that parse $1 to get numbers & operator
            echo "en cours de developpement"
        elif [ $# -eq 3 ]; then
            # if there is 3 params, set var and calcul
            # set_variables $1 $2 $3
            set_nombre1 $1
            set_operateur $2
            set_nombre2 $3
            calcul
        else
            echo "wrong params"
        fi
    fi
}   

# define variable with params and check if its number
# to do one setter for each var
set_nombre1(){
    if [[ ! $1 =~ ^[0-9]+$ ]];then
        echo "this is not a number"
        get_first_number
    else
        nombre1=$1
    fi
}
set_nombre2(){
    if [[ ! $1 =~ ^[0-9]+$ ]];then
        echo "this is not a number"
        get_second_number
    else
        nombre2=$1   
    fi 
}
set_operateur(){
    if [[ ! $1 =~ [+-/x] ]]; then
        get_operateur
    else
        operateur=$1
    fi
}
# demande un nombre
get_first_number(){
    echo "entrer un nombre"
    read nombre
    set_nombre1 $nombre    
}
get_second_number(){
    echo "entrer un nombre"
    read nombre
    set_nombre2 $nombre   
}
# demander l'opérateur
get_operateur(){
    echo "entrer un operateur (+-/x)"
    read oper
    set_operateur $oper
}
# calcule l'operation
calcul(){
    case $operateur in
        "+") let res=$nombre1+$nombre2 && echo "resultat = $res";;
        "-") let res=$nombre1-$nombre2 && echo "resultat = $res";;
        "/") let res=$nombre1/$nombre2 && echo "resultat = $res";;
        "x") let res=$nombre1*$nombre2 && echo "resultat = $res";;
        *) break;;
    esac
}

main(){
    if [ $# -ne 0 ]; then
        check_params $@
    else    
        get_first_number
        get_operateur
        get_second_number
        calcul
    fi
}

main $@