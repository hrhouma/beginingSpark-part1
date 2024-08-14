#### 1. Exécution d'un script Python externe

```python
%run /Shared/MovieRecommendation/Authorization.py 
```

- **`%run`** : C'est une commande magique dans Databricks utilisée pour exécuter un script Python externe dans le contexte du notebook actuel. Cela signifie que tout code ou toute variable définie dans ce script externe sera disponible dans le notebook.
- **`/Shared/MovieRecommendation/Authorization.py`** : Il s'agit du chemin du script Python qui est exécuté. Ce script pourrait contenir des fonctions, des classes, ou des variables qui seront utilisées plus tard dans le notebook.

---

#### 2. Commande pour réexécuter un script

```python
# Databricks notebook source
# DBTITLE 1,Cmd1
# MAGIC %run /MovieRecommendation/Authorization
```

- **`# MAGIC`** : Ceci indique que la ligne qui suit est une commande magique. Dans ce cas, elle est utilisée pour exécuter un autre script externe nommé `Authorization`.
- **`DBTITLE 1,Cmd1`** : Cette ligne sert uniquement à titre indicatif pour afficher un titre dans le notebook.

---

#### 3. Lecture d'un fichier CSV dans Spark

```python
# File location and type
file_location = "abfss://containermovieliu@saprojetmovieliu.dfs.core.windows.net/links.csv"
file_type = "csv" # Définir des variables
# CSV options
infer_schema = "true"
first_row_is_header = "true"
delimiter = ","
# The applied options are for CSV files. For other file types, these will be ignored.
# lire le fichier
df_movies = spark.read.format(file_type) \
      .option("inferSchema", infer_schema) \
      .option("header", first_row_is_header) \
      .option("sep", delimiter) \
      .load(file_location)
    
display(df_movies) # Afficher le fichier
```

- **`file_location`** : C'est une variable qui stocke l'emplacement du fichier CSV dans Azure Data Lake Storage (ADLS). Le chemin commence par `abfss://`, indiquant l'accès sécurisé aux données dans ADLS.
- **`file_type`** : Type de fichier à lire, ici `csv` signifie qu'il s'agit d'un fichier de valeurs séparées par des virgules.
- **`infer_schema`** : Option qui, lorsqu'elle est définie sur `true`, permet à Spark de déduire automatiquement le type de données des colonnes dans le CSV.
- **`first_row_is_header`** : Cette option indique que la première ligne du CSV contient les noms des colonnes.
- **`delimiter`** : Spécifie le caractère utilisé pour séparer les valeurs dans le fichier CSV, ici une virgule.
- **`spark.read.format(file_type)`** : Indique à Spark quel format de fichier lire.
- **`option("inferSchema", infer_schema)`** : Applique l'option d'inférence de schéma définie précédemment.
- **`load(file_location)`** : Charge le fichier à partir de l'emplacement spécifié.
- **`display(df_movies)`** : Affiche le DataFrame `df_movies` dans le notebook pour visualiser les données.

---

#### 4. Importation de bibliothèques et modules Python

```python
# Importer des bibliothèques et des modules Python
import datetime # Importer Module datetime qui contient des fonctions de traitement des dates et des heures
import pyspark.sql.functions as f # Importer le module de fonctions de la bibliothèque PySpark et nommer f
import pyspark.sql.types # Importer le module types de la bibliothèque PySpark, qui contient les définitions des types de données supportés par PySpark
import pandas as pd # Importer la bibliothèque pandas de Python et nommez-la pd
```

- **`import datetime`** : Ce module Python permet de manipuler des dates et des heures.
- **`import pyspark.sql.functions as f`** : Importe le module de fonctions de PySpark, un outil de traitement de données distribué, et le renomme en `f` pour simplifier l'utilisation.
- **`import pyspark.sql.types`** : Ce module contient les types de données que PySpark peut manipuler, tels que `IntegerType`, `StringType`, etc.
- **`import pandas as pd`** : Importe la bibliothèque `pandas`, couramment utilisée pour l'analyse de données, et la renomme en `pd`.

---

#### 5. Lecture et affichage d'un autre fichier CSV

```python
# Lire fichier movies.csv, attribuer-le à la variable df_movies et affichez-le.
# DBTITLE 1,Cmd5
file_location = "abfss://containermovieliu@saprojetmovieliu.dfs.core.windows.net/movies.csv"
file_type = "csv"
# CSV options
infer_schema = "true"
first_row_is_header = "true"
delimiter = ","

df_movies = spark.read.format(file_type) \
      .option("inferSchema", infer_schema) \
      .option("header", first_row_is_header) \
      .option("sep", delimiter) \
      .load(file_location)
    
display(df_movies)
```

- **`file_location`, `file_type`, etc.** : Les mêmes explications s'appliquent ici que précédemment, sauf que le fichier cible est `movies.csv` au lieu de `links.csv`.

---

#### 6. Conversion en vue temporaire

```python
# Convertir le DataFrame df_movies en une vue temporaire nommer "movies_csv"
temp_table_name = "movies_csv"
df_movies.createOrReplaceTempView(temp_table_name)
```

- **`createOrReplaceTempView`** : Cette méthode permet de créer une vue temporaire à partir du DataFrame, qui peut être utilisée pour exécuter des requêtes SQL sur les données.
- **`temp_table_name`** : Le nom de la vue temporaire, ici `movies_csv`.

---

#### 7. Installation et activation de paquets

```python
# !pip install ipython-sql # Installer le package Python ipython-sql
```

- **`!pip install ipython-sql`** : Cette commande shell installe le package `ipython-sql`, qui permet l'intégration de SQL dans les notebooks IPython.
  
```python
# %load_ext sql # Commande magique pour charger et activer l'extension SQL IPython
```

- **`%load_ext sql`** : Active l'extension SQL pour permettre l'exécution de commandes SQL directement dans le notebook.

---

#### 8. Exécution de requêtes SQL

```python
# %sql # Exécuter des requêtes SQL dans Jupyter Notebook
# select * from movies_csv  # Sélectionner toutes les données dans le tableau "movies_csv"
```

- **`%sql`** : Cette commande magique permet d'exécuter du code SQL dans le notebook. 
- **`select * from movies_csv`** : Sélectionne toutes les colonnes et lignes de la vue temporaire `movies_csv`.

---

#### 9. Création d'une variable pour stocker le nom d'une table

```python
# Créer une variable nommée permanent_table_name et lui ai attribué la chaîne "movies_csv"
permanent_table_name = "movies_csv"
```

- **`permanent_table_name`** : Une variable Python qui stocke le nom d'une table permanente (ici `movies_csv`).

---

#### 10. Lecture et affichage de fichiers CSV supplémentaires

```python
# Lire fichier links.csv, attribuer-le à la variable df_links et affichez-le.
links="abfss://containermovieliu@saprojetmovieliu.dfs.core.windows.net/links.csv"
df_links = spark.read.format(file_type) \
    .option("inferShema", infer_schema) \
    .option("header", first_row_is_header) \
    .option("sep", delimiter) \
    .load(links)

display(df_links)
```

- **`links="..."`** : Variable qui contient le chemin du fichier `links.csv`.
- **`df_links = spark.read.format(file_type)`** : Même processus de lecture de fichier que précédemment.
  
```python
# Lire fichier tags.csv, attribuer-le à la variable df_tags et affichez-le.
tags = "abfss://containermovieliu@saprojetmovieliu.dfs.core.windows.net/tags.csv"
df_tags = spark.read.format(file_type) \
    .option("inferShema", infer_schema) \
    .option("header", first_row_is_header) \
    .option("sep", delimiter) \
    .load(tags)

display(df_tags)
```

- **`tags="..."`** : Variable qui contient le chemin du fichier `tags.csv`.
- **`df_tags = spark.read.format(file_type)`** : Même processus de lecture de fichier que précédemment.

--------








#### 11. Lecture et affichage du fichier `ratings.csv`

```python
# COMMAND ----------
# DBTITLE 1,Cmd11
# Lire fichier ratings.csv, attribuer-le à la variable df_ratings et affichez-le.
ratings = "abfss://containermovieliu@saprojetmovieliu.dfs.core.windows.net/ratings.csv"
df_ratings = spark.read.format(file_type) \
    .option("inferShema", infer_schema) \
    .option("header", first_row_is_header) \
    .option("sep", delimiter) \
    .load(ratings)

display(df_ratings)
```

- **`ratings`** : Cette variable stocke l'emplacement du fichier `ratings.csv` dans Azure Data Lake Storage (ADLS). Le chemin commence par `abfss://`, ce qui signifie qu'il utilise le protocole Azure Blob File System sécurisé pour accéder aux données dans ADLS.
  
- **`spark.read.format(file_type)`** : Cela initialise le processus de lecture du fichier en spécifiant le format de fichier (ici, `csv`).

- **`option("inferSchema", infer_schema)`** : Active l'inférence automatique du schéma des colonnes, ce qui signifie que Spark déduira les types de données des colonnes dans le fichier CSV.

- **`option("header", first_row_is_header)`** : Indique que la première ligne du fichier CSV contient les noms des colonnes, ce qui permet de structurer les données de manière compréhensible.

- **`option("sep", delimiter)`** : Définit le séparateur des valeurs dans le fichier CSV, ici une virgule (`,`).

- **`load(ratings)`** : Charge le fichier à partir de l'emplacement spécifié (`ratings`).

- **`display(df_ratings)`** : Affiche le contenu du DataFrame `df_ratings`, qui contient les données lues depuis le fichier `ratings.csv`.

---

#### 12. Affichage du nombre de lignes et du contenu du DataFrame `df_movies`

```python
# COMMAND ----------
# DBTITLE 1,Cmd12
# Afficher le nombre de lignes dans le PySpark DataFrame df_movies et afficher le contenu du DataFrame
#count of records
print(df_movies.count())
display(df_movies)
```

- **`df_movies.count()`** : Cette commande compte le nombre total de lignes (enregistrements) dans le DataFrame `df_movies`. Cela est utile pour comprendre la taille du dataset.

- **`display(df_movies)`** : Affiche à nouveau le contenu du DataFrame `df_movies` pour voir les données après avoir compté les enregistrements.

---

#### 13. Fusion par jointure à gauche de `df_movies` et `df_ratings`

```python
# COMMAND ----------
# DBTITLE 1,Cmd13
# Left join df_movies et df_ratings en fonction de la colonne commune "movieID" , et créer un nouveau DataFrame df_movies_with_ratings qui contient les données des deux tables d'origine.
df_movies_with_ratings=df_movies.join(df_ratings,'movieID','left')
display(df_movies_with_ratings) # Afficher df_movies_with_ratings
```

- **`df_movies.join(df_ratings,'movieID','left')`** : Effectue une jointure à gauche (`left join`) entre les DataFrames `df_movies` et `df_ratings` sur la colonne commune `movieID`. Une jointure à gauche inclut toutes les lignes de `df_movies` et les lignes correspondantes de `df_ratings`, s'il y en a. Si aucun enregistrement correspondant n'est trouvé dans `df_ratings`, Spark remplit ces lignes avec des valeurs nulles.

- **`df_movies_with_ratings`** : C'est le nouveau DataFrame créé à la suite de cette jointure, contenant des données des deux DataFrames d'origine.

- **`display(df_movies_with_ratings)`** : Affiche le DataFrame résultant pour visualiser les données après la jointure.

---

#### 14. Groupement et comptage des occurrences dans `df_movies_with_ratings`

```python
# COMMAND ----------
# DBTITLE 1,Cmd14
# Regrouper le DataFrame df_movies_with_ratings par la colonne 'movieId', puis compter les occurrences de chaque regroupement (chaque film), créer un nouveau DataFrame df_movies_no_dups qui contient les données.
df_movies_no_dups = df_movies_with_ratings.groupby('movieId').count()
display(df_movies_no_dups) # Afficher df_movies_no_dups
```

- **`df_movies_with_ratings.groupby('movieId').count()`** : Regroupe les enregistrements du DataFrame `df_movies_with_ratings` par `movieId` et compte le nombre d'occurrences pour chaque `movieId`. Cela permet d'obtenir le nombre de fois où chaque film apparaît dans les données.

- **`df_movies_no_dups`** : Nouveau DataFrame résultant de l'opération de groupement et de comptage. Le nom `no_dups` suggère que ce DataFrame ne contient plus de doublons, car les films sont regroupés par `movieId`.

- **`display(df_movies_no_dups)`** : Affiche le DataFrame résultant pour examiner les regroupements et les comptages.

---

#### 15. Fusion par jointure interne de `df_movies_with_ratings` et `df_tags`

```python
# COMMAND ----------
# DBTITLE 1,Cmd15
# Inner join df_movies_with_ratings et df_tags en fonction de la colonne commune "movieID" , et créer un nouveau DataFrame df_movies_with_ratings qui contient les données.
df_movies_with_ratings=df_movies_with_ratings.join(df_tags,['movieId'], 'inner')
display(df_movies_with_ratings) # Afficher les données
```

- **`df_movies_with_ratings.join(df_tags,['movieId'], 'inner')`** : Réalise une jointure interne (`inner join`) entre `df_movies_with_ratings` et `df_tags` sur la colonne commune `movieId`. Une jointure interne ne garde que les lignes pour lesquelles il y a des correspondances dans les deux DataFrames. Cela élimine les films pour lesquels il n'y a pas de tags.

- **`df_movies_with_ratings`** : Ce DataFrame est mis à jour pour inclure les données des tags après la jointure interne.

- **`display(df_movies_with_ratings)`** : Affiche les données fusionnées pour visualiser le résultat de la jointure interne.

---

#### 16. Fusion par jointure interne de `df_ratings` et `df_tags`

```python
# COMMAND ----------
# DBTITLE 1,Cmd16
# Inner join df_ratings et df_tags en fonction de la colonne commune "movieID" , et créer un nouveau DataFrame df_ratings_tags qui contient les données.
df_ratings_tags=df_ratings.join(df_tags,['movieId'], 'inner')
display(df_ratings_tags) # Afficher les données.
```

- **`df_ratings.join(df_tags,['movieId'], 'inner')`** : Réalise une jointure interne entre `df_ratings` et `df_tags` sur la colonne commune `movieId`. Cela crée un DataFrame qui ne contient que les films pour lesquels il y a des données de rating et des tags.

- **`df_ratings_tags`** : Nouveau DataFrame qui contient les données issues de cette jointure.

- **`display(df_ratings_tags)`** : Affiche les données du DataFrame résultant pour observer les informations combinées des ratings et des tags.

---

#### 17. Affichage simple de `df_ratings`

```python
# COMMAND ----------
# DBTITLE 1,Cmd17
display(df_ratings) # Afficher df_ratings
```

- **`display(df_ratings)`** : Réaffiche simplement le contenu du DataFrame `df_ratings` pour s'assurer que les données sont toujours correctes après les précédentes opérations.

---

#### 18. Vérification du format des colonnes dans `df_ratings`

```python
# COMMAND ----------
# DBTITLE 1,Cmd18
df_ratings # Afficher le format de chaque colonne
```

- **`df_ratings`** : Cette commande affiche les premières lignes du DataFrame ainsi que les noms et types des colonnes, ce qui est utile pour vérifier le format des données.

---

#### 19. Ajout d'une colonne `tsDate` dans `df_ratings`

```python
# COMMAND ----------
# DBTITLE 1,Cmd19
# Créer une nouvelle colonne « tsDate » et ajouter-la au df_ratings. La valeur de la nouvelle colonne est une valeur datetime convertie à partir de l'horodatage UNIX en secondes dans la colonne "timestamp".
df_ratings=df_ratings.withColumn("tsDate",f.from_unixtime("timestamp"))
```

- **`df_ratings.withColumn("tsDate",f.from_unixtime("timestamp"))`** : Ajoute une nouvelle colonne nommée `tsDate` au DataFrame `df_ratings`. La valeur de cette colonne est obtenue en convertissant la valeur de l'horodatage UNIX (stockée dans la colonne `timestamp`) en une date et heure au format lisible (datetime). `from_unixtime` est une fonction de PySpark qui effectue cette conversion.

- **`df_ratings`** : Le DataFrame est mis à jour pour inclure cette

 nouvelle colonne `tsDate`.

---

#### 20. Affichage final du DataFrame `df_ratings`

```python
# COMMAND ----------
# DBTITLE 1,Cmd20
display(df_ratings) # Afficher df_ratings
```

- **`display(df_ratings)`** : Affiche le DataFrame `df_ratings` mis à jour, incluant la nouvelle colonne `tsDate` pour visualiser les données finales.

---






#### 21. Sélectionner et formater les colonnes dans `df_ratings`

```python
# COMMAND ----------
# DBTITLE 1,Cmd21
# Sélectionner les colonnes 'userId', 'movieId', 'rating' et convertisser le format d'heure pour créer une nouvelle colonne 'rating_date'.
df_ratings=df_ratings.select('userId', 'movieId', 'rating',f.to_date(unix_timestamp('tsDate', 'yyyy-MM-dd HH:MM:SS').cast('timestamp')).alias('rating_date'))
```

- **`df_ratings.select(...)`** : Cette commande sélectionne les colonnes spécifiées du DataFrame `df_ratings`. Ici, les colonnes `userId`, `movieId`, et `rating` sont sélectionnées.

- **`unix_timestamp('tsDate', 'yyyy-MM-dd HH:MM:SS')`** : Cette fonction convertit la date et l'heure au format `yyyy-MM-dd HH:MM:SS` en un horodatage UNIX. Cela signifie qu'elle prend une chaîne de caractères représentant une date/heure et la transforme en un format numérique.

- **`cast('timestamp')`** : Convertit l'horodatage UNIX en un type de donnée `timestamp` reconnu par PySpark.

- **`f.to_date(...)`** : Convertit le `timestamp` en une date (`yyyy-MM-dd`) sans les informations sur l'heure.

- **`alias('rating_date')`** : Donne un nom à la nouvelle colonne créée, ici `rating_date`.

- **`df_ratings`** : Le DataFrame est mis à jour pour inclure uniquement les colonnes sélectionnées et la nouvelle colonne `rating_date`.

---

#### 22. Affichage du DataFrame `df_ratings`

```python
# COMMAND ----------
# DBTITLE 1,Cmd22
display(df_ratings) # Afficher df_ratings
```

- **`display(df_ratings)`** : Affiche le contenu du DataFrame `df_ratings` pour visualiser les données après la sélection des colonnes et la création de la colonne `rating_date`.

---

#### 23. Calcul de la moyenne des notes par film

```python
# COMMAND ----------
# DBTITLE 1,Cmd23
from pyspark.sql.functions import  mean as mean_; # Importer la fonction moyenne et donner-lui un alias Mean_
df_avg_ratings=df_ratings.groupBy('movieId').agg(mean_('rating')) # Regrouper df_ratings par colonne « movieId » et calculer la moyenne de chaque regroup.
display(df_avg_ratings) # Afficher df_avg_ratings
```

- **`from pyspark.sql.functions import mean as mean_`** : Cette commande importe la fonction `mean` (moyenne) de PySpark et lui donne un alias `mean_` pour simplifier son utilisation.

- **`df_ratings.groupBy('movieId').agg(mean_('rating'))`** : Regroupe les enregistrements de `df_ratings` par `movieId` et calcule la moyenne des notes (`rating`) pour chaque film.

- **`df_avg_ratings`** : Nouveau DataFrame qui contient la moyenne des notes pour chaque film.

- **`display(df_avg_ratings)`** : Affiche le DataFrame `df_avg_ratings` pour visualiser les moyennes des notes.

---

#### 24. Fusion des moyennes avec les détails des films

```python
# COMMAND ----------
# DBTITLE 1,Cmd24
# Inner join df_avg_ratings et df_movies en fonction de la colonne commune "movieID" , et créer un nouveau DataFrame df qui contient les données.
df= df_avg_ratings.join(df_movies,'movieId','inner') 
df= df.withColumnRenamed('avg(rating)','avg_rating') # Nommer la colonne 'avg(rating)' de df comme 'avg_rating'
display(df) # Afficher df
```

- **`df_avg_ratings.join(df_movies,'movieId','inner')`** : Effectue une jointure interne (`inner join`) entre `df_avg_ratings` et `df_movies` sur la colonne `movieId`. Cette jointure combine les moyennes de notes avec les détails des films.

- **`df.withColumnRenamed('avg(rating)','avg_rating')`** : Renomme la colonne `avg(rating)` en `avg_rating` pour une meilleure lisibilité.

- **`df`** : Le DataFrame est mis à jour pour inclure à la fois les détails des films et la moyenne des notes sous le nom `avg_rating`.

- **`display(df)`** : Affiche le DataFrame résultant pour visualiser les données fusionnées.

---

#### 25. Comptage du nombre de notes par film

```python
# COMMAND ----------
# DBTITLE 1,Cmd25
df_total_rating= df_ratings.groupBy('movieID').count() # Regroupez DataFrame df_ratings par colonne 'movieID' et comptez le nombre de lignes pour chaque groupe et créer un nouveau DataFrame df_total_rating qui contient les données.
display (df_total_rating) # Afficher df_total_rating
```

- **`df_ratings.groupBy('movieID').count()`** : Regroupe les enregistrements du DataFrame `df_ratings` par `movieID` et compte le nombre de notes pour chaque film.

- **`df_total_rating`** : Nouveau DataFrame contenant le nombre total de notes pour chaque film.

- **`display(df_total_rating)`** : Affiche le DataFrame `df_total_rating` pour examiner les totaux des notes.

---

#### 26. Filtrage des films avec un nombre minimal de notes

```python
# COMMAND ----------
# DBTITLE 1,Cmd26
df_total_rating = df_total_rating.filter(df_total_rating['count']>5) # Ne conserver que les données de df_total_rating dont le valeur de count supérieure à 5.
df_ratings_filtered = df_ratings.join(df_total_rating,'movieID','inner') # Inner join df_ratings et df_total_rating en fonction de la colonne commune "movieID" , et créer un nouveau DataFrame df_ratings_filtered qui contient les données.
```

- **`df_total_rating.filter(df_total_rating['count']>5)`** : Filtre le DataFrame `df_total_rating` pour ne garder que les films ayant plus de 5 notes. Cela aide à se concentrer sur les films qui ont un nombre suffisant de notes pour être statistiquement significatifs.

- **`df_ratings.join(df_total_rating,'movieID','inner')`** : Effectue une jointure interne entre `df_ratings` et `df_total_rating` sur la colonne `movieID` pour créer un nouveau DataFrame `df_ratings_filtered`, qui contient les notes uniquement pour les films avec plus de 5 évaluations.

---

#### 27. Affichage et comptage des films filtrés

```python
# COMMAND ----------
# DBTITLE 1,Cmd27
display(df_total_rating) # Afficher df_total_rating
print(df_total_rating.count()) # Afficher le nombre de lignes dans le DataFrame df_total_rating
```

- **`display(df_total_rating)`** : Affiche le DataFrame `df_total_rating` filtré pour visualiser les films restants.

- **`print(df_total_rating.count())`** : Affiche le nombre de films ayant plus de 5 notes. Cela permet de vérifier combien de films répondent au critère.

---

#### 28. Calcul de la note maximale par utilisateur et par film

```python
# COMMAND ----------
# DBTITLE 1,Cmd28
from pyspark.sql.functions import  max as max_; # Importer la fonction max dans donner-lui un alias max_
df_rating_per_user= df_ratings_filtered.select('userID','movieID','rating').groupBy('userID','movieID').agg(max_('rating')) # Sélectionner les colonnes 'userID', 'movieID' et 'rating' dans df_ratings_filtered, regrouper les données par les colonnes 'userID' et 'movieID' et calculer la valeur maximale de la colonne 'rating' dans chaque groupe. créer un nouveau DataFrame df_rating_per_user qui contient les données.
df_rating_per_user_movie=df_rating_per_user.join(df_movies,'movieID','inner') # Inner join df_rating_per_user et df_movies en fonction de la colonne commune "movieID" , et créer un nouveau DataFrame df_rating_per_user_movie qui contient les données.
```

- **`from pyspark.sql.functions import max as max_`** : Importe la fonction `max` (maximum) de PySpark et lui donne un alias `max_` pour simplifier son utilisation.

- **`df_ratings_filtered.select(...).groupBy('userID','movieID').agg(max_('rating'))`** : Sélectionne les colonnes `userID`, `movieID`, et `rating` du DataFrame filtré, regroupe les enregistrements par utilisateur et par film, et calcule la note maximale attribuée par chaque utilisateur à chaque film.

- **`df_rating_per_user`** : Nouveau DataFrame qui contient la note maximale par utilisateur et par film.

- **`df_rating_per_user_movie=df_rating_per_user.join(df_movies,'movieID','inner')`** : Effectue une jointure interne entre `df_rating_per_user` et `df_movies` pour combiner les notes maximales avec les

 détails des films.

---

#### 29. Renommage et affichage des notes maximales

```python
# COMMAND ----------
# DBTITLE 1,Cmd29
df_rating_per_user_movie= df_rating_per_user_movie.withColumnRenamed('max(rating)','max_rating') # Nommer la colonne 'max(rating)' de df_rating_per_user_movie comme 'max_rating'
display(df_rating_per_user_movie) # Afficher df_rating_per_user_movie
```

- **`df_rating_per_user_movie.withColumnRenamed('max(rating)','max_rating')`** : Renomme la colonne `max(rating)` en `max_rating` pour une meilleure lisibilité.

- **`display(df_rating_per_user_movie)`** : Affiche le DataFrame `df_rating_per_user_movie` pour visualiser les notes maximales attribuées par les utilisateurs.

---

#### 30. Vérification du format des colonnes

```python
# COMMAND ----------
# DBTITLE 1,Cmd30
df_rating_per_user_movie # Vérifier le format de chaque colonne
```

- **`df_rating_per_user_movie`** : Cette commande permet de vérifier le format des colonnes du DataFrame pour s'assurer que les données sont correctement structurées.

---


#### 31. Conversion du type de donnée de `max_rating` en `float`

```python
# COMMAND ----------
from pyspark.sql.functions import col # Importer fonction col
# Convertir le format de max_rating en float
df_rating_per_user_movie = df_rating_per_user_movie.withColumn("max_rating", col("max_rating").cast("float"))
```

- **`from pyspark.sql.functions import col`** : Cette commande importe la fonction `col` de PySpark, qui permet de faire référence à une colonne dans un DataFrame de manière programmatique.

- **`df_rating_per_user_movie.withColumn("max_rating", col("max_rating").cast("float"))`** : Cette commande transforme le type de données de la colonne `max_rating` en `float`. La méthode `cast("float")` convertit la colonne en un format numérique à virgule flottante, ce qui permet d'effectuer des opérations mathématiques précises sur cette colonne.

- **`df_rating_per_user_movie`** : Le DataFrame est mis à jour pour inclure la colonne `max_rating` avec son nouveau type de donnée.

---

#### 32. Sélection et regroupement des colonnes dans `df_rating_per_user_movie`

```python
# COMMAND ----------
# Cmd 31
# Sélectionner les colonnes « userId », « movieId », « title » et « genres » dans df_rating_per_user_movie, regrouper les données par colonnes « userId », « movieId », « title » et « genres ». calculer la valeur maximale de la colonne 'max_rating' dans chaque groupe. Mettre les données dans df_rating.
df_rating=df_rating_per_user_movie.groupby('userId','movieId','title','genres').max('max_rating')
```

- **`df_rating_per_user_movie.groupby('userId','movieId','title','genres').max('max_rating')`** : Cette commande regroupe les enregistrements dans `df_rating_per_user_movie` en fonction des colonnes `userId`, `movieId`, `title`, et `genres`. Pour chaque groupe, elle calcule la valeur maximale de `max_rating`, ce qui permet d'obtenir la note maximale pour chaque film, par utilisateur et par genre.

- **`df_rating`** : Nouveau DataFrame résultant de ce regroupement, contenant les notes maximales pour chaque film par utilisateur et par genre.

---

#### 33. Affichage de `df_rating`

```python
# COMMAND ----------
# Cmd 32
display(df_rating) # Afficher df_rating
```

- **`display(df_rating)`** : Affiche le contenu du DataFrame `df_rating` pour visualiser les données après le regroupement et le calcul des notes maximales.

---

#### 34. Filtrage des films avec une note supérieure ou égale à 4

```python
# COMMAND ----------
# Cmd 33
#users with movies with > 4 ratings
df_rating=df_rating.withColumnRenamed('max(max_rating)','max_rating') # Nommer la colonne 'max(max_rating)' de df_rating comme 'max_rating'
df_rating=df_rating.filter(df_rating['max_rating']>=4) # Ne conserver que les données de df_rating dont la valeur de 'max_rating' est supérieure ou égale à 4.
display(df_rating) # Afficher df_rating
```

- **`df_rating.withColumnRenamed('max(max_rating)','max_rating')`** : Renomme la colonne `max(max_rating)` en `max_rating` pour simplifier sa référence.

- **`df_rating.filter(df_rating['max_rating']>=4)`** : Filtre le DataFrame pour ne conserver que les films ayant une note maximale supérieure ou égale à 4. Cela permet de se concentrer sur les films bien notés.

- **`display(df_rating)`** : Affiche le DataFrame `df_rating` filtré pour visualiser les films ayant une note supérieure ou égale à 4.

---

#### 35. Identification des meilleurs films par genre

```python
# COMMAND ----------
#Comd 34
#Identify best movies per genre
df_movies_per_genre=df_rating.groupby('genres','title').count() # Sélectionner les colonnes « genres » et « titre » dans df_rating, regrouper les données par colonnes « genres » et « titre », calculer le nombre de lignes pour chaque groupe. Mettre les données dans df_movies_per_genre.
display(df_movies_per_genre) # Afficher df_movies_per_genre
```

- **`df_rating.groupby('genres','title').count()`** : Cette commande regroupe les enregistrements de `df_rating` par genre et titre de film, puis calcule le nombre de films dans chaque groupe. Cela permet d'identifier les films les plus représentés dans chaque genre.

- **`df_movies_per_genre`** : Nouveau DataFrame contenant les films regroupés par genre et titre, avec un décompte du nombre de fois où chaque film apparaît.

- **`display(df_movies_per_genre)`** : Affiche le DataFrame `df_movies_per_genre` pour visualiser les films les plus représentés par genre.

---

#### 36. Comptage des films par utilisateur et par genre

```python
# COMMAND ----------
#Cmd 35
# Sélectionner les colonnes « userId », « title » et « genres » dans df_rating, regrouper les données par colonnes « userId » et « genres », compter le nombre de lignes pour chaque regroupement. Mettre les données dans df_rating_genre.
df_rating_genre=df_rating.select('userId','title','genres').groupby('userId','genres').count() 
```

- **`df_rating.select('userId','title','genres').groupby('userId','genres').count()`** : Cette commande sélectionne les colonnes `userId`, `title`, et `genres`, puis regroupe les enregistrements par utilisateur et genre. Pour chaque groupe, elle compte le nombre de films, ce qui permet de voir combien de films chaque utilisateur a vus dans chaque genre.

- **`df_rating_genre`** : Nouveau DataFrame contenant le nombre de films vus par chaque utilisateur dans chaque genre.

---

#### 37. Affichage du comptage par genre et par utilisateur

```python
# COMMAND ----------
#Cmd 36
display(df_rating_genre) # Afficher df_rating_genre.
```

- **`display(df_rating_genre)`** : Affiche le DataFrame `df_rating_genre` pour visualiser combien de films chaque utilisateur a vus dans chaque genre.

---

#### 38. Identification des films récents par utilisateur

```python
# COMMAND ----------
#Cmd 37
# Regrouper les données de df_ratings par les colonnes 'userId' et 'movieId', calculer la maximale valeur de la colonne 'rating_date' dans chaque groupe. Mettre les données dans df_recent_movie.
df_recent_movie=df_ratings.groupby('userId','movieId').agg(f.max(df_ratings['rating_date']))
```

- **`df_ratings.groupby('userId','movieId').agg(f.max(df_ratings['rating_date']))`** : Cette commande regroupe les enregistrements dans `df_ratings` par utilisateur et film, puis calcule la date de notation la plus récente pour chaque film par utilisateur. Cela permet d'identifier les films les plus récemment notés par chaque utilisateur.

- **`df_recent_movie`** : Nouveau DataFrame contenant les films récemment notés par utilisateur.

---

#### 39. Affichage des films récents par utilisateur

```python
# COMMAND ----------
#Cmd 38
display(df_recent_movie) # Afficher df_recent_movie
```

- **`display(df_recent_movie)`** : Affiche le DataFrame `df_recent_movie` pour visualiser les films les plus récemment notés par chaque utilisateur.

---

#### 40. Affichage du format des colonnes dans `df_ratings`

```python
# COMMAND ----------
#Cmd 39
#Latest Trending movies(Overall)
df_ratings # Afficher le format de chaque colonne de df_ratings.
```

- **`df_ratings`** : Cette commande affiche les premières lignes du DataFrame `df_ratings`, ainsi que les noms et types des colonnes, permettant de vérifier la structure des données.

---

#### 41. Calcul de la moyenne des notes par genre

```python
# COMMAND ----------
#Cmd 40
df_ratings_per_genre=df.groupby('genres').avg('avg_rating') # Regrouper les données de df par colonne « genres » et calculer la moyenne de la colonne « avg_rating » dans chaque groupe. Mettre les données dans df_ratings_per_genre.
display(df_ratings_per_genre) # Afficher df_ratings_per_genre
```

- **`df.groupby('genres').avg('avg_rating')`** : Cette commande regroupe les enregistrements dans `df` par genre et calcule la moyenne des notes (`avg_rating`) pour chaque genre. Cela permet d'évaluer la performance moyenne des films dans chaque genre.

- **`df_ratings_per_genre`** : Nouveau DataFrame contenant la moyenne des notes par genre.

- **`display(df_ratings_per_genre)`** : Affiche le DataFrame `df_ratings_per_genre` pour visualiser les moyennes des notes par genre.

