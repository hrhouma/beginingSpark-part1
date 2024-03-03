# Tutoriel Scala pour Apache Spark

## Table des matières

1. [Création d'un DataFrame à partir d'un fichier JSON](#partie-01---création-dun-dataframe-en-utilisant-un-objet-json)
2. [Création d'un DataFrame à partir d'un fichier CSV](#partie-02---création-dun-dataframe-en-utilisant-un-fichier-csv)
3. [Conversion d'un DataFrame en RDD](#partie-03---convertir-un-df-en-rdd)
4. [SparkSQL avec PostgreSQL](#partie-04---sparksql-avec-les-sgbdr-postgresql)
5. [Plus sur les DataFrames avec SparkSQL](#partie-05---plus-sur-les-dataframes-avec-sparksql)
6. [Introduction aux Datasets](#partie-06---les-datasets)

---

## Partie 01 - Création d'un DataFrame en utilisant un objet JSON

Exemple de fichier JSON :
```json
{"name":"Michael"}
{"name":"Andy","age":30}
{"name":"Justin","age":19}
```

Chargement et manipulation du fichier JSON avec Scala :
```scala
import org.apache.spark.sql.SQLContext
val sqlContext = new SQLContext(sc)
val dataframe = sqlContext.read.format("json").option("inferSchema","true").load("C:/people.json")
dataframe.createOrReplaceTempView("people")
dataframe.printSchema()
spark.sql("SELECT * FROM people")
spark.sql("SELECT * FROM people WHERE age IS NOT NULL").show()
```

---

## Partie 02 - Création d'un DataFrame en utilisant un fichier CSV

Chargement et manipulation du fichier CSV avec Scala :
```scala
import org.apache.spark.sql.SQLContext
val sqlContext = new SQLContext(sc)
val dataframe = sqlContext.read.format("csv").option("header","true").option("inferSchema","true").load("C:/titanic.csv")
dataframe.printSchema()
dataframe.createOrReplaceTempView("titanic")
spark.sql("SELECT name, age FROM titanic").show()
```

---

## Partie 03 - Convertir un DF en RDD

Exemple de conversion d'un DataFrame en RDD, puis manipulation de celui-ci :
```scala
import org.apache.spark.sql.SQLContext
val sqlContext = new SQLContext(sc)
val df = sqlContext.read.format("csv").option("header","true").option("inferSchema","true").load("C:/titanic.csv")
val dfToRdd = df.rdd
```

---

## Partie 04 - SparkSQL avec les SGBDR (PostgreSQL)

Configuration et utilisation de SparkSQL pour interagir avec une base de données PostgreSQL :
```scala
spark-shell --driver-class-path C:\path\to\postgresql-42.5.0.jar --jars C:\path\to\postgresql-42.5.0.jar
val jdbcDF = spark.read.format("jdbc").option("url","jdbc:postgresql://127.0.0.1/postgres").option("dbtable","public.personnes").option("user","postgres").option("password","postgres").load()
jdbcDF.printSchema()
```
## Exemple détaillé - suite de la partie 04 - SparkSQL avec les SGBDR (PostgreSQL)

Pour utiliser SparkSQL avec PostgreSQL, vous devez suivre ces étapes :

1. Téléchargez et installez PostgreSQL pour Windows à partir de [EnterpriseDB](https://www.enterprisedb.com/downloads/postgres-postgresql-downloads).
2. Téléchargez le connecteur JDBC pour PostgreSQL à partir de [jdbc.postgresql.org](https://jdbc.postgresql.org/download/).

### Configuration de la base de données

Créez une table `personnes` dans PostgreSQL avec la structure suivante :

```sql
CREATE TABLE personnes (
  id INTEGER, 
  nom CHARACTER VARYING(255), 
  prenom CHARACTER VARYING(255),
  age INTEGER,
  cp INTEGER
);
```

Insérez quelques données dans la table `personnes` :

```sql
INSERT INTO personnes VALUES (1, 'Smith', 'John', 20, 31000);
INSERT INTO personnes VALUES (2, 'Johnson', 'Emma', 25, 31000);
INSERT INTO personnes VALUES (3, 'Williams', 'Olivia', 30, 31000);
INSERT INTO personnes VALUES (4, 'Brown', 'Noah', 35, 31000);
INSERT INTO personnes VALUES (5, 'Jones', 'Liam', 40, 31000);
INSERT INTO personnes VALUES (6, 'Garcia', 'Sophia', 20, 32000);
INSERT INTO personnes VALUES (7, 'Miller', 'Ava', 25, 32000);
INSERT INTO personnes VALUES (8, 'Davis', 'Isabella', 30, 32000);
INSERT INTO personnes VALUES (9, 'Rodriguez', 'Mia', 35, 32000);
INSERT INTO personnes VALUES (10, 'Martinez', 'Ethan', 40, 32000);
INSERT INTO personnes VALUES (11, 'Hernandez', 'Alexander', 22, 33000);
INSERT INTO personnes VALUES (12, 'Lopez', 'Charlotte', 27, 33000);
INSERT INTO personnes VALUES (13, 'Wilson', 'Amelia', 32, 33000);
INSERT INTO personnes VALUES (14, 'Anderson', 'Harper', 37, 33000);
INSERT INTO personnes VALUES (15, 'Thomas', 'Evelyn', 42, 33000);
INSERT INTO personnes VALUES (16, 'Taylor', 'Abigail', 47, 34000);
INSERT INTO personnes VALUES (17, 'Moore', 'Emily', 52, 34000);
INSERT INTO personnes VALUES (18, 'Jackson', 'Elizabeth', 57, 34000);
INSERT INTO personnes VALUES (19, 'Martin', 'Sofia', 62, 34000);
INSERT INTO personnes VALUES (20, 'Lee', 'Avery', 67, 34000);

```

Pour sélectionner et vérifier les données :

```sql
SELECT * FROM public.personnes;
```

### Configuration de Spark pour utiliser PostgreSQL

Lancez `spark-shell` en incluant le chemin du connecteur JDBC pour PostgreSQL :

```scala
spark-shell --driver-class-path C:\path\to\postgresql-42.5.0.jar --jars C:\path\to\postgresql-42.5.0.jar
```

Lisez les données de la table `personnes` avec SparkSQL :

```scala
val jdbcDF = spark.read
  .format("jdbc")
  .option("url", "jdbc:postgresql://127.0.0.1/postgres")
  .option("dbtable", "public.personnes")
  .option("user", "postgres")
  .option("password", "postgres")
  .load()

jdbcDF.printSchema()
jdbcDF.show()

// Exemples de manipulations DataFrame
jdbcDF.select("age", "cp").distinct().show()
```
---

## Partie 05 - Plus sur les DataFrames avec SparkSQL

Approfondissement sur les manipulations avancées des DataFrames avec SparkSQL.

---

## Partie 06 - Les Datasets

Introduction aux Datasets, une abstraction optimisée et typée sur les DataFrames.

---

Assurez-vous de remplacer les chemins et configurations spécifiques par ceux correspondant à votre environnement de travail.
