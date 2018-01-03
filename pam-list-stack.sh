#!/bin/bash

function usage(){
    echo "Usage: $0 <pamfile> <method>"
    echo ""
    echo "       <pamfile> is any file in /etc/pam.d directory"
    echo "       <method> is any of [auth][session][password][account]"
    echo ""
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
