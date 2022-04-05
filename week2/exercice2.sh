#!/bin/bash

echo "Veuillez saisir une note"

notes=0
count=0
read note
#floor_note=${note%.*}
case $note in
    (1[6-9]|20) echo "très bien" && notes=$(($note+1)) && count=$(($count+1));;
    (1[4-5]) echo "bien" && notes=$(($note+1)) && count=$(($count+1));;
    (1[2-3]) echo "assez bien" && notes=$(($note+1)) && count=$(($count+1));;
    (1[0-1]) echo "moyen" && notes=$(($note+1)) && count=$(($count+1));;
    ([0-9]) echo "insuffisant" && notes=$(($note+1)) && count=$(($count+1));;
    *) echo "ceci n'est pas une note" && echo "moyenne: $note";;
esac


while [ $note -gt 0 ] ; do
    read note
    #floor_note=${note%.*}
    notes+=note
    case $note in
        (1[6-9]|20) echo "très bien" && notes=$(($note+1)) && count=$(($count+1));;
        (1[4-5]) echo "bien" && notes=$(($note+1)) && count=$(($count+1));;
        (1[2-3]) echo "assez bien" && notes=$(($note+1)) && count=$(($count+1));;
        (1[0-1]) echo "moyen" && notes=$(($note+1)) && count=$(($count+1));;
        ([0-9]) echo "insuffisant" && notes=$(($note+1)) && count=$(($count+1));;
        *) let 'avg=$notes/$count'
            echo "ceci n'est pas une note" && echo "moyenne: $avg";;
    esac
done
