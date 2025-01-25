# vol-pneus-de-voiture

La fonction GetPlayersWithJob est un exemple à adapter selon ton système ESX ou QBCore

Système d'inventaire : Remplace les fonctions de vérification et d'ajout d'objets par celles de ton système d'inventaire (comme ESX, QBCore, ou un autre).
Notifications : Les joueurs proches sont notifiés avec un message lorsqu'un vol a lieu.
Temps et animations : Une animation est déclenchée pour simuler l'acte du vol.

1 Démarrer le script
Ouvre le fichier server.cfg dans le répertoire principal de ton serveur.
Ajoute la ligne suivante à la fin :
ensure vol_pneu 
2 Redémarrer ton serveur
Redémarre le serveur via ton gestionnaire ou la console.
Une fois en jeu, utilise la commande /volerpneu pour tester. 

Si ton serveur utilise un framework comme ESX ou QBCore, tu devras adapter la gestion de l'inventaire (VerifierObjet) et des métiers (GetPlayersWithJob)
