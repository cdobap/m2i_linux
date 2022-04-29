#!/bin/bash

#number=0
#while [[ $number -eq 0 ]]; do
	
while true; do
	rm -r /var/www/visu/*

	# on définit une variable bdd dans laquelle on appelle le résultat de la commande cat
	bdd=`cat /home/visu/bdd`
		
	for machine in $bdd; do
		group=`echo $machine | cut -d: -f1`
		#if [[ $group =~ "vdm1" ]];then
		mkdir /var/www/visu/$group
			echo "<div>"$machine"</div>" >> /var/www/visu/$group/index.html
		#fi
	done

	# on exporte avec le contenu de la variable dans le fichier index.html
		

	#echo $bdd > /var/www/visu/vdm1/index.html


 	sleep 60
done
