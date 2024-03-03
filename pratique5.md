# Convertir un RDD en DataFrame puis en Dataset - Tutoriel

Ce tutoriel vous montrera comment convertir un RDD en DataFrame, puis en Dataset en utilisant Apache Spark.

## Partie 1

1. **Importez les classes nécessaires :**
```scala
import org.apache.spark.sql.{Encoder, Encoders}
```

2. **Définissez la classe `Person` :**
```scala
case class Person(ID: Int, Name: String, Age: Int)
```

3. **Convertissez le DataFrame en Dataset :**
```scala
val ds: Dataset[Person] = df.as[Person]
```

4. **Affichez le Dataset :**
```scala
ds.show()
```

## Exemple complet en Scala

```scala
// Import des classes nécessaires
import org.apache.spark.sql.{Encoder, Encoders}

// Définition de la classe Person
case class Person(ID: Int, Name: String, Age: Int)

// Convertir DataFrame en Dataset
val ds: Dataset[Person] = df.as[Person]

// Import de la classe Dataset
import org.apache.spark.sql.Dataset

// Afficher le Dataset
ds.show()
```
## Partie 2 - en partant de pyspark

Bien sûr, voici les commandes pour transformer un RDD en DataFrame, puis en DataSet dans PySpark :

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
