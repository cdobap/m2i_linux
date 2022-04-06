#!/bin/bash

# fonction gestion des cas
gestion_cas(){
    echo "la note est: $note"
    if [ "$note" -gt 20 ] || [ "$note" -lt 0 ]; then
        echo "erreur dans la saisie"
    elif [ "$note" -ge 16 ]; then
        echo "tres bien"
    elif [ "$note" -ge 14 ]; then
        echo "bien"
    elif [ "$note" -ge 12 ]; then
        echo "assez bien"
    elif [ "$note" -ge 10 ]; then
        echo "moyen"
    elif [ "$note" -ge 0 ] && [ "$note" -lt 10 ]; then
        echo "insuffisant"
    else
        echo "erreur de saisie"
    fi
}

# si existe: la note donnée en parametre est stockée dans $note
note=$1
# check si $1 est existe et est bien une note >= 0
if [ "$note" -ge 0 ]; then    
    gestion_cas $note
else
    # demande une var à l'utilisateur
    echo "entrer une note"
    read -r note
    gestion_cas $note
fi

