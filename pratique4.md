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
val dataframe = sqlContext.read.format("json").option("inferSchema","true").load("C:/Users/Loic/Desktop/SPARK/people.json")
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
val dataframe = sqlContext.read.format("csv").option("header","true").option("inferSchema","true").load("C:/Users/Loic/Desktop/SPARK/titanic.csv")
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
val df = sqlContext.read.format("csv").option("header","true").option("inferSchema","true").load("C:/Users/Loic/Desktop/SPARK/titanic.csv")
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

---

## Partie 05 - Plus sur les DataFrames avec SparkSQL

Approfondissement sur les manipulations avancées des DataFrames avec SparkSQL.

---

## Partie 06 - Les Datasets

Introduction aux Datasets, une abstraction optimisée et typée sur les DataFrames.

---

Assurez-vous de remplacer les chemins et configurations spécifiques par ceux correspondant à votre environnement de travail.
