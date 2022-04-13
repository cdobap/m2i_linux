#!/bin/bash

ask_clean_usb(){
    echo "nettoyer la cle [y/n]"
    read rep
    case $rep in 
        "y") clean_usb $1;;
        "n") echo "no usb clean";;
        *) ask_clean_usb $1;;
    esac
}
clean_usb(){
    # bash permission denied : lvs pvs vgs
    #pvs | $1
    #if_vg=`sudo pvs | $1`
    #if [[ ${#if_vg} -ne 0 ]]; then
        #vg_name_to_remove=`sudo pvs --separator ":" | grep $1 | cut -d: -f2`
        #echo $vg_name_to_remove
    #fi    
    # remove up to ten lv in vg01 and vg01
    # a faire : récuperer l'info et automatiser 
    sudo lvremove vg01/lv{0..10}
    sudo vgremove vg01
    sudo pvremove $1
    # clean
    dd if=/dev/zero of=$1
}
show_key_size(){
    echo "information cle:"
    # echo ${1: -3}
    # lsblk -o 
    # sed  -E "s/ +/ /g"
    lsblk | grep ${1: -3}
}
ask_fs(){
    echo "choisissez votre file système [ext4|vfat]"
    read fs
}
make_fs(){
    case $fs in
        "ext4") mkfs.ext4 /dev/mapper/"$1-lv$2";;
        # error cmd not found : apt install dosfstools
        "vfat") mkfs.vfat -F 32 /dev/mapper/"$1-lv$2";;
        *) ask_fs;;
    esac
}
ask_part_number(){
    echo "combien de partitions"
    read parts_number
    if [[ $parts_number =~ ^[0-9]+$ ]]; then
        parts=$parts_number
        let percent_part=100/$parts
    else
        ask_part_number
    fi
}
create_pv(){
    sudo pvcreate $1
    create_vg $1
}
create_vg(){
    echo "entrer le nom du vg:"
    read lenomduvg
    sudo vgcreate $lenomduvg $1    
    create_lv $1
}
create_lv(){
    for ((i=0; $i<$parts; i++)); do
        if [[ $i -eq $((parts-1)) ]]; then
            echo "creation du lv $i:"
            ask_fs
            sudo lvcreate -n "lv$i" -l 100%FREE $lenomduvg  
            make_fs $lenomduvg $i          
        else
            echo "creation du lv $i:"
            ask_fs
            sudo lvcreate -n "lv$i" -l $percent_part%VG $lenomduvg
            make_fs $lenomduvg $i  
        fi
    done
}
create_parts(){
    create_pv $1
}


main(){
    ask_clean_usb $1
    show_key_size $1
    ask_part_number
    create_parts $1
    lsblk
}

main $@