#!/bin/bash

# author: baptiste c.
# date: 22/04/07
# 
# ce script exploite les données du fichier 'FichierNote.txt' situé dans le même répertoire
# ce script affiche les lignes dans lesquelles la note est supérieure ou égale à 10
# et les enregistre dans le fichier 'AuMoinsDix.txt'
# Pour exécuter ce script: ". exercice11.sh" dans le terminal
# au préalable s'assurer que FichierNote.txt existe et est placé dans le même répertoire que ce script
# et s'assurer qu'il y a une ligne vide à la fin du fichier
# si ce n'est pas le cas: décommenter la ligne suivante:
# echo " " >> FichierNote.txt

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
        # appel de la fonction get_appreciation avec la note en param $3
        get_appreciation $3
        echo $1 $2 $3 $appreciation>> AuMoinsDix.txt     
}
# cette fonction vérifie que le param est bien une note entre 0 et 20 et stock la sortie de l'exercice 4 dans une variable
get_appreciation(){
    # regex pour vérifier que le param $1 est une note 
    if [[ $1 =~ ^[0-9]$|^1[0-9]$|^20$ ]]; then
        # appel du script exercice04 et std out dans $appreciation
        appreciation=`. exercice11_04.sh $1`
    fi
}
# la fonction main 
main(){
    read_file
}

main