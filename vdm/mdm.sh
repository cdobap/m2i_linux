#!/bin/bash



check_args() {
	if [[ $2 =~ ^[a-zA-Z0-9-]{3,12}$ ]] && [[ $3 =~ ^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$ ]] && [[ $4 =~ ^vdm[0-9]{1,2}$ ]]; then
		ssh ent@localhost echo "$4:$2:$3:UP" >> /home/visu/bdd 
	else
		echo "invalid argument: try 'mdm help' for more information "
	fi
}





# on fait une boucle case pour gérer tous les cas de figure
case $1 in
	# suppression d'une machine
	remove)echo "remov";;
	
	# ajout d'une machine
	add) check_args $@;;
	#ssh ent@localhost echo "$4:$2:$3:UP" >> /home/visu/bdd ;;
	
	# change le nom de la machine
	change)echo "chg";;
	
	# liste les machines dans un groupe
	list)echo "ls";;
	
	# manuel d'utilisation de la commande
	help) echo "help";;
	
	# affiche un message d'erreur si mauvais argument
	*)echo "invalid argument: try 'mdm help' for more information ";;
esac
