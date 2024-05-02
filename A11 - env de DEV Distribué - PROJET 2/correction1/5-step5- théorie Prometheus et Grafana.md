# 1 - C'est quoi Prometheus et Grafana :

**Prometheus** est un outil open-source de surveillance et d'alerte conçu principalement pour surveiller les applications et les infrastructures. 
- Il collecte des métriques (données de performance) sur ces applications à intervalles réguliers.
- Les métriques sont stockées dans une base de données de séries temporelles, ce qui permet de suivre l'évolution des performances dans le temps.

**Grafana** est une plateforme open-source de visualisation et de surveillance qui permet de créer des tableaux de bord interactifs. 
- Il peut se connecter à diverses sources de données, dont Prometheus, pour visualiser les métriques sous forme de graphiques, de jauges et d'autres éléments visuels.
- Cela permet aux utilisateurs d'interpréter facilement les données et d'identifier les problèmes potentiels.

- En résumé, Prometheus collecte les métriques, et Grafana les visualise.

# 2 - Vulgarisation 1 de Prometheus et Grafana :

- Imaginons que Prometheus et Grafana soient comme un duo de super-héros pour surveiller vos systèmes informatiques :

1. **Prometheus, le Gardien des Données :**
- Prometheus est un logiciel qui recueille des "signaux vitaux" provenant de tous vos ordinateurs et programmes.
- Pensez à lui comme un médecin qui prend régulièrement votre température, votre tension artérielle, et d'autres mesures de santé importantes.
- Chaque fois qu'un système envoie un signal indiquant s'il fonctionne bien ou non, Prometheus le collecte et le stocke dans un carnet spécial, appelé une base de données de séries temporelles.
- Cela permet de suivre la santé de vos systèmes au fil du temps et de détecter les problèmes potentiels.

2. **Grafana, le Visualiseur :**
- Grafana est un logiciel qui prend toutes les données que Prometheus collecte et les transforme en graphiques et en tableaux de bord élégants et colorés.
- C'est comme le compagnon artistique de Prometheus qui sait dessiner des images compréhensibles à partir de tous ces signaux vitaux.
- Avec Grafana, vous pouvez facilement voir où se trouvent les problèmes et si vos systèmes fonctionnent comme prévu.

*Ensemble, Prometheus et Grafana forment une équipe puissante pour surveiller et visualiser l'état de vos systèmes informatiques.*

# 3 - Vulgarisation 2 de Prometheus et Grafana :
- Pour mieux comprendre Prometheus et Grafana avec des exemples concrets, imaginons deux situations :

1. **Gestion d'un Restaurant (Prometheus) :**
   Un grand restaurant souhaite surveiller la température de ses réfrigérateurs pour s'assurer que les aliments sont stockés en toute sécurité. Prometheus est comme un employé chargé de vérifier ces températures toutes les 10 minutes. Il note chaque mesure dans son carnet (base de données) afin que le chef puisse toujours savoir si les réfrigérateurs fonctionnent correctement et s'il y a des variations inhabituelles.

2. **Affichage des Informations de Gestion (Grafana) :**
   Le restaurant utilise également Grafana, un tableau de bord numérique dans le bureau du chef. Sur ce tableau de bord, le chef peut voir des graphiques montrant la température de chaque réfrigérateur au cours des dernières heures, jours ou semaines. Cela lui permet d'identifier facilement les réfrigérateurs qui fonctionnent mal et de planifier la maintenance avant qu'un problème majeur ne survienne.

   En utilisant Grafana, le chef n'a pas besoin de lire les mesures individuelles notées par Prometheus. Il peut tout de suite repérer les tendances et prendre des décisions rapidement.

- En d'autres termes, Prometheus collecte les données, tandis que Grafana les visualise pour que l'équipe puisse prendre des décisions éclairées.
