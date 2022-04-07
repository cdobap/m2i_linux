#!/bin/bash

# this program has 3 options 
# -s [taskname] to create a task and print it into a .txt
# -l to list all
# -d [taskname] to delete a task

# create a task
set_task(){
    echo $1 >> exercice18_task.txt    
}
# read tasks
get_tasks(){
    cat exercice18_task.txt
}





case $1 in
    '-s') set_task $2;;
    '-l') get_tasks;;
    '-d') echo "opt d";;
    *) echo "invalid option: use [-s][-l][-d]";;
esac

