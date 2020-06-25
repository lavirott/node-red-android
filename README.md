# Node-RED sur Android

## Orchestration et Déploiement continu de services IoT sur cible Android

Ce travail a été donné dans le cadre des PFE2019 #035 groupe 1

### Résumé

Au cours des dernières années, de nombreux outils ont vu le jour pour soutenir le développement et le déploiement de systèmes logiciels pour le cloud (i.e., Puppet, Chef, Ansible, Vagrant, ...). Toutefois, à l'heure actuelle, les outils adaptés pour l'orchestration et le déploiement continus de services logiciels couvrant l'ensemble de l'espace IoT, Edge et Cloud ne sont pas répandus [1]. Dans le cadre du projet européen ENACT, nous travaillons sur cette problématique du déploiement et de l'orchestration de services logiciels sur des infrastructures hétérogènes de l'IoT [2]. Ce PFE a pour but de fournir un environnement pour l'orchestration et le déploiement de services sur des cibles ne disposant pas de fonctionnalités de la catégorie "Container-OS Architecture" [3] (type Docker), mais seulement "App-OS Architecture".

Plus spécifiquement, le projet consistera à étudier les différentes solutions pour le déploiement automatisé de Node-RED sur Android via l'App Store (un premier prototype a été réalisé, mais sans une automatisation complète de la procédure d'installation et de déploiement). Une application mettant en oeuvre la solution la plus adaptée devra être réalisée. Celle-ci devra aussi dynamiquement informer l'orchestrateur de la présence d'un nouveau noeud dans l'infrastructure pour son utilisation lors des futurs déploiements de services.

Mot-clés: IoT, Application Deployment, Orchestration


### Bibliographie

[1] P. H. Nguyen, N. Ferry, G. Erdogan, H. Song, S. Lavirotte, J.-Y. Tigli and A. Solberg. "A Systematic Mapping Study of Deployment and Orchestration Approaches for IoT". In Proceedings of the 4th International Conference on Internet of Things, Big Data and Security (IoTBDS), Heraklion, Greece, mai 2019. [2] N. Ferry, P. H. Nguyen, H. Song, P.-E. Novac, S. Lavirotte, J.-Y. Tigli and A. Solberg. "GeneSIS: Continuous Orchestration and Deployment of Smart IoT Systems". In Proceedings of the Compsac 2019: Data Driven Intelligence for a Smarter World, Milwaukee, Wisconsin, USA, juillet 2019. [3] A. Taivalsaari and T. Mikkonen, "A Taxonomy of IoT Client Architectures," in IEEE Software, vol. 35, no. 3, pp. 83-88, May/June 2018.

### Encadrants: 

Encadrant: 
 - Stéphane Lavirotte, Université Côte d’Azur, CNRS, I3S, UMR 7271 (Stephane.Lavirotte@univ-cotedazur.fr)

Co-encadrant:
 - Jean-Yves Tigli, Université Côte d’Azur, CNRS, I3S, UMR 7271 (Jean-Yves.Tigli@univ-cotedazur.fr)

### Etudiants:

 - Anthony LOPES
 - Balsam CHIHI
 - Rihab ZAAFOURI

# How to build the project from src :

 1. There is no need to clone the whole git repo, you only need to get the android studio src and the file sytem images.
 2. There are two android studio projects : termux API and termux APP, you only need the APP project for now.
 3. Open the andrdoid studio project termux APP.
 4. Under termux-app/app/scr/main/cpp/filesystem_patch you will find three files "bash.bashrc", "motd" and "flows_localhost.json".
 4.1. "bash.bashrc" is the shell script that launches every time the App starts.
 4.2. "motd" is the welcome text file displayed every time the App starts.
 4.3. "flows_localhost.json" is the auto startup node-red flow.
 5. Then, you have to add these files to the filesystem images according to desired target architecture.
 5.1. "bash.bashrc" under /etc/
 5.2. "motd" under /etc/
 5.3. "flows_localhost.json" under /tmp/
 6. Then, you need the other android project "termux API" : you could build or just use the already build APK flile, there is no need to edit this project.
 7. Now all work is done, build the app and generate APK, the upload to target device and start it.

=> The app will start and execute the Shell script to configure and install needed packages. The app exits on it's own, so you have to relaunch it to start node-red automatically and deploy the flow.
   

