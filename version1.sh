#Écrire un script Shell (Extracteur_Météo.sh) dont le but est de récupérer la météo locale. Ce script
#acceptera une ville en argument (ex : ./Extracteur_Météo.sh Toulouse).
#Voici les étapes à réaliser (version intermédiaires) :
#1. Utiliser curl pour récupérer les données météorologiques brutes concernant cette ville qui
#sont retournées par le service wttr.in et les sauvegarder dans un fichier local #

!/bin/bash

curl https://wttr.in/ | echo > fichier_meteo
