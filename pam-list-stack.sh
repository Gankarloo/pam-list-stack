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
    if egrep -q "^@include" "$line"
    then
        while IFS='' read -r nestedline || [[ -n "$nestedline" ]];
        do
            egrep "^${2}.*" "$nestedline"
        done
        
    egrep "^${2}.*" "$line"
done < /etc/pam.d/"${1}"
