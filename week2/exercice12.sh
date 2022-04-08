#!/bin/bash

read_file(){
    while IFS=" " read login nom prenom; do
        if_user $login
    done < $1
}
if_user(){
    is_user=`getent passwd $1`
    if [[ ${#is_user} -ne 0 ]]; then
        echo $login $nom $prenom        
    fi
}

main(){
    if [[ ${#@} -eq 0 ]]; then
        echo "saisissez le fichier à traiter"
        read file_to_read
        if [[ ! -f $file_to_read ]]; then
            echo "le fichier n'existe pas"
        else
            read_file $file_to_read
        fi
    else
        read_file $1
    fi
}

main $@