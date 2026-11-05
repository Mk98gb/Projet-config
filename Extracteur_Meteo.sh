#!/bin/bash

#Vérification présence d'une ville en argument
if [ $# -eq 0 ]
then
    echo "Utilisation correcte : ./Extracteur_Meteo.sh ville"
    exit 1
fi

curl  -o "fichier_meteo" https://wttr.in/$1

TEMP_ACTUELLE=$(grep "°C" fichier_meteo | head -n 1 | tr -s ' ' | rev | cut -d ' ' -f 1-2 | rev)
TEMP_LENDEMAIN=$(grep "°C" fichier_meteo | head -n 3 | tail -n 1 | cut -d '│' -f 3 | tr -s ' ' | rev | cut -d ' ' -f 2-3 | rev)

TEMP_ACTUELLE=$(echo "$TEMP_ACTUELLE" | tr "\033" "\n" | cut -d "m" -f 2 | tr -d "\n" | tr -d "+" | cut -d "(" -f 1 | cut -d " " -f 1)
TEMP_LENDEMAIN=$(echo "$TEMP_LENDEMAIN" | tr "\033" "\n" | cut -d "m" -f 2 | tr -d "\n" | tr -d "+" | cut -d "(" -f 1 | cut -d " " -f 1)

TEMP_ACTUELLE="$TEMP_ACTUELLE°C"
TEMP_LENDEMAIN="$TEMP_LENDEMAIN°C"
 
echo "Température actuelle à $1 : $TEMP_ACTUELLE"
echo "Prévision pour demain : $TEMP_LENDEMAIN"
