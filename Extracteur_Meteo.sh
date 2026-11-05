#!/bin/bash

#Vérification présence d'une ville en argument
if [ $1 -eq 0]
then
    echo "Utilisation correcte : ./Extracteur_Meteo.sh ville"
    exit 1
fi

curl https://wttr.in/$1 | echo > fichier_meteo

