#!/bin/bash

trap befree SIGUSR2

wyszlazIloma=0

depositFile() {
    nazwa=$(ls -A BufferBucket/ | head -1)
    plik="BufferBucket/${nazwa}"

    mv $plik Deposit/
    ((wyszlazIloma+=1))
    echo "Przeniesiono $nazwa do depozytu."
}

befree() {
    exit $wyszlazIloma
}

while true
do
    if [[ "$(ls -A BufferBucket/)" || "$([[ -d proc/$1 ]])" ]]
    then
        if [ "$(ls -A BufferBucket/)" ]
        then
            depositFile
        fi
    else
        befree
    fi
done