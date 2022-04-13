#!/bin/bash


# verification des arguments
# on parcourt le tableau des arguments
for arg in $@
do
    # on verifit chaque argument ([a-z]*=)
    # on recupere seulement la partie de droite (après le =)
    if [[ $arg =~ ^device= ]]
    then   
        device=$(echo $arg | cut -d"=" -f2)
    elif [[ $arg =~ ^part=[1-9]* ]]
    then
        nbpart=$(echo $arg | cut -d"=" -f2)
    elif [[ $arg =~ --clean ]]
    then
        clean=true
    elif [[ $arg =~ --crypt ]]
    then
        crypt=true
    fi
done



#verifie si l'user a rentré l'argument device=/de.*
if [ -z $device ]
then
    echo "Variable device est requise"
    exit
fi

# nom du device (sdb, sans le /dev/)
name=$(echo $device | cut -d"/" -f3)



#verifie si le device existe
lsblk -l $device &>/dev/null

#verifie le code de sortie, si la commande precedente a return 0 c'est que le lsblk a trouve le device
if  [[ $? -ne 0 ]]
then
    echo "Impossible de trouver le peripherique: " $device
    exit
fi


# verifie si il y deja un vg dans le device
# si oui on le supprime

ifvg=$(lsblk -l $device | grep "VGmakey")
if [[ -z $ifvg ]]
then
    echo "Aucun VG trouvé sur le peripherique"
else
    # recupere le nom du VG
    vg=$(sudo pvs | grep $device | sed -E "s/ +/ /g" | cut -d" " -f 3)
    vgremove $vg -y > /dev/null
fi


# si l'utilisateur a mit l'argument --clean 
if [[ $clean == true ]]
then
    echo ""
    echo "###### ! [ATTENTION EFFACEMENT COMPLET ] ! ####### "

    read -p "Voulez vous nettoyer le peripherique: $device " clean

    if [[ $clean =~ (Y|y|yes) ]]
    then
        echo "Nettoyage..."
        dd if=/dev/zero of=$device bs=4M
    fi
fi

# cryptage
SERIALdevice=$(lsblk -no +"SERIAL" | grep "$name" | sed -E "s/ +/ /g" | cut -d" " -f7)
read -p "Voulez-vous chiffrer la clé ?" crypto

if [[ ! -e /var/makey ]]
then
    mkdir /var/makey
    echo "on a créer le répertoire var/makey"
fi

if [[ $crypto =~ (Y|yes|Oui|O|o|y|) ]]
then
    echo "Cryptage..."
    dd if=/dev/urandom of=/var/makey/$SERIALdevice bs=1000 count=1
    cryptsetup luksFormat $device --key-file /var/makey/$SERIALdevice
    cryptsetup luksOpen $device crypt$SERIALdevice --key-file /var/makey/$SERIALdevice  
    device_path=/dev/mapper/crypt$SERIALdevice
else
    device_path=/dev/mapper/crypt$SERIALdevice
fi

# recupere la taille totale du device

#lsblk -l -o NAME,SIZE | grep "sdb" | grep -o -E "[0-9]*(,?)[0-9]*[MG]"
taille=$(lsblk -l | grep "$name " | sed -E "s/ +/ /g" | cut -d " " -f4)


echo ""
echo "Il y a $taille de disponible sur le peripherique: $device"


# si l'user n'a pas mit part= en argument alors on lui demande le nombre de partitions
if [[ -z $nbpart ]]
then
    while ! [[ $nbpart =~ ^[0-9]*$ ]]
    do
        read -p "Combien de partitions voulez vous? " nbpart
    done
fi

echo "########### [LVM]"

# creation volume physique
# pvcreate $device   
pvcreate $device_path

# on recupere le nombre de VGmakey deja crees on s'en sert pour creer un nouveau VG unique 
# (si on lance le programme pour plus d'une clee en meme temps)
nbVG=$(ls -l /dev/ | grep VGmakey | wc -l)
vgname=VGmakey$nbVG
#vgname=VGmakeyCRYPT

# creation virtual group
vgcreate $vgname $device_path
# vgcreate $vgname $device


# definition de la taille des partitions en pourcentage
taillePartition=$((100/$nbpart))


# on parcourt le nombre de partitions demande -1 pour que la derniere partition aucune toute la place restante possible
# ex: nbpart=3
for i in $(seq 1 $(($nbpart -1)) )
do

    # creation logical volume 
    # ex: -l 33.33%VG
    lvcreate -n "lv$i" $vgname -l $taillePartition%VG 
done

# creation logical volume
# ex: -l 100%FREE (env 34%)
lvcreate -n "lv$(($i+1))" $vgname -l 100%FREE


echo ""
echo "########### [MKFS]"

# on parcourt la liste des lv crees
for lv in $(lsblk -l $device | grep $vgname | cut -d" " -f1)
do
    # on met un systeme de fichier dessus
    mkfs.ext4 /dev/mapper/$lv
done

echo ""
echo "partitions LVM et Formattage ext4 terminé..."
echo ""
lsblk $device

cryptsetup luksClose $device_path