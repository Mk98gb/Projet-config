#!/bin/bash

#Vérification présence d'une ville en argument
if [ $# -eq 0 ]
then
    echo "Utilisation correcte : ./Extracteur_Meteo.sh ville"
    exit 1
fi

curl -s -o "fichier_meteo" "https://wttr.in/$1"

# Température actuelle : premier nombre de la 1re ligne contenant °C
LIGNE=$(grep "°C" fichier_meteo | head -n 1)
LIGNE=$(echo "$LIGNE" | tr "\033" "\n" | cut -d "m" -f 2- | tr -d "\n")
TEMP_ACTUELLE=$(echo "$LIGNE" | grep -o -E "[-+]?[0-9]+" | head -n 1 | tr -d "+")

# Lendemain : 3e ligne contenant °C, 2e colonne (midi), premier nombre
LIGNE=$(grep "°C" fichier_meteo | head -n 3 | tail -n 1)
LIGNE=$(echo "$LIGNE" | tr "\033" "\n" | cut -d "m" -f 2- | tr -d "\n")
TEMP_LENDEMAIN=$(echo "$LIGNE" | grep -o "│[^│]*" | head -n 2 | tail -n 1 | grep -o -E "[-+]?[0-9]+" | head -n 1 | tr -d "+")

TEMP_ACTUELLE="$TEMP_ACTUELLE°C"
TEMP_LENDEMAIN="$TEMP_LENDEMAIN°C"

echo "Température actuelle à $1 : $TEMP_ACTUELLE"
echo "Prévision pour demain : $TEMP_LENDEMAIN"

date=$(date +"%d-%m-%Y")
heure=$(date +"%H:%M")

echo "$date - $heure - $1 : $TEMP_ACTUELLE - $TEMP_LENDEMAIN" >> meteo.txt