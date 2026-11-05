#!/bin/bash

#Ville par défaut si aucune ville n'est donnée en argument
if [ $# -eq 0 ]
then
    VILLE="Toulouse"
else
    VILLE=$1
fi

curl -s -o "fichier_meteo" "https://wttr.in/$VILLE?T"

#Variante 3 pour le log des erreurs
if [ $? -eq 0 ]
then
# Température actuelle : premier nombre de la 1re ligne contenant °C
TEMP_ACTUELLE=$(grep "°C" fichier_meteo | head -n 1 | grep -o -E "[-+]?[0-9]+" | head -n 1 | tr -d "+")

# Lendemain : 3e ligne contenant °C, 2e colonne (midi), premier nombre
TEMP_LENDEMAIN=$(grep "°C" fichier_meteo | head -n 3 | tail -n 1 | grep -o "│[^│]*" | head -n 2 | tail -n 1 | grep -o -E "[-+]?[0-9]+" | head -n 1 | tr -d "+")

TEMP_ACTUELLE="$TEMP_ACTUELLE°C"
TEMP_LENDEMAIN="$TEMP_LENDEMAIN°C"

echo "Température actuelle à $VILLE : $TEMP_ACTUELLE"
echo "Prévision pour demain : $TEMP_LENDEMAIN"

date=$(date +"%Y-%m-%d")
heure=$(date +"%H:%M")

echo "$date - $heure - $VILLE : $TEMP_ACTUELLE - $TEMP_LENDEMAIN" >> meteo.txt
else
date=$(date +"%Y-%m-%d")
heure=$(date +"%H:%M")
echo "$date - $heure - $VILLE : $TEMP_ACTUELLE - $TEMP_LENDEMAIN : ERREUR de recuperation de données : $?" >> meteo_error.log
fi

#Version 3 pour avoir un gestion de l'historique
date=$(date +"%Y-%m-%d")
heure=$(date +"%H:%M")
date1=$(date +"%Y%m%d")

echo "$date - $heure - $VILLE : $TEMP_ACTUELLE - $TEMP_LENDEMAIN" >> meteo_$date1.txt

#option pour la variante 1 avec ajout de 3 variables 
VENT=$(grep "km/h" fichier_meteo | head -n 1 | grep -o -E "[0-9]+(-[0-9]+)? km/h")
VISIBILITE=$(grep " km" fichier_meteo | grep -v "km/h" | head -n 1 | grep -o -E "[0-9.]+ km")
HUMIDITE=$(grep "%" fichier_meteo | head -n 1 | grep -o -E "[0-9]+%" | head -n 1)

date_v1=$(date +"%d-%m-%Y")
heure_v1=$(date +"%H:%M")

echo "$date_v1 - $heure_v1 - $VILLE : $TEMP_ACTUELLE - $TEMP_LENDEMAIN - Vent : $VENT - Humidité : $HUMIDITE - Visibilité : $VISIBILITE" >> meteo.txt

#Variante 2 pour sauvegarder un fichier JSON
echo "{
    \"date\": \"$date\",
    \"heure\": \"$heure\",
    \"ville\": \"$1\",
    \"temperature\": \"$TEMP_ACTUELLE\",
    \"prevision\": \"$TEMP_LENDEMAIN\",
    \"vent\": \"$VENT\",
    \"humidite\": \"$HUMIDITE\",
    \"visibilite\": \"$VISIBILITE\" 
}" > meteo.json

