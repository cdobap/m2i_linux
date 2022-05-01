#!/bin/bash

ip_server=

add_machine() {
	if [[ $2 =~ ^[a-zA-Z0-9-]{3,12}$ ]] && [[ $3 =~ ^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$ ]] && [[ $4 =~ ^vdm[0-9]{1,2}$ ]]; then
		ssh visu@$ip_server echo "$4:$2:$3:UP" >> /home/visu/bdd 
	else
		echo "invalid argument: try 'mdm help' for more information "
	fi
}

change_machine() {
case $3 in
	--name)
		ssh visu@$ip_server grep "$5:$2:" /home/visu/bdd 1> /dev/null 
		case $? in
			0) ssh visu@$ip_server sed -i "s/$5:$2:/$5:$4:/" /home/visu/bdd;;

			1) echo "the machine doesn't exist: try 'mdm list' to get the right name";;
		esac;;
	--group)
		ssh visu@$ip_server grep "$5:$2:" /home/visu/bdd 1> /dev/null 
		
		case $? in
			0) ssh visu@$ip_server sed -i "s/$5:$2:/$4:$2:/" /home/visu/bdd;;
			1) echo "the machine doesn't exist: try 'mdm list' to get the right name";;
		esac;;
	*)
		echo "invalid option: use --name | --group | --state to modify the machine";;
esac
}

remove_machine() {
	ssh visu@$ip_server grep "$5:$2:" /home/visu/bdd 1> /dev/null 
	case $? in
		0) ssh visu@$ip_server sed -i "/$5:$2:/d" /home/visu/bdd;;
		1) echo "the machine doesn't exist: try 'mdm list' to get the right name";;
	esac


}




# on fait une boucle case pour gérer tous les cas de figure
case $1 in
	# suppression d'une machine
	remove) remove_machine $@;;
	
	# ajout d'une machine
	add) add_machine $@;;
	#ssh ent@localhost echo "$4:$2:$3:UP" >> /home/visu/bdd ;;
	
	# change le nom de la machine
	change) change_machine $@;;
	
	# liste les machines dans un groupe
	list)echo "ls";;
	
	# manuel d'utilisation de la commande
	help) echo "help";;
	
	# affiche un message d'erreur si mauvais argument
	*)echo "invalid argument: try 'mdm help' for more information ";;
esac
