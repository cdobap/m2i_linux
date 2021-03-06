#!/bin/bash

# this script count the number of files, directories, and "executable"
# 

get_subdir_number(){
    # substract 1 to ommit the . dir
    let subdir_numb=`ls -lR $1 | grep ^d | wc -l`-1
    echo "$subdir_numb subdir"
}

get_files_number(){
    let files_numb=`ls -lR $1 | grep ^- | wc -l`
    echo "$files_numb files"
}

get_exec_files_number(){    
    let exec_files_numb=`ls -lR | find $1 -type f -perm /111 | wc -l`
    echo "$exec_files_numb exec files"
}

main(){
    d=`ls -ld $1`
    if [[ $d =~ ^d ]]; then
        get_subdir_number $1
        get_files_number $1
        get_exec_files_number $1
    else 
        echo "not a directory"
    fi
}

main $@