#!/bin/bash

# affiche le menu
display_menu(){
    echo "--------"
    echo "1 - Verifier l'existance d'un utilisateur"
    echo "2 - Connaitre l'UUID d'un utilisateur"
    echo "3 - Quitter"
    echo "--------"
}
# entrer nom user
get_username(){
    echo "entrer le nom de l'utilisateur"
    read username
    # appel de la fonction pour vérifier si existe ou pas
    check_if_user_exist $username
}
# check si user existe
check_if_user_exist(){
    user_exist=`getent passwd $1`
    if [ -z $user_exist ]; then
        echo "l'utilisateur $1 n'existe pas"
    else
        echo "l'utilisateur $1 existe"
        #echo $user_exist
    fi
    main
}
# get uid user
get_uid_user(){    
    echo "entrer le nom de l'utilisateur"
    read username
    uid_user=`id -u $username`
    if [ -z $uid_user ]; then
        echo "UID introuvable, vérifier si l'user existe"
    else
        echo "l'UID de l'utilisateur $username est $uid_user"
    fi
    main
}

main(){
    display_menu
    # récuperer option a été choisie
    read option_menu
    # conditions en fonction de l'option choisie
    case $option_menu in 
        (1) get_username;;
        (2) get_uid_user;;
        (3) echo "bye";;
        *) echo "bad entry";;
    esac
}

main
