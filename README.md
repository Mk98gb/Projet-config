# Projet-config
Projet de configuration de travail

Objectif : extraire les données météo d'une ville donnée dans un fichier texte

Comment fonctionne le script : 

- commande : ./Extracteur_Meteo.sh ville
- ouvrir le fichier txt pour avoir les données


Configuration d'une tâche cron : 

A savoir: cron est un outil qui permet d'exécuter automatiquement un script à une horaire défini.

- S'assurer que les droits sont présent ou les attribuer (chmod +x Extracteur_Meteo.sh)

- Ouvrir cron : crontab -e

- Ajouter une tâche : ***** cd /chemin/projet && ./Extracteur_Meteo.sh Ville

- Les 5 étoiles peuvent être remplacé pour définir la date et heure d'exécution.

- Première étoile : Minutes
- Deuxième étoile: Heure
- Troisième étoile : Jour du mois
- Quatrième étoile : Numéro du mois
- Cinquièmme étoie : Jour de la semaine


Pour supprimer une tâche, ouvrez crontab -e et supprimer la ligne qui correspond à la tâche que vous voulez supprimer.

