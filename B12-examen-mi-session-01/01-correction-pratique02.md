### Initialisation de SparkSession

```python
from pyspark.sql import SparkSession
from pyspark.sql.functions import col, year, month, avg, sum, max, min, expr, round, window

# Initialiser SparkSession
spark = SparkSession.builder \
    .appName("AMRB Analysis") \
    .getOrCreate()

# Charger le fichier CSV dans un DataFrame
amrb_data = spark.read \
    .option("header", "true") \
    .option("inferSchema", "true") \
    .csv("AMRB.csv")

# Créer une vue temporaire pour utiliser Spark SQL
amrb_data.createOrReplaceTempView("amrb")
```

### 1. Transactions Quotidiennes (facile)
Affichez la date, le prix d'ouverture, et le prix de clôture de l'action pour chaque jour.

```python
query1 = """
  SELECT Date, Open, Close 
  FROM amrb
"""
result1 = spark.sql(query1)
result1.show()
```

### 2. Volatilité Journalière (facile)
Calculez la différence entre le prix de clôture et d'ouverture pour chaque jour, indiquant la volatilité journalière de l'action.

```python
query2 = """
  SELECT Date, (Close - Open) AS Volatility 
  FROM amrb
"""
result2 = spark.sql(query2)
result2.show()
```

### 3. Extrêmes de Volume (intermédiaire)
Trouvez les valeurs maximale et minimale des volumes échangés.

```python
query3 = """
  SELECT MAX(Volume) AS MaxVolume, MIN(Volume) AS MinVolume
  FROM amrb
"""
result3 = spark.sql(query3)
result3.show()
```

### 4. Moyenne Annuelle des Valeurs d'Ouverture (intermédiaire)
Calculez la moyenne des valeurs d'ouverture de l'action par année.

```python
query4 = """
  SELECT YEAR(Date) AS Year, AVG(Open) AS AvgOpen 
  FROM amrb
  GROUP BY YEAR(Date)
"""
result4 = spark.sql(query4)
result4.show()
```

### 5. Total des Volumes par Mois (intermédiaire)
Déterminez la somme des volumes échangés par mois, en incluant l'année dans votre résultat.

```python
query5 = """
  SELECT YEAR(Date) AS Year, MONTH(Date) AS Month, SUM(Volume) AS TotalVolume
  FROM amrb
  GROUP BY YEAR(Date), MONTH(Date)
"""
result5 = spark.sql(query5)
result5.show()
```

### 6. Plus Grand Écart Quotidien (avancé)
Identifiez la date où l'écart entre le prix le plus haut et le plus bas était le plus grand.

```python
query6 = """
  SELECT Date, (High - Low) AS Range
  FROM amrb
  ORDER BY Range DESC
  LIMIT 1
"""
result6 = spark.sql(query6)
result6.show()
```

### 7. Moyenne Mobile sur 7 Jours (avancé)
Calculez la moyenne mobile du prix de clôture sur 7 jours pour chaque date.

```python
from pyspark.sql.window import Window
from pyspark.sql.functions import avg

# Créer une fenêtre pour calculer la moyenne mobile sur 7 jours
windowSpec = Window.orderBy("Date").rowsBetween(-6, 0)

# Ajouter une colonne pour la moyenne mobile
amrb_data = amrb_data.withColumn("MovingAvg", avg("Close").over(windowSpec))

amrb_data.select("Date", "Close", "MovingAvg").show()
```
