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

La commande `sed` est un outil très puissant utilisé dans les systèmes Unix et Linux pour manipuler le texte dans un fichier de manière scriptée. C'est l'acronyme de "stream editor" (éditeur de flux). Il permet de réaliser des opérations complexes de recherche, remplacement, insertion ou suppression de texte sans ouvrir l'interface d'un éditeur de texte traditionnel.

# 2 - Explication détaillée de la commande sed : 
Expliquons en détail la commande `sed`  :

```bash
sed 's/::/@/g' $DIRX/million/ratings > $DIRX/million/ratings_clean
```

### Éléments de la commande

1. **sed** - C'est le nom de la commande elle-même qui lance l'éditeur de flux.

2. **'s/::/@/g'** - Ceci est une expression qui dit à `sed` ce qu'il doit faire avec chaque ligne de texte qu'il lit.

   - **s** - Indique le début d'une commande de substitution dans `sed`. C'est probablement la fonction la plus couramment utilisée de `sed`.
   - **/::/@/** - Le motif après le premier `/` est le motif à chercher, ici `::`, et le motif entre le deuxième et le troisième `/` est celui par lequel le motif trouvé doit être remplacé, ici `@`.
   - **g** - Cela se trouve après le troisième `/` et signifie "global". Sans ce `g`, `sed` remplacerait seulement la première occurrence de `::` dans chaque ligne. Avec `g`, il remplace toutes les occurrences dans chaque ligne.

3. **$DIRX/million/ratings** - Ceci spécifie le fichier d'entrée sur lequel `sed` doit opérer. `$DIRX` est une variable qui contient le chemin d'accès au répertoire où les fichiers sont stockés.

4. **> $DIRX/million/ratings_clean** - Le caractère `>` redirige la sortie de `sed` vers un nouveau fichier. Ici, au lieu de modifier le fichier original (`$DIRX/million/ratings`), la sortie modifiée est écrite dans un nouveau fichier appelé `ratings_clean` dans le même répertoire.

### Fonctionnement de la commande

Lorsque vous exécutez cette commande, `sed` lit le fichier spécifié (`$DIRX/million/ratings`), cherche toutes les occurrences de la chaîne `::` dans chaque ligne et les remplace par `@`. Cette opération est réalisée pour chaque ligne du fichier, et le résultat est enregistré dans le fichier `ratings_clean`. Le fichier original n'est pas modifié.

Cette commande est utile, par exemple, pour formater les données pour qu'elles soient compatibles avec un autre outil ou système qui attend un délimiteur différent (ici `@` au lieu de `::`), ou pour uniformiser les données avant de les analyser ou de les traiter davantage.

# 3 - Exemples simples de la commande sed : 
 - Voici quelques exemples simples qui illustrent l'utilisation de `sed` pour réaliser des opérations de base sur le texte. 
 - Ces exemples te permettront de mieux comprendre comment manipuler des fichiers ou des chaînes de caractères à l'aide de cet outil puissant.

### 1. Remplacer du texte dans une chaîne
Supposons que tu aies un fichier nommé `exemple.txt` contenant le texte suivant:
```
Bonjour le monde
```
Pour remplacer "Bonjour" par "Salut", tu pourrais utiliser la commande suivante :
```bash
sed 's/Bonjour/Salut/' exemple.txt
```
Cela afficherait :
```
Salut le monde
```

### 2. Supprimer toutes les lignes vides d'un fichier
Si `exemple.txt` contient des lignes vides que tu souhaites supprimer, tu pourrais utiliser :
```bash
sed '/^$/d' exemple.txt
```
Cette commande supprime (`d`) toutes les lignes qui correspondent à l'expression régulière `^$` (qui représente une ligne vide).

### 3. Ajouter du texte à la fin de chaque ligne
Pour ajouter "!!" à la fin de chaque ligne de `exemple.txt`, tu utiliserais :
```bash
sed 's/$/!!/' exemple.txt
```
Cela transformerait chaque "Bonjour le monde" en "Bonjour le monde!!".

### 4. Afficher seulement les lignes contenant un certain texte
Si tu veux afficher uniquement les lignes qui contiennent le mot "monde", tu pourrais utiliser :
```bash
sed -n '/monde/p' exemple.txt
```
Le `-n` dit à `sed` de ne pas afficher les lignes par défaut, et le `p` à la fin de l'expression régulière demande à `sed` d'imprimer les lignes qui correspondent à l'expression `/monde/`.

### 5. Changer une ligne entière si elle contient un certain mot
Si tu veux remplacer une ligne entière par "Salut tout le monde!" si elle contient le mot "Bonjour", la commande serait :
```bash
sed '/Bonjour/c\Salut tout le monde!' exemple.txt
```
Chaque ligne contenant "Bonjour" sera complètement remplacée par "Salut tout le monde!".

### 6. Insérer du texte après une ligne spécifique
Pour insérer "Comment ça va?" après la première ligne de `exemple.txt`, tu peux faire :
```bash
sed '1a\Comment ça va?' exemple.txt
```
Cela ajoutera "Comment ça va?" après la première ligne du fichier.

Ces exemples couvrent des utilisations de base de `sed` pour le traitement de texte. Avec `sed`, tu peux effectuer des modifications très spécifiques sur des fichiers textes de manière automatique, ce qui est extrêmement utile pour le scripting et l'automatisation des tâches sur les systèmes Unix et Linux.
