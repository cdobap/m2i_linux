#!/bin/bash


# on boucle pour chercher les mises à jour du fichier de la base de données
while true; do
	# on supprime tout l'ancien contenu du site
	rm -r /var/www/visu/*
	
	# on récupère les noms de tous les groupes dans le fichier bdd
	groups=`cat /home/visu/bdd | cut -d: -f1`

	# 

	# on crée la page d'accueil du site 
	echo "<h1>LISTE DES GROUPES</h1>" >> /var/www/visu/index.html
	
	list_groups=`sort /home/visu/bdd | cut -d: -f1 | uniq`

	for grp in $list_groups; do
		echo "<h2><a href=/$grp>$grp</a></h2>" >> /var/www/visu/index.html
	done
	
	# on définit une variable bdd dans laquelle on appelle le résultat de la commande cat
	bdd=`cat /home/visu/bdd`
		
	# on parcourt chaque ligne de $bdd et on stock cette ligne dans la variable $machine
	for machine in $bdd; do
		# on stock le nom du groupe dans la variable groupe
		group=`echo $machine | cut -d: -f1`
		# on crée un dossier par groupe et on redirige le stderr dans /dev/null si le dossier existe déjà 
		mkdir /var/www/visu/$group 2> /dev/null
		# on ajoute les informations de la machine dans la page index.html du groupe de la machine
		echo "<div>"$machine"</div>" >> /var/www/visu/$group/index.html
		
	done
 	
	# on met le programme en attente pendant 60 secondes
	sleep 60
done
