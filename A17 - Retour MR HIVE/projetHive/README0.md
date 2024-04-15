# 1. Tâches du script Bash
Ce script Bash effectue plusieurs tâches liées à la configuration d'un système de recommandation de films en utilisant les ensembles de données de GroupLens :

- **Création d'un répertoire** : Le script commence par créer un répertoire nommé `movieRecomendationsSystem` sur le bureau d'un utilisateur appelé `cloudera`.
- **Téléchargement des données** : Il télécharge trois versions différentes de l'ensemble de données MovieLens (100k, 1M et la plus récente) depuis le site web de GroupLens.
- **Décompression des fichiers** : Après le téléchargement, il décompresse ces fichiers dans le répertoire nouvellement créé.
- **Configuration des permissions** : Modifie les permissions du répertoire pour garantir l'accessibilité.
- **Organisation des données** : Déplace et renomme les répertoires pour une meilleure organisation.
- **Préparation du HDFS** : Crée les répertoires nécessaires dans le HDFS (Hadoop Distributed File System) et copie les données de la machine locale vers ces répertoires.
- **Préparation des données** : Scripts supplémentaires pour télécharger des fichiers JAR liés à Hive, manipuler les formats de données, et copier des données encore plus raffinées dans le HDFS.

# 2. Tâches des scripts SQL Hive
Le script SQL Hive se concentre sur la configuration de différentes tables externes dans Hive qui référencent les données stockées dans HDFS :

- **Configuration de l'environnement** : Définit le moteur d'exécution de Hive sur `Tez` pour un traitement plus efficace.
- **Suppression des tables existantes** : Assure l'absence de conflits en supprimant les tables existantes si elles existent.
- **Création de tables** : Établit de nouvelles tables externes pour gérer différents aspects des données telles que les détails des utilisateurs, les informations sur les films, les évaluations, etc., dans différents ensembles de données.
- **Importation des données** : Utilise les données stockées dans HDFS pour remplir ces tables.
- **Formatage des données** : Certaines tables sont configurées pour gérer des données avec des délimiteurs spécifiques et des types de données adaptés à l'analyse.

# 3. Requêtes SQL analytiques
Ces requêtes sont conçues pour extraire des informations significatives des données structurées dans Hive :

- **Année avec le plus grand nombre d'évaluations** : Identifie l'année avec le plus grand nombre d'évaluations.
- **Film le mieux noté chaque année** : Trouve le film ayant la meilleure note moyenne pour chaque année, en s'assurant que les films avec un nombre significatif d'évaluations sont considérés.
- **Nombre maximum d'utilisateurs par film et par année** : Calcule quel film a eu le plus d'utilisateurs distincts le notant chaque année.
- **Jointure des utilisateurs max avec les films les mieux notés** : Fusionne les données pour découvrir quels films ont non seulement eu le plus d'utilisateurs chaque année mais étaient également bien notés.
- **Analyse de la popularité à long terme** : Examine les films qui ont connu une augmentation significative des évaluations 5 ans après leur sortie, offrant des perspectives sur les tendances de popularité des films à long terme.

- Ces scripts et requêtes ensemble constituent une approche complète pour configurer, gérer et analyser un grand ensemble de données sur les évaluations de films, en utilisant des outils comme Bash pour la configuration et la gestion, et Hive pour les requêtes structurées et l'analyse. 
- Cette configuration convient aux analystes de données cherchant à tirer des insights de grands ensembles de données dans un environnement de calcul distribué.
