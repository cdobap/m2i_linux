#!/bin/bash

# this script count the number of entry in /var/log/auth.log
# count the number of time that sudo/root has been used 
# show ip in and number of connection in 
# all this data are saved in exercice16_analyse_log.txt
# 22/04/07

# define variable

# get number of entry in of auth.log
get_number_entry(){
    auth_file=`cat /var/log/auth.log | wc -l`
    echo "$auth_file entries"
}

# get number of root connection
get_number_root_connection(){
    number=`cat /var/log/auth.log | grep "session opened for user root" | wc -l`
    echo "$number root connections"
}

main(){
    get_number_entry
    get_number_root_connection
}

main