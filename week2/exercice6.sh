#!/bin/bash

# definition des variables
nombre1=0
operateur=""
nombre2=0


#if [ $# -ne 0 ]
echo $#
echo $1
echo $2
echo $3

# check si param sont donnés


# si pas de param 


# demande un nombre
get_first_number(){
    echo "entrer un nombre"
    read nombre
    nombre1=$nombre
}
get_second_number(){
    echo "entrer un nombre"
    read nombre
    nombre2=$nombre
}
# demander l'opérateur
get_operateur(){
    echo "entrer l'operateur"
    read oper
    operateur=$oper
}
# calcule l'operation
calcul(){
    case $operateur in
        "+") let res=$nombre1+$nombre2 && echo $res;;
        *) break;;
    esac
}

get_first_number
get_operateur
get_second_number
calcul