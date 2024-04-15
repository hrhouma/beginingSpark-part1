```sh
sh (glisser le script1)
hive -f (glisser le script 2)
hive
show tables
 ```

## Les requêtes sont dans script3.sql 


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

# 4 - Autres exemples simples de la commande sed : 

 - Voici une liste des directives couramment utilisées dans `sed` avec des exemples pour chacune.
 - Ces commandes permettent d'effectuer diverses opérations de manipulation de texte directement depuis la ligne de commande.

### 1. Substitution (`s`)
- **Description** : Remplace le premier ou tous les occurrences d'un motif trouvé dans chaque ligne.
- **Syntaxe** : `s/motif/remplacement/flags`
- **Exemple** :
  ```bash
  sed 's/chat/chien/' fichier.txt  # Remplace la première occurrence de "chat" par "chien" dans chaque ligne
  sed 's/chat/chien/g' fichier.txt # Remplace toutes les occurrences de "chat" par "chien" dans chaque ligne
  ```

### 2. Append (`a`)
- **Description** : Ajoute du texte après une ligne spécifiée.
- **Syntaxe** : `numLigne a\texte`
- **Exemple** :
  ```bash
  sed '2a\Ceci est ajouté après la ligne 2.' fichier.txt
  ```

### 3. Insert (`i`)
- **Description** : Insère du texte avant une ligne spécifiée.
- **Syntaxe** : `numLigne i\texte`
- **Exemple** :
  ```bash
  sed '3i\Ceci est inséré avant la ligne 3.' fichier.txt
  ```

### 4. Delete (`d`)
- **Description** : Supprime des lignes spécifiées.
- **Syntaxe** : `/motif/d`
- **Exemple** :
  ```bash
  sed '/inutile/d' fichier.txt  # Supprime toutes les lignes contenant le mot "inutile"
  ```

### 5. Print (`p`)
- **Description** : Imprime les lignes spécifiées à l'écran, utilisé souvent avec l'option `-n`.
- **Syntaxe** : `/motif/p`
- **Exemple** :
  ```bash
  sed -n '/important/p' fichier.txt  # Affiche les lignes contenant le mot "important"
  ```

### 6. Change (`c`)
- **Description** : Remplace la ligne entière par un nouveau texte si elle correspond à un motif donné.
- **Syntaxe** : `/motif/c\texte`
- **Exemple** :
  ```bash
  sed '/obsolète/c\Cette ligne remplace l\'ancienne ligne obsolète.' fichier.txt
  ```

### 7. Transform (`y`)
- **Description** : Remplace tous les caractères d'un ensemble par ceux d'un autre ensemble.
- **Syntaxe** : `y/ensemble1/ensemble2/`
- **Exemple** :
  ```bash
  sed 'y/abc/123/' fichier.txt  # Transforme 'a' en '1', 'b' en '2', 'c' en '3' sur chaque ligne
  ```

### 8. Next (`n`)
- **Description** : Permet à `sed` de passer à la ligne suivante de l'entrée.
- **Syntaxe** : `n`
- **Exemple** :
  ```bash
  sed '/^$/n; s/^/Début de ligne: /' fichier.txt  # Ne fait rien pour les lignes vides et ajoute "Début de ligne: " au début des autres lignes
  ```

### 9. Quit (`q`)
- **Description** : Quitte `sed` après avoir traité les lignes spécifiées.
- **Syntaxe** : `numLigne q`
- **Exemple** :
  ```bash
  sed '10 q' fichier.txt  # Traite jusqu'à la ligne 10 puis quitte
  ```

Ces commandes offrent une flexibilité énorme pour éditer des fichiers en batch ou en flux continu, rendant `sed` un outil indispensable pour le scripting sous Unix/Linux.


# 5 - Liste des directives de `sed` : 
Voici une liste des directives de `sed` :

- **Substitution** : `s/motif/remplacement/flags`
- **Append** : `numLigne a\texte`
- **Insert** : `numLigne i\texte`
- **Delete** : `/motif/d`
- **Print** : `/motif/p`
- **Change** : `/motif/c\texte`
- **Transform** : `y/ensemble1/ensemble2/`
- **Next** : `n`
- **Quit** : `numLigne q`
- **Edit** : `e` (utilise l'éditeur de texte pour modifier une ligne)
- **List** : `l` (imprime les lignes de manière non ambiguë)
- **Read** : `r fichier` (lit le contenu d'un fichier)
- **Write** : `w fichier` (écrit dans un fichier)
- **Exchange** : `x` (échange les tampons de pattern et de holding)
- **Hold** : `h` (copie le pattern space dans le holding space)
- **Get** : `g` (copie le holding space dans le pattern space)
- **Multi-line Append** : `N` (ajoute la ligne suivante au pattern space)
- **Multi-line Print** : `P` (imprime jusqu'au premier retour à la ligne du pattern space)
- **Multi-line Delete** : `D` (supprime jusqu'au premier retour à la ligne du pattern space)

Chacune de ces commandes peut être utilisée pour effectuer des manipulations spécifiques sur le texte dans un fichier ou un flux de données.

# 6 - Explication du script 2 : 
Le script 2 est utilisé pour configurer et manipuler des tables dans Hive, un système de gestion de bases de données distribuées qui fait partie de l'écosystème Hadoop. Il inclut des opérations telles que la suppression de tables existantes, la création de nouvelles tables externes et la manipulation de types de données pour l'analyse. Voici une explication étape par étape du script :

### Configuration initiale
- `SET hive.execution.engine=tez;` : Configure Hive pour utiliser Tez comme moteur d'exécution, qui est optimisé pour une meilleure performance par rapport au moteur d'exécution MapReduce par défaut.

### Suppression des tables existantes
- `drop table if exists [table_name];` : Supprime les tables si elles existent déjà pour éviter des conflits lors de la recréation de celles-ci. Ceci est fait pour plusieurs tables catégorisées en trois ensembles de données : 100k, million, et latest.

### Création de tables externes
- **Tables 100k, million, et latest** : Chaque bloc de création de tables définie les colonnes et les types de données spécifiques, ainsi que la configuration de la délimitation des champs et des lignes. Ces tables sont déclarées comme externes, ce qui signifie que Hive ne gère pas les données elles-mêmes ; elles restent à l'emplacement spécifié dans HDFS (Hadoop Distributed File System).

  - **Exemple de déclaration pour `100k_data`**:
    ```sql
    create external table 100k_data (
      user_id int,
      item_id int,
      rating double,
      rating_time bigint)
    row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
    location '/user/cloudera/hackerday_ratings/100k/data';
    ```
    Cette table utilise des tabulations pour séparer les champs et des retours à la ligne pour séparer les enregistrements.

### Utilisation de SERDE pour la lecture des fichiers CSV
- **Tables latest avec SERDE** : Certaines tables utilisent un SERDE spécifique (`OpenCSVSerde`) pour interpréter correctement les fichiers CSV. SERDE est un moyen de spécifier comment Hive doit interpréter les données lors de la lecture et de l'écriture. Cela inclut la gestion des caractères spéciaux comme les guillemets et les virgules dans les données.

  - **Exemple pour `latest_ratings_serde`**:
    ```sql
    create external table latest_ratings_serde(
      user_id string,
      movie_id string,
      rating string,
      rating_time string)
    ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
    WITH SERDEPROPERTIES(
      "separatorChar"= ",",
      "quoteChar" = "\"")
    location '/user/cloudera/hackerday_ratings/latest/ratings'
    TBLPROPERTIES ("skip.header.line.count" = "1");
    ```
    Cette table ignore également la première ligne des fichiers, supposée être des en-têtes.

### Recréation de tables pour l'analyse
- **Conversion des types de données** : Après la création des tables avec des types de données de chaîne, le script les recrée en convertissant les types de données en formats plus appropriés pour l'analyse (comme `int`, `double`, etc.).

  - **Exemple pour `latest_ratings`**:
    ```sql
    drop table if exists latest_ratings;
    create table latest_ratings as 
    select cast (user_id as int) user_id, 
           cast (movie_id as int) movie_id, 
           cast (rating as double) rating,  
           cast (rating_time as bigint) rating_time
    from latest_ratings_serde;
    ```

Ce script est conçu pour une configuration initiale ou une mise à jour périodique d'une base de données Hive pour des systèmes de recommandation de films, en assurant que les structures de données sont propres, à jour, et prêtes pour des requêtes d'analyse.


# 7 - Pourquoi créer d'abord des tables SERDE externes ?

- Vous vous interrogez probablement sur le processus spécifique qui consiste à créer des tables externes SERDE, puis à recréer des tables internes à partir de ces tables SERDE dans le script 2 ??? 
- C'est effectivement une excellente question qui soulève un aspect important de la gestion des données dans les environnements de big data comme Hive.

### Pourquoi créer d'abord des tables SERDE externes ?

1. **Accès initial aux données** : Les tables externes SERDE sont d'abord créées pour traiter efficacement les données brutes stockées dans des fichiers CSV dans HDFS. L'utilisation de SERDE (`OpenCSVSerde` dans ce cas) permet de gérer correctement les complexités des fichiers CSV, telles que les guillemets, les virgules dans les données, et les lignes d'en-tête. Ces tables servent de point d'entrée initial pour les données non transformées.

2. **Flexibilité** : Les tables externes permettent aux données de rester à leur emplacement d'origine sur HDFS. Cela signifie que Hive ne déplace pas ni ne copie les données, mais lit les données directement à partir de leur emplacement source. Cela est utile lorsque les données sont également utilisées ou gérées par d'autres systèmes en dehors de Hive.

### Pourquoi ensuite créer des tables internes ?

1. **Transformation et nettoyage** : Après avoir chargé les données brutes via les tables externes SERDE, le script procède à la création de nouvelles tables internes. Cela est fait pour plusieurs raisons :
   - **Conversion de type** : Convertir les données de types génériques (`string`) à des types plus spécifiques (`int`, `double`, etc.) qui sont nécessaires pour les opérations analytiques et les performances optimales des requêtes.
   - **Nettoyage** : Supprimer les en-têtes de fichiers, les guillemets, et autres artefacts des données CSV qui ne sont pas nécessaires pour l'analyse.

2. **Optimisation** : Les tables internes permettent à Hive de mieux gérer et optimiser les données pour les requêtes, car Hive contrôle le format et la structure de stockage. Ceci est essentiel pour améliorer la performance des requêtes, en particulier avec de grands volumes de données.

3. **Gestion des données** : En créant des tables internes, Hive peut gérer le cycle de vie des données, y compris la suppression des données lorsque la table est supprimée. Cela aide à maintenir un environnement propre et géré, évitant l'accumulation de données obsolètes.

### Résumé de l'utilité de ce processus

En bref, le processus de création de tables externes SERDE suivi par la création de tables internes est une stratégie pour gérer efficacement les données depuis leur format brut jusqu'à un format optimisé pour l'analyse. Ce processus permet de traiter les données initialement dans leur format le plus flexible et universel, puis de les transformer et de les optimiser pour une utilisation spécifique dans Hive, tout en bénéficiant des avantages de performance et de gestion des données offerts par les tables internes.

# 7 - Résumé script 2 : 

- Dans le script 2, il y a deux types principaux de tables utilisées dans Hive : des tables externes et des tables internes.
- La logique derrière leur utilisation ainsi que la sérialisation et le type de données peut sembler complexe, mais je vais vous expliquer cela de manière simplifiée.

### Pourquoi utiliser des tables externes?

**Tables externes** :
- Les tables externes dans Hive sont utilisées quand les données doivent rester à l'emplacement spécifié dans le système de fichiers HDFS (Hadoop Distributed File System) et ne doivent pas être déplacées ni supprimées lorsque la table est supprimée dans Hive. 
- Cela est particulièrement utile pour des données qui sont partagées entre différents systèmes ou pour des données qui sont mises à jour ou gérées en dehors de Hive.
- Un autre avantage est que si vous supprimez la table externe, les données elles-mêmes ne sont pas supprimées, ce qui réduit le risque de perdre des informations importantes.

**Exemple d'utilisation** :
Supposons que vous ayez des fichiers de données qui sont régulièrement mis à jour ou utilisés par plusieurs applications différentes. En les configurant comme des tables externes, vous vous assurez que les manipulations dans Hive n'affectent pas l'intégrité ou l'emplacement des données originales.

### Pourquoi remplacer des tables externes par des tables internes?

**Tables internes (ou gérées)** :
- Les tables internes sont utiles quand Hive doit avoir un contrôle complet sur les données, y compris leur stockage et gestion du cycle de vie. Lorsque vous supprimez une table interne, Hive supprime également les données associées.
- Créer des tables internes à partir de données externes peut être nécessaire pour optimiser les performances des requêtes, pour sécuriser les données ou pour transformer les types de données pour des analyses spécifiques.

**Sérialisation et types de données** :
- La sérialisation dans Hive, notamment à l'aide de SERDE (Serialisation/Deserialisation), permet de spécifier comment Hive lit et écrit les données, en gérant des formats complexes comme CSV, où les virgules, guillemets, et d'autres caractères peuvent compliquer la lecture des fichiers.
- La transformation de types de données (par exemple, de `string` à `int` ou `double`) est souvent nécessaire pour effectuer des calculs mathématiques ou des opérations statistiques, car les opérations sur des chaînes de caractères sont limitées et moins performantes.

**Exemple de transformation** :
Après avoir importé des données avec des types génériques comme des chaînes de caractères (pour assurer qu'aucune donnée n'est mal interprétée à l'importation), vous pourriez vouloir créer des tables internes où les colonnes sont castées en types spécifiques pour faciliter les analyses, comme des calculs de moyennes ou des jointures entre tables.

### Résumé de l'utilité
En combinant l'utilisation de tables externes et internes, ainsi que la sérialisation appropriée et la gestion des types de données, vous pouvez :
1. Assurer que les données sont gérées de façon sûre et efficace.
2. Optimiser les performances des requêtes en Hive.
3. Préparer les données pour des analyses complexes en convertissant les types de données de manière à ce qu'ils soient utilisables pour des requêtes SQL complexes.

Ce processus rend les données plus flexibles et puissantes pour le traitement et l'analyse dans des environnements de big data comme Hadoop.

# 7 - Créer des tables externes : est-ce une bonne idée ?

- Créer directement des tables externes plutôt que des tables internes (gérées) dans Hive peut sembler une bonne idée dans certaines situations, notamment pour la flexibilité et la gestion des données qu'elles offrent. 
- Cependant, il y a plusieurs raisons pour lesquelles vous pourriez choisir de créer des tables internes ou de convertir des tables externes en tables internes dans certains cas. Voici quelques considérations clés :

### 1. **Contrôle des données**
- **Tables internes** : Hive gère le stockage des données. Lorsque vous supprimez une table interne, Hive supprime aussi les fichiers de données correspondants dans HDFS. Cela peut être utile pour garantir que les données ne sont pas laissées inutilisées sur le disque après qu'elles ne sont plus nécessaires.
- **Tables externes** : Les données restent sur HDFS même après la suppression de la table. Cela peut entraîner une gestion des données moins rigoureuse, avec des fichiers non nécessaires qui occupent de l'espace disque.

### 2. **Sécurité des données**
- L'utilisation de tables internes peut offrir un niveau de sécurité accru puisque la gestion des données est plus strictement contrôlée par Hive. Les permissions sur les fichiers de données peuvent être plus facilement gérées par les outils de Hive.

### 3. **Performance**
- **Optimisation** : Hive peut optimiser le stockage et l'accès aux données pour les tables internes, car il gère le format de stockage et les métadonnées. Pour les tables externes, Hive ne peut pas appliquer certaines optimisations car il doit respecter l'intégrité du format et de l'emplacement des données externes.
- **Format de stockage** : Les tables internes permettent l'utilisation de formats de fichiers optimisés comme ORC ou Parquet, qui sont très efficaces pour les grandes analyses de données avec Hive.

### 4. **Opérations de transformation de données**
- Il est souvent nécessaire de transformer les données (changement de type de données, formatage, etc.) après leur chargement initial dans Hive. Créer des tables internes à partir des tables externes permet de réaliser ces transformations et de stocker les résultats de manière optimisée pour les requêtes futures.

### 5. **Cohérence des données**
- Avec des tables internes, il est plus facile de maintenir la cohérence des données, surtout dans des environnements où les schémas et les données évoluent rapidement. Les tables internes assurent que les modifications de schéma sont bien propagées et que les données sont stockées conformément à ces modifications.

### Résumé
- Le choix entre créer directement des tables externes ou internes dépend donc de plusieurs facteurs tels que la manière dont vous souhaitez gérer vos données, les exigences de performance de vos requêtes, les besoins en sécurité et en gestion des données, ainsi que la complexité des opérations de transformation de données.
- Les tables externes offrent une grande flexibilité et sont idéales pour des situations où les données sont gérées en dehors de Hive, tandis que les tables internes sont préférables pour une gestion et une optimisation complètes par Hive.

# 8 - script 3 ?

- Le script SQL (script #3) vise à extraire des informations spécifiques sur les évaluations des films à partir d'une base de données, en utilisant plusieurs requêtes différentes pour répondre à des questions variées. 
- Voici une explication des requêtes avec quelques exemples :

1) **Année avec le plus grand nombre d'évaluations** :
   Cette requête identifie l'année pendant laquelle le plus grand nombre d'évaluations de films a été enregistré. Elle convertit les timestamps de l'évaluation (`rating_time`) en années, compte le nombre d'évaluations pour chaque année, et trie les résultats par année en ordre décroissant. Selon les données, 2016 est l'année avec le plus grand nombre d'évaluations (2,077,152 évaluations).

2) **Film le mieux noté de chaque année** :
   Cette requête calcule la note moyenne de chaque film pour chaque année, en s'assurant que chaque utilisateur est compté une seule fois par film et année. Elle joint ensuite ces résultats avec une table des films pour récupérer les noms des films, et utilise la fonction de classement pour sélectionner le film ayant la note moyenne la plus élevée par année. Par exemple, en 2017, le documentaire "Planet Earth (2006)" a eu la meilleure note moyenne.

3) **Chaque année ayant un film qui a le maximum d'utilisateurs** :
   Cette requête est utilisée pour identifier les films qui ont attiré le plus grand nombre d'utilisateurs distincts dans chaque année. Elle crée une table temporaire où chaque film est lié à l'année où il a eu le plus grand nombre d'utilisateurs.

4) **Jointure de la table avec le maximum d'utilisateurs par année avec les films les mieux notés de chaque année** :
   Cette requête combine les informations des requêtes précédentes pour identifier les films qui non seulement ont eu la meilleure note moyenne chaque année mais aussi le plus grand nombre d'utilisateurs cette même année. Elle permet d'obtenir une vue plus complète de l'impact et de la popularité des films au fil du temps.

5) **Film qui a été évalué 50% de plus après 5 ans de sa sortie** :
   Cette requête complexe identifie les films dont le nombre d'évaluations a augmenté de plus de 50% après cinq ans de leur sortie initiale. Elle nécessite une manipulation précise des dates de sortie des films et des années d'évaluation pour calculer correctement l'augmentation en pourcentage des évaluations. 

Ces requêtes sont des exemples de la manière dont on peut analyser des données complexes de manière efficace à l'aide du SQL pour fournir des insights précieux sur les tendances des évaluations de films au fil des années.
