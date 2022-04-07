#!/bin/bash

# echo à chaque espace
for cat_file in $(cat animaux.txt); do
    echo $cat_file
done

echo "----------------------------"
# while
while read line
do
    echo $line
done < animaux.txt

# IFS=(internal field separator) => preciser le separateur
while IFS=: read user mdp uid gid fullname home loc_shell
do 
    echo $user $uid
done < /etc/passwd