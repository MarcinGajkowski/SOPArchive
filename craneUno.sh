#!/bin/bash

wyszedlzIloma=0

withdrawFile() {
    nazwa=$(ls -A Withdraw/ | head -1)
    plik="Withdraw/${nazwa}"

    mv $plik BufferBucket/
    ((wyszedlzIloma+=1))
    echo "Przeniesiono $nazwa do buforu."
}

while true
do
    if [ "$(ls -A Withdraw/)" ]
    then
        if [[ $(ls BufferBucket/ | wc -l) -ge 3 ]]
        then
            echo "Bufor jest przepełniony"
        else
            withdrawFile
        fi
    else
        exit $wyszedlzIloma
    fi
done