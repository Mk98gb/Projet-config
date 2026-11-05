#!/bin/bash

#Vérification présence d'une ville en argument
if [ $# -eq 0 ]
then
    echo "Utilisation correcte : ./Extracteur_Meteo.sh ville"
    exit 1
fi

curl -o "fichier_meteo" https://wttr.in/$1

