#!/bin/bash

# this is a comment

# this is var
me=baptiste
hello="hello\n$me"

# print in terminal
echo -e $hello

# double quote -> chaine char -> interprete specific char and var
# single quote -> ____________   doesnt 
# back quote -> ouvre un term pour effectuer la cmd et stock stdout
ma_commande=`pwd`
echo "je suis dans le dossier $ma_commande"

# utilisation appel conditionnel :+
echo ${me:+"j'existe"}

# get size char var "#" (len)
echo "there is ${#me} char in my name"

# sous chaine string char ${var:debut:longueur}
alphabet="abcdefghijklmnopqrstuvwxyz"
echo ${alphabet:5:3}

# exclure/garder segments
maSuite="col1|col2|col3|col4|col5|col6"
echo ${maSuite#*|}
echo ${maSuite%%|*}
echo ${maSuite##*|}
echo ${maSuite%|*}

####################
# $((operation))
i=42
echo $((2*($i-2)))
echo $(($i%40))

# expression let == $(())
let 'a=5'
let 'b=3'
let 'c=a+b'
echo $c

# unset var
unset c
echo $c

# env var
echo $USER

# input
echo "nom ?"
read ma_saisie
echo $ma_saisie

echo "nom prenom age?"
read nom prenom age
echo "$nom $prenom $age"

# utilisation des flag
read -p "entrer un nmbre: " la_saisie_du_nombre
echo $la_saisie_du_nombre
read -p "entrer username(5 char max): " -n5 usernama
echo -e "\n$usernama"

# -s secret  -t chiffre en sec => tps de saisie
read -p "passwd: " -s psswd
# verif
# unset
echo -e $psswd

# sous scripts
appel=`bash script.sh`
echo $appel
echo $poulet