#!/bin/bash

echo "Veuillez saisir une note"

read note

floor_note=${note%.*}

case $floor_note in
    (1[6-9]|20) echo "très bien";;
    (1[4-5]) echo "bien";;
    (1[2-3]) echo "assez bien";;
    (1[0-1]) echo "moyen";;
    ([0-9]) echo "insuffisant";;
    *) echo "ceci n'est pas une note";;
esac