
print("\n"*50)




##### declaration variable

# en bash:
# var=chocolat


# en python
var = "chocolat"


##### afficher le contenu d'une variable
# en bash: 
# echo $var

# en python:
print(var)



##### ! Grosse difference, les variables ont des types
# afficher type d'une variable

print(type(var))


### type str -> chaine de charactere

chaine="ceci est une phrase"


### type int -> integer, nombre

nombre=345

print(type(nombre))

### type bool -> booleen


var=True
var2=False


##### operations sur des types

## operations sur les nombres: +,*,-,/,%


addition=1+2

print(addition)

print(2*3+345/123%3)


nb1=4.3
nb2=3

print(nb1+nb2*3)

## operation sur des chaines de caractere

## concatenation

chaine1="bon"
chaine2="jour"

print(chaine1+chaine2+" il fait beau")
print("bon"*10)

# on peut pas print("bon"/3) ni "bon"*3.2



#### changer le type d'une variable, cast

int("3")
str(45)
float("3.5")


chaine="3"

print(type(chaine))
chaine=int(chaine)

print(type(chaine))


##### conditions

## en bash:

# if [[ condition ]]
# then
#   do something
# elif [[ condition ]]
# then
#   do something
# else
#   do something
# fi

# en python

# if condition:
#   do something
# elif condition:
#   do something
# else:
#   do something


condition=True
if condition:
    print("je suis dans la condition")
    a=1
    bon="bon"

print("je ne suis plus dans la condition")



### operation de comparaison


# en bash:

# egal a               ->  -eq ou =     
# superieur a          ->  -gt  
# superieur ou egal    ->  -ge
# inferieur a          ->  -lt
# inferieur ou egal a  ->  -le
# different de         ->  -ne ou  !=




# en python:

# egal a               ->   ==    
# superieur a          ->   >  
# superieur ou egal    ->   >=
# inferieur a          ->   <
# inferieur ou egal a  ->   <=
# different de         ->   !=


### operation logique

# en bash:

# ET    ->  &&   
# OU    ->  ||
# NOT   ->  !


# en python:

# ET    -> and
# OU    -> or
# NOT   -> not

 



nb1=5
nb2=5

if nb1 < nb2:
    print(str(nb1)+" est plus petit que "+str(nb2))
    print(nb1,"est plus petit que",nb2)
elif nb1 > nb2:
    print(str(nb1)+" est plus grand que "+str(nb2))
else:
    print(str(nb1)+" est egal a "+str(nb2))



meteo=False
parapluie=True




if meteo == True and parapluie == True:
    print("Je sors dehors")
elif meteo == False:
    print("il ne fait pas assez beau pour sortir")
elif parapluie == False:
    print("Je n'ai pas de parapluie au cas ou il va pleuvoir")


if "bon" == "bon":
    print("chaines egales")



#if True == True and False == True or False == False and not True == True



###### petit exo: le nombre mystere v1
# creer un nombre aléatoire entre 0 et 100
# l'utilisateur propose pour essayer de deviner le nombre mystere
# on lui repond si c'est plus haut ou plus bas ou si il a trouvé le nombre mystere

print("\n"*3)
print("########")
print("NOMBRE MYSTERE V1")
print("")


# importer un module : import
import random

# creer un nombre aléatoire entre 0 et 100
# en bash:
#   $(($RANDOM%100))


nb_mystere=random.randrange(0,100)

print("nombre mystere: ",nb_mystere)


# demander a l'utilisateur de deviner le nombre:
# en bash:
# read -p "Devinez le nombre: " nb_user

nb_user=int(input("Devinez le nombre: "))

print(nb_user)

if nb_user < nb_mystere:
    print(str(nb_user)+" est plus petit que le nombre a trouver")
elif nb_user > nb_mystere:
    print(str(nb_user)+" est plus grand que le nombre a trouver")
else:
    print("BRAVO vous avez trouve le nombre mystere: ",nb_mystere)



##### Boucles 
### boucle while
# en bash:

# while [[ condition ]]
# do
#   do something
# done

# en python:
# while condition:
#   do something


finit=False

while finit == False:
    print("dans la boucle")
    user=input("Voulez vous sortir de la boucle (yes)?: ")
    if user == "" or user == "yes":
        finit=True



### pour faire 10 tours de boucles while
# en bash:

# i=0

# while [[ $i -lt 10 ]]
# do
#   i=$((i+1))
# done


# en python:

i=0

while i<10:
    print("dans le while ",i)    
    i=i+1
    # i+=1


# tab == li

## boucle for:
# en bash:
# for i in tab
# do
#   do something
# done    


# en python:
# for i in li:
#   do something



# parcourir une liste de 0 a 10
# en bash:
# for i in $(seq 0 10)
# do
#   do something
# done

# en python:

for i in range(0,10):
    print("dans le for ",i)


#### BREAK et CONTINUE
# break casse la boucle
# continue passe a l'iteration suivante (prochain de boucle)
# !! A NE JAMAIS UTILISER JAMAIS !! (sauf pour des test)
# ca veut dire que vous avez mal pensé/codé votre programme 

# i=0
# while i<10:
   
#     if i==5:
#         break
#     i+=1





##### EXERCICE 1

# Nombre mystere v2

# on continue de jouer au nombre mystere (l 'utilsateur continue de chercher) tant
# qu'il n'a pas trouvé le nombre mystere.






#### EXERCICE 2

# Pile ou Face

# jouer au pile ou face avec contre. on demandera a l'utilisateur en combien de point est la victoire
# on joue tant qu'aucun joueur n'a gagné.

# l'ordinateur choisit aléatoirement pile ou face

# si l'utilisateur trouve le bon resultat on lui ajoute 1 point
# si il trouve pas l'ordi gagne 1 point





#### EXERCICE 3

# suite de fibonnacci v1

# demander a l'user la longueur de la suite de fibonnacci qu'il veut afficher
# on affiche la suite fibo jusqu'a ce nombre


# fibo: le prochain element de la liste est l'addition des deux précédents


# ex: l'user tape 9
# on affiche : 0 1 1 2 3 5 8 13 21














