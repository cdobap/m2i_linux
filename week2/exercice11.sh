#!/bin/bash

# author: baptiste c.
# date: 22/04/07
# 
# ce script exploite les données du fichier 'FichierNote.txt' situé dans le même répertoire
# ce script affiche les lignes dans lesquelles la note est supérieure ou égale à 10
# et les enregistre dans le fichier 'AuMoinsDix.txt'
# Pour exécuter ce script: ". exercice11.sh" dans le terminal


# cette fonction va lire le fichier ligne par ligne
read_file(){
    # la boucle while va parcourir tout le FichierNote.txt donné en std input, ligne par ligne et en fonction de l'IFS
    # IFS=(internal field separator) => précise le séparateur
    # chaque ligne du fichier a un nom, un prénom et une note, ces données sont stockés dans des variables $nom $prenom $note
    while IFS=" " read nom prenom note
    do 
        # appel la fonction check_line qui va traiter les données du script
        check_line $nom $prenom $note
    done < FichierNote.txt
}
# cette fonction vérifie si la note de la ligne est supérieure ou égale à 10  
check_line(){
        # sélection des lignes où la note est supérieure ou égale à 10
        if [[ $3 -ge 10 ]]; then
        # appel de la fonction print_selected_line pour afficher la ligne dans le terminal
        print_selected_line $1 $2 $3 
        # appel de la fonction export_selected_line pour inscrire la ligne dans un autre fichier
        export_selected_line $1 $2 $3 
        fi
}
# cette fonction affiche dans le terminal les données des lignes qui ont une note supérieure ou égale à 10 
print_selected_line(){
        echo $1 $2 $3         
}
# cette fonction inscrit dans le fichier AuMoinsDix.txt les données des lignes qui ont une note supérieure ou égale à 10 
export_selected_line(){
        echo $1 $2 $3 >> AuMoinsDix.txt     
}
# la fonction main 
main(){
    read_file
}

main