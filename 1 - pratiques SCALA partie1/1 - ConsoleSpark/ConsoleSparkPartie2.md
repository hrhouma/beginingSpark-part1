### Utilisation de la commande Spark Shell avec des exemples

Apache Spark est livré par défaut avec la commande `spark-shell`, utilisée pour interagir avec Spark depuis la ligne de commande. Cela est généralement utilisé pour analyser rapidement des données ou tester des commandes Spark. Le shell PySpark est considéré comme un REPL (Read Eval Print Loop). Apache Spark supporte `spark-shell` pour Scala, `pyspark` pour Python et `sparkr` pour R. Java n'est pas supporté à l'heure actuelle.

#### Points clés du Spark Shell

- Le Spark Shell est considéré comme un REPL, utilisé pour tester rapidement des instructions Spark/PySpark.
- Le Spark Shell supporte seulement Scala, Python et R (Java pourrait être supporté dans les versions précédentes).
- La commande `spark-shell2` est utilisée pour lancer Spark avec le shell Scala.
- La commande `pyspark` est utilisée pour lancer Spark avec le shell Python.
- La commande `sparkr` est utilisée pour lancer Spark avec le langage R.
- Dans le Spark Shell, Spark fournit par défaut les variables `spark` et `sc`. `spark` est un objet de SparkSession et `sc` est un objet de SparkContext.
- Dans le Shell, vous ne pouvez pas créer votre propre SparkContext.

#### Pré-requis

Assurez-vous d'avoir installé Apache Spark.

- Installation sur Mac OS
- Installation sur Windows
- Installation sur Ubuntu

#### 1. Lancer la commande Spark Shell (`spark-shell`)

Allez dans le répertoire d'installation d'Apache Spark depuis la ligne de commande et tapez `bin/spark-shell` puis appuyez sur entrée. Cela lance le Spark shell et vous donne un prompt Scala pour interagir avec Spark en langage Scala.

```bash
./bin/spark-shell
```

#### 2. Interface Web UI du Spark Shell

Par défaut, l'interface Web UI de Spark se lance sur le port 4040. Si elle ne peut pas se lier à ce port, elle essaie sur 4041, 4042, etc.

#### 3. Exécuter des instructions Spark depuis le Shell

Créez un DataFrame Spark avec des données d'exemple pour valider l'installation :

```scala
import spark.implicits._
val data = Seq(("Java", "20000"), ("Python", "100000"), ("Scala", "3000"))
val df = data.toDF() 
df.show()
```

#### 4. Exemples de commandes Spark Shell

- **Exemple 1 :** Lancement en mode Cluster

  ```bash
  ./bin/spark-shell \
     --master yarn \
     --deploy-mode cluster
  ```

- **Exemple 2 :** Ajout de jars de dépendance

  ```bash
  ./bin/spark-shell \
     --master yarn \
     --deploy-mode cluster \
     --jars file1.jar,file2.jar
  ```

- **Exemple 3 :** Ajout de jars au spark-shell

  ```bash
  spark-shell --driver-class-path /path/to/example.jar:/path/to/another.jar
  ```

- **Exemple 4 :** Avec des configurations

  ```bash
  ./bin/spark-shell \
     --master yarn \
     --deploy-mode cluster \
     --driver-memory 8g \
     --executor-memory 16g \
     --executor-cores 2  \
     --conf "spark.sql.shuffle.partitions=20000" \
     --conf "spark.executor.memoryOverhead=5244" \
     --conf "spark.memory.fraction=0.8" \
     --conf "spark.memory.storageFraction=0.2" \
     --jars file1.jar,file2.jar
  ```

#### 5. Commandes dans le Spark Shell

Utilisez `:help` pour obtenir de l'aide sur les différentes commandes disponibles.

#### 6. Accès aux variables d'environnement

Vous pouvez accéder aux variables d'environnement dans le shell avec `System.getenv()`.

#### 7. Exécuter un script shell Unix

Utilisez `:sh <nom-du-fichier>` pour exécuter un fichier shell Unix depuis le prompt Scala.

#### 8. Charger un script Scala

Utilisez `:load <nom-du-fichier>` pour charger un fichier Scala dans le shell.

#### 9. Options du Spark Shell

Pour obtenir la liste complète des options du spark-shell, utilisez la commande `-h`.

---

Ce tutoriel couvre les bases

 de l'utilisation de la commande Spark Shell, de l'installation de Spark aux différentes options et commandes disponibles dans le shell pour interagir avec Spark.

 Pour approfondir vos connaissances sur l'utilisation de la console Spark (REPL) et pour des exemples supplémentaires, je vous recommande de consulter les ressources suivantes :

- **Tutoriel Important 0** : Un guide complet sur l'utilisation de la console Spark, incluant des exemples d'usage. Disponible sur [Spark by Examples](https://sparkbyexamples.com/spark/spark-shell-usage-with-examples/).

- **Tutoriel Important 1** : Un article détaillé sur l'utilisation de la console Spark pour manipuler des données avec Apache Spark. Trouvez-le sur [MungingData](https://mungingdata.com/apache-spark/using-the-console/).

Ces tutoriels fournissent des informations précieuses et des exemples pratiques qui compléteront les informations du tutoriel initial, vous aidant à mieux comprendre et à utiliser efficacement la console Spark pour vos projets de traitement de données.
