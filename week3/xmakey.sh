#!/bin/bash


user=`whoami`
echo $user



get_file(){
    # to do: check $# and do a loop
    path=${1:6}
    # echo $path
    # case $path in
    #     ^"~/"*) echo "test" && pwd;;
    #     "/home/baptiste/"*) echo "retest" && pwd;;
    #     "*/*") echo "do a cut -d / -f2" && pwd;;
    #     *) echo "yaya"
    # esac
    
    use sed or cut to slit "/"   =>  pwd  => get 
    the last to get the name file => path = pwd/filename


}









main(){
    for arg in $@; do
        case $arg in
            device=*) sudo bash makey.sh $arg part=1;;
            files=*) get_file $arg;;
            *) echo "invalid option"; break;;
        esac
    done
}

main $@