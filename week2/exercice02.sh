#!/bin/bash

note=0
notes=0
count=0

while [ $note -gt -1 ] ; do
    echo "Saisir une note [0-20]:"
    read note
    #floor_note=${note%.*}
    case $note in
        (1[6-9]|20) echo "---très bien" && notes=$(($note+$notes)) && count=$(($count+1));;
        (1[4-5]) echo "---bien" && notes=$(($note+$notes)) && count=$(($count+1));;
        (1[2-3]) echo "---assez bien" && notes=$(($note+$notes)) && count=$(($count+1));;
        (1[0-1]) echo "---moyen" && notes=$(($note+$notes)) && count=$(($count+1));;
        ([0-9]) echo "---insuffisant" && notes=$(($note+$notes)) && count=$(($count+1));;
        *) if [ $count -eq 0 ]
            then
                echo "au revoir"; break
           fi 
            avg=$(($notes/$count))
            echo "moyenne: $avg" && echo "au revoir"; break;;
    esac
done
