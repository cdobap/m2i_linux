#!/bin/bash


# on boucle pour chercher les mises à jour du fichier de la base de données
while true; do
	# on supprime le contenu de la page d'accueil
	rm /var/www/visu/index.html

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
		# on crée un dossier pour chaque groupe et on redirige stderr si il existe déjà
		mkdir /var/www/visu/$grp 2> /dev/null
		# on link bootstrap dans la page html de chaque groupe pour faire du css plus rapidement
		echo '<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">' >> /var/www/visu/$grp/tmp.html
		# on ajoute le nom du groupe dans sa page html
		echo "<h1 class='border border-5 text-center mb-5'>$grp</h1>" >> /var/www/visu/$grp/tmp.html
	done
	# on ferme les balises ouvertes avant la boucle
	echo "</div></div'>" >> /var/www/visu/index.html

	
	# on définit une variable bdd dans laquelle on appelle le résultat de la commande cat
	bdd=`cat /home/visu/bdd`
	
	i=0	
	# on parcourt chaque ligne de $bdd et on stock les données das machines dans des variables
	for machine in $bdd; do
		# on stock le nom du groupe dans la variable groupe
		group=`echo $machine | cut -d: -f1`
		name=`echo $machine | cut -d: -f2`
		ip=`echo $machine | cut -d: -f3`
		#state=`echo $machine | cut -d: -f4`
		# on ping l'adresse ip de la machine pour définir son état
		ping -c 1 -W 0.1 $ip #1> /dev/null 
		case $? in 
			0) state="UP";;
			1) state="DOWN";;
		esac
		i=$((i+1))	
		echo $i
		# on ajoute les informations de la machine dans la page tmp index.html du groupe de la machine
		case $state in
			# si la machine est UP: couleur verte
			UP)
				echo "<div class='container'>
				<div class='row align-items-start shadow p3 mb-5 bg-body rounded-pill text-center'>
					<div class='col fs-2'>$name</div>
					<div class='col fs-2'>$ip</div>
					<div class='col fs-2 text-success'>$state</div>
				</div>
				</div>" >> /var/www/visu/$group/tmp.html;;
			# si la machine n'est pas UP: couleur rouge
			*)					
				echo "<div class='container'>
				<div class='row align-items-start shadow p3 mb-5 bg-body rounded-pill text-center'>
					<div class='col fs-2'>$name</div>
					<div class='col fs-2'>$ip</div>
					<div class='col fs-2 text-danger'>$state</div>
				</div>
				</div>" >> /var/www/visu/$group/tmp.html;;
		esac
	done
# on remplace l'index par la tmp 
for grp in $list_groups; do
	mv /var/www/visu/$grp/tmp.html /var/www/visu/$grp/index.html
done
	# on met le programme en attente pendant 60 secondes
	sleep 60
done
