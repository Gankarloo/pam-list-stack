#!/bin/bash

function usage(){
    echo ""
    echo "      lists full pam stack for given service."
    echo "      $0 servicename type"
    echo "      example $0 sshd auth"
}

if [[ ! $# = 2 ]]
then
    usage
    exit 0
fi

while IFS='' read -r line || [[ -n "$line" ]];
do
    if [[ $line =~ ^@ ]];
    then
        nestedline=$(echo "$line" | awk '{print $2}')
        while IFS='' read -r nested || [[ -n "$nested" ]];
        do
            if [[ $nested =~ ^${2} ]];
            then
                echo "$nested"
            fi
        done </etc/pam.d/"${nestedline}"
    fi  
    if [[ $line =~ ^${2} ]];
    then
        echo "$line"
    fi
done </etc/pam.d/"${1}"
