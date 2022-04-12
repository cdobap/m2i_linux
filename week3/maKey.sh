#!/bin/bash

ask_clean_usb(){
    echo "nettoyer la cle [y/n]"
    read rep
    case $rep in 
        "y") clean_usb $1;;
        "n") echo "no";;
        *) ask_clean_usb $1;;
    esac
}
clean_usb(){
    dd if=/dev/zero of=$1
}
show_key_size(){
    echo "information cle:"
    # echo ${1: -3}
    # lsblk -o 
    # sed  -E "s/ +/ /g"
    lsblk | grep ${1: -3}
}
ask_part_number(){
    echo "combien de partitions"
    read parts_number
    if [[ $parts_number =~ ^[0-9]+$ ]]; then
        parts=$parts_number
        let percent_part=100/$parts
        echo $percent_part
    else
        ask_part_number
    fi
}
create_pv(){
    sudo pvcreate $1
    create_vg $1
    #echo "pv create"
}
create_vg(){
    sudo vgcreate lenomduvg $1
    create_lv $1
    #echo "vg create"
}
create_lv(){
    for ((i=0; $i<$parts; i++)); do
        sudo lvcreate -n "lv$i" -l $percent_part%VG lenomduvg
        #echo "lv create"
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
}

main $1