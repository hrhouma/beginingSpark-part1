# Convertir un RDD en DataFrame puis en Dataset - Tutoriel

Ce tutoriel vous montrera comment convertir un RDD en DataFrame, puis en Dataset en utilisant Apache Spark.

# Convertir un RDD en DataFrame puis en Dataset avec Spark

Ce guide pas à pas vous montrera comment convertir un RDD en DataFrame, puis en Dataset en utilisant Apache Spark. Nous utiliserons Scala pour les exemples.

spark-shell
======= 
## Partie 1: Conversion d'un RDD en DataFrame

### Étape 1: Importer les classes nécessaires
```scala
import org.apache.spark.sql.{SparkSession, Row}
import org.apache.spark.sql.types._
```

### Étape 2: Initialiser une session Spark
```scala
val spark = SparkSession.builder()
                        .appName("RDD to DataFrame")
                        .getOrCreate()
```

### Étape 3: Créer un RDD
```scala
val rdd = sc.parallelize(Seq((1, "Alice", 25), (2, "Bob", 30), (3, "Charlie", 35)))
```

### Étape 4: Définir le schéma du DataFrame
```scala
val schema = StructType(Seq(
  StructField("ID", IntegerType, nullable = false),
  StructField("Name", StringType, nullable = false),
  StructField("Age", IntegerType, nullable = false)
))
```

### Étape 5: Créer le DataFrame à partir du RDD et du schéma
```scala
val df = spark.createDataFrame(rdd.map(row => Row.fromTuple(row)), schema)
```

### Étape 6: Définir une classe pour représenter les données
```scala
case class Person(ID: Int, Name: String, Age: Int)
```

### Étape 7: Importer les classes nécessaires pour les encoders
```scala
import org.apache.spark.sql.{Encoder, Encoders}
```

### Étape 8: Convertir le DataFrame en Dataset
```scala
val ds: Dataset[Person] = df.as[Person]
```

## Partie 3: Affichage du Dataset

### Étape 9: Afficher le contenu du Dataset
```scala
ds.show()
```
# Résumé des commandes
```scala
import org.apache.spark.sql.{SparkSession, Row}
import org.apache.spark.sql.types._

val spark = SparkSession.builder()
                        .appName("RDD to DataFrame")
                        .getOrCreate()

val rdd = sc.parallelize(Seq((1, "Alice", 25), (2, "Bob", 30), (3, "Charlie", 35)))
val schema = StructType(Seq(
  StructField("ID", IntegerType, nullable = false),
  StructField("Name", StringType, nullable = false),
  StructField("Age", IntegerType, nullable = false)
))
val df = spark.createDataFrame(rdd.map(row => Row.fromTuple(row)), schema)

import org.apache.spark.sql.{Encoder, Encoders}
case class Person(ID: Int, Name: String, Age: Int)

import org.apache.spark.sql.Dataset
val ds: Dataset[Person] = df.as[Person]
ds.show()
```

## Partie 2 - en partant de pyspark

pyspark
======= 
### Transformer un RDD en DataFrame :

1. **Création d'une session Spark** :
   ```python
   from pyspark.sql import SparkSession
   spark = SparkSession.builder \
       .appName("RDD to DataFrame") \
       .getOrCreate()
   ```

2. **Création d'un RDD** :
   ```python
   rdd = sc.parallelize([(1, 'Alice', 25), (2, 'Bob', 30), (3, 'Charlie', 35)])
   ```

3. **Conversion du RDD en DataFrame** :
   ```python
   df = rdd.toDF(["ID", "Name", "Age"])
   ```

4. **Affichage du DataFrame** :
   ```python
   df.show()
   ```

### Transformer un DataFrame en DataSet :

1. **Définition du schéma du DataSet** :
   ```python
   from pyspark.sql.types import StructType, StructField, IntegerType, StringType
   schema = StructType([
       StructField("ID", IntegerType(), True),
       StructField("Name", StringType(), True),
       StructField("Age", IntegerType(), True)
   ])
   ```

2. **Conversion du DataFrame en DataSet** :
   ```python
   ds = df.as(schema)
   ```

3. **Affichage du DataSet** :
   ```python
   ds.show()
   ```
Ces commandes vous permettront de transformer efficacement un RDD en DataFrame, puis en DataSet dans PySpark.
