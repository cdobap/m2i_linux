#!/bin/bash

# fonction de verification
function verifnombre(){
    # echo "verif du nombre $1"
    reg='^[0-9]+$'# condition si c'est un decimal 
    while [[ ! $note =~ $reg ]] ; do # [ ! $note -ne 0 -o ! $note -ne 1 -o  ... ]
        read -p "entrer un nombre entier :" note # echo " il fallait choisir dommage !" ; note=10
    done
}

# fonction appreciation
function appreciation() {
    echo "voici le param 1 de appreciation : $1" # => rien à afficher
    # gestion des differentes conditions
    if [ $note -gt 20 ] || [ $note -lt 0 ] ; then
        echo "erreur dans la saisi"
    elif [ $note -ge 16 ] ; then
        echo "tres bien"
    elif [ $note -ge 14 ] ; then
        echo "bien"
    elif [ $note -ge 12 ] ; then
        echo "assez bien"
    elif [ $note -ge 10 ] ; then
        echo "moyen"
    elif [ $note -ge 0 ] ; then
        echo "insuffisant"
    else
        echo "au revoir"
    fi
}

function demande_saisie(){
    # demander une variable à l'utilisateur (met le script en pause)
    echo "entrer votre note"
    read -r note
}

# programme principale
function main(){
    echo "voici mes params : $@" # => rien à afficher si pas de param
    # test si j'ai une note ou pas
    if [ $# -ne 0 ] ; then # ![ $# -e 0 ]
        echo $1 # => $1_demain
        note=$1
        verifnombre $1
    else
        demande_saisie
        verifnombre $note
    fi
    appreciation # pas de param
}

# appel de la fonction principale
main $1 # => $@_du_script
echo $1 # => $1_du_script


## Différence entre [ ] et [[ ]]

# * `[` est une commande et est soumise aux mêmes règles que toutes les autres commandes
# que le shell exécute.
# * `[[` est un mot-clé, pas une commande,
# cependant, le shell le traite spécialement 
# et il fonctionne selon des règles très différentes : interpretation par bash.

# utilisation de [[ ]] permet d'utiliser =~ pour les expressions regulieres (ou regex)
# permet egalement de lire les fichiers [[ -f $file ]]
