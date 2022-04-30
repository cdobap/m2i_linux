#!/bin/bash


# on boucle pour chercher les mises à jour du fichier de la base de données
while true; do
	# on supprime tout l'ancien contenu du site
	rm -r /var/www/visu/*

	# on link bootstrap dans la page html pour faire du css plus rapidement
	echo '<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">' >> /var/www/visu/index.html

	# on crée la page d'accueil du site
	echo "<h1 class='border border-5 text-center'>LISTE DES GROUPES</h1>" >> /var/www/visu/index.html
	
	# on stock dans la var list_group le nom de chaque groupe une seule fois	
	list_groups=`sort /home/visu/bdd | cut -d: -f1 | uniq`
	
	# on insère des balise div pour formater la page html
	echo "<div class='container mt-5'><div class='row'>" >> /var/www/visu/index.html
	# on boucle dans list_groups pour chaque groupe
	for grp in $list_groups; do
		# on crée le lien vers la page du groupe dans la page d'accueil
		echo "<h2 style='width: 400px;' class='mx-auto shadow-lg p-3 mb-5 bg-body rounded-pill text-center '><a href=/$grp>$grp</a></h2>" >> /var/www/visu/index.html
		# on crée un dossier pour chaque groupe
		mkdir /var/www/visu/$grp
		# on link bootstrap dans la page html de chaque groupe pour faire du css plus rapidement
		echo '<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">' >> /var/www/visu/$grp/index.html
		# on ajoute le nom du groupe dans sa page html
		echo "<h1 class='border border-5 text-center mb-5'>$grp</h1>" >> /var/www/visu/$grp/index.html
	done
	# on ferme les balises ouvertes avant la boucle
	echo "</div></div'>" >> /var/www/visu/index.html

	
	# on définit une variable bdd dans laquelle on appelle le résultat de la commande cat
	bdd=`cat /home/visu/bdd`
		
	# on parcourt chaque ligne de $bdd et on stock les données das machines dans des variables
	for machine in $bdd; do
		# on stock le nom du groupe dans la variable groupe
		group=`echo $machine | cut -d: -f1`
		name=`echo $machine | cut -d: -f2`
		ip=`echo $machine | cut -d: -f3`
		state=`echo $machine | cut -d: -f4`
		
		# on crée un dossier par groupe et on redirige le stderr dans /dev/null si le dossier existe déjà 
		# mkdir /var/www/visu/$group 2> /dev/null
		
		# on ajoute les informations de la machine dans la page index.html du groupe de la machine
		case $state in
			# si la machine est UP: couleur verte
			UP)
				echo "<div class='container'>
				<div class='row align-items-start shadow p3 mb-5 bg-body rounded-pill'>
					<div class='col fs-2'>$name</div>
					<div class='col fs-2'>$ip</div>
					<div class='col fs-2 text-success'>$state</div>
				</div>
				</div>" >> /var/www/visu/$group/index.html;;
			# si la machine n'est pas UP: couleur rouge
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
