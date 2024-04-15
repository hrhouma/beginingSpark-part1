```sh
sh (glisser le script1)
hive -f (glisser le script 2)
hive
show tables
 ```

## les requêtes sont dans script3.sql 


# 1 - Explication détaillée du script 1 : 

Ce script Bash a pour but d'automatiser la configuration d'un système de recommandation de films sur un système utilisant Hadoop et Hive. Voici une explication détaillée de chaque partie du script :

1. **Création d'un répertoire et définition de variables d'environnement** :
   ```bash
   mkdir /home/cloudera/Desktop/movieRecomendationsSystem
   export DIRX=/home/cloudera/Desktop/movieRecomendationsSystem
   cd $DIRX
   ```
   - Crée un répertoire nommé `movieRecomendationsSystem` sur le bureau de l'utilisateur `cloudera`.
   - Définit une variable d'environnement `DIRX` qui contient le chemin du répertoire créé.
   - Change le répertoire courant vers `DIRX`.

2. **Téléchargement des fichiers de données** :
   ```bash
   wget [URLs]
   ```
   - Télécharge les ensembles de données de MovieLens (différentes tailles de datasets pour les tests de performance ou les fonctionnalités).

3. **Décompression des fichiers téléchargés** :
   ```bash
   unzip ml-100k.zip
   unzip ml-1m.zip
   unzip ml-latest.zip
   ```
   - Extrait les fichiers des archives zip téléchargées dans le répertoire courant.

4. **Modification des permissions** :
   ```bash
   cd ..
   chmod -R 777 $DIRX
   ```
   - Remonte d'un niveau dans l'arborescence des répertoires.
   - Change les permissions du répertoire `DIRX` pour permettre à tous les utilisateurs de lire, écrire et exécuter les fichiers.

5. **Création de répertoires sur HDFS** :
   ```bash
   hdfs dfs -mkdir -p [paths]
   ```
   - Crée des répertoires dans HDFS (Hadoop Distributed File System) pour organiser les données selon les différentes tailles de datasets.

6. **Renommage et organisation des répertoires locaux** :
   ```bash
   mv ml-100k 100k
   mv ml-1m million
   mv ml-latest latest
   ```
   - Renomme les répertoires extraits pour simplifier leur manipulation.

7. **Copie des fichiers du système local vers HDFS** :
   ```bash
   hdfs dfs -copyFromLocal [local path] [HDFS path]
   ```
   - Transfère les fichiers du système local vers les répertoires correspondants sur HDFS.

8. **Téléchargement et déploiement de JARs nécessaires pour Hive** :
   ```bash
   wget [URLs]
   hdfs dfs -copyFromLocal $DIRX/csv-serde-1.1.2.jar hackerday_ratings/
   ```
   - Télécharge des JARs nécessaires pour l'interprétation des fichiers CSV dans Hive.
   - Copie le JAR `csv-serde` vers un emplacement sur HDFS pour utilisation ultérieure dans les jobs Hive.

9. **Nettoyage et préparation des données** :
   ```bash
   sed 's/::/@/g' [file] > [new file]
   hdfs dfs -mkdir -p [HDFS path]
   hdfs dfs -copyFromLocal [local cleaned file] [HDFS path]
   ```
   - Utilise la commande `sed` pour remplacer les délimiteurs dans les fichiers de données.
   - Prépare et copie les versions nettoyées des fichiers de données sur HDFS.

Ce script effectue donc une série d'opérations pour préparer un environnement permettant de manipuler et analyser des ensembles de données de films sur une infrastructure Hadoop, en utilisant des outils comme Hive pour des requêtes et analyses plus complexes.
