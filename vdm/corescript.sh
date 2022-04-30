#!/bin/bash


# on boucle pour chercher les mises à jour du fichier de la base de données
while true; do
	# on supprime tout l'ancien contenu du site
	rm -r /var/www/visu/*
	
	# on récupère les noms de tous les groupes dans le fichier bdd
	groups=`cat /home/visu/bdd | cut -d: -f1`

	# 

echo '<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">' >> /var/www/visu/index.html
# on crée la page d'accueil du site

	echo "<h1 class='border border-5'>LISTE DES GROUPES</h1>" >> /var/www/visu/index.html
	
	list_groups=`sort /home/visu/bdd | cut -d: -f1 | uniq`

	for grp in $list_groups; do
		echo "<h2 style='width: 200px;' class='shadow-lg p-3 mb-5 bg-body rounded-pill'><a href=/$grp>$grp</a></h2>" >> /var/www/visu/index.html
	mkdir /var/www/visu/$grp
echo '<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">' >> /var/www/visu/$grp/index.html
	done
	
	# on définit une variable bdd dans laquelle on appelle le résultat de la commande cat
	bdd=`cat /home/visu/bdd`
		
	# on parcourt chaque ligne de $bdd et on stock cette ligne dans la variable $machine
	for machine in $bdd; do
		# on stock le nom du groupe dans la variable groupe
		group=`echo $machine | cut -d: -f1`
		name=`echo $machine | cut -d: -f2`
		ip=`echo $machine | cut -d: -f3`
		state=`echo $machine | cut -d: -f4`
		
		# on crée un dossier par groupe et on redirige le stderr dans /dev/null si le dossier existe déjà 
		mkdir /var/www/visu/$group 2> /dev/null
		# on ajoute les informations de la machine dans la page index.html du groupe de la machine
		
		case $state in
			UP)
		echo "<div class='container'>
		<div class='row align-items-start shadow p3 mb-5 bg-body rounded-pill'>
			<div class='col fs-2'>$name</div>
			<div class='col fs-2'>$ip</div>
			<div class='col fs-2 text-success'>$state</div>
		</div>
		</div>" >> /var/www/visu/$group/index.html;;
			*)					
		echo "<div class='container'>
		<div class='row align-items-start shadow p3 mb-5 bg-body rounded-pill'>
			<div class='col fs-2'>$name</div>
			<div class='col fs-2'>$ip</div>
			<div class='col fs-2 text-danger'>$state</div>
		</div>
		</div>" >> /var/www/visu/$group/index.html;;
		
		esac
	done
 	
	# on met le programme en attente pendant 60 secondes
	sleep 60
done
