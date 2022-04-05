#!/bin/bash

# author : baptiste cardoso
# create : 22/04/05
# description : this is a short script to test bash command
# execute : type ". 01.sh" in your terminal

# PID
echo $$
echo $0
echo $PPID
echo $LINENO

# chemin du script
# verifier type script 
# utliliser 
# verifier l'execution

# test monfichier && execution
# test monfichier || gestion de l'erreur
myfile=01/011.sh
[ -f $myfile ] && echo "it s a file"

[ -s $myfile ] && echo "not empty" 
[ -s $myfile ] || echo "empty"

