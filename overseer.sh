#!/bin/bash

trap engage SIGUSR1
trap terminate SIGINT

unoPID=0
dosPID=0

engage() {
    ./craneUno.sh &
    unoPID=$!
    echo "Inicjowano pierwszy dźwig."

    ./craneDos.sh $unoPID &
    dosPID=$!
    echo "Inicjowano drugi dźwig."

    wait $unoPID
    unoPliki=$?
    unoPlikiKoniec=$(($unoPliki%10))
    komunikat1="Pierwszy dźwig w stanie spoczynku. Przeniósł "
    if [ $unoPliki -eq 1 ]
    then
        komunikat1+="$unoPliki plik."
    elif [[ $unoPlikiKoniec -ge 2 && $unoPlikiKoniec -le 4 && ($unoPliki -lt 12 || $unoPliki -gt 14) ]]
    then
        komunikat1+="$unoPliki pliki."
    else
        komunikat1+="$unoPliki plików."
    fi
    echo $komunikat1

    wait $dosPID
    dosPliki=$?
    dosPlikiKoniec=$(($dosPliki%10))
    komunikat2="Drugi dźwig w stanie spoczynku. Przeniósł "
    if [ $dosPliki -eq 1 ]
    then
        komunikat2+="$dosPliki plik."
    elif [[ $dosPlikiKoniec -ge 2 && $dosPlikiKoniec -le 4 && ($dosPliki -lt 12 || $dosPliki -gt 14) ]]
    then
        komunikat2+="$dosPliki pliki."
    else
        komunikat2+="$dosPliki plików."
    fi
    echo $komunikat2

    echo "Praca obu dźwigów zakończona."
    exit
}

terminate() {
    echo "Zterminowano oba dźwigi."
    kill -KILL $unoPID
    kill -KILL $dosPID
    exit
}

while true 
do
    echo "Proces nadzorcy ma ID nr $$ ;"
    sleep 10
done