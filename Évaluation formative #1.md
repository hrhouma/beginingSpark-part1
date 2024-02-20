# ÉVALUATION FORMATIVE #1

## EXERCICE #1
Expliquez la différence entre les transformations et les actions dans le contexte de Spark. Référez-vous au fichier PDF joint pour étayer votre réponse.

## EXERCICE #2
Décrivez les distinctions entre les opérations `flatMap` et `map` dans Spark et comment elles sont utilisées dans le traitement des données.

## EXERCICE #3
Pourquoi préférerions-nous utiliser `reduceByKey` plutôt que `reduce` dans l'exemple de WORDCOUNT ?

### 3.1
Expliquez la distinction entre les transformations et les actions dans le contexte de WordCount, en vous référant à votre fichier PDF joint.

### 3.2
Quelles sont les différences entre les opérations `flatMap` et `map` dans le contexte de WordCount ?

### 3.3
Quelle est la différence entre `reduceByKey` et `reduce`, et pourquoi préférerions-nous utiliser `reduceByKey` dans l'exemple de WordCount ?

## EXERCICE #4
Comment appelle-t-on généralement la pratique consistant à enchaîner plusieurs appels de fonctions ou de méthodes dans une séquence, en prenant le résultat de l'appel précédent comme entrée pour produire un nouvel état ou résultat, notamment en programmation fonctionnelle ? Comment cette pratique est-elle couramment utilisée dans des frameworks comme Apache Spark pour manipuler des RDDs ou des DataFrames ?

## EXERCICE #6
Explorez et expliquez l'utilisation de `scala.util.Sorting._` en Scala.

## EXERCICE #7
Expliquez comment Spark effectue le calcul sur deux nœuds et différencie les opérations de `fold` et de `reduce`, en utilisant la première diapositive de l'introduction à Spark comme référence. Confirmez ou niez cette affirmation :
- `reduce` rassemble toutes les données sur un seul nœud avant d'effectuer le calcul, ce qui peut entraîner des problèmes de performance avec de grandes quantités de données.
- En revanche, `fold` effectue le calcul au niveau de chaque nœud, en parallèle, permettant un traitement efficace des données distribuées en minimisant les mouvements de données entre les nœuds.

## EXERCICE #8
**Analyse de Fréquence des Mots avec Spark RDD**

**Objectif :** Pratiquer les opérations de base sur les RDD dans Spark pour analyser la fréquence des mots dans différents ensembles de données.

**Données :**
- Ensemble 1 : `List("toto tata titi toto tutu tata")`
- Ensemble 2 : `List("toto tata", "titi toto", "tutu tata")`
- Ensemble 3 : `List("toto tata titi", "toto tutu tata")`

**Instructions :**
1. **Initialisation de RDD :** Initialisez un RDD pour chaque ensemble de données avec `sc.parallelize`.
2. **Transformation et Action :**
   - **Étape A :** Utilisez `flatMap` pour séparer les mots dans chaque ensemble de données.
   - **Étape B :** Appliquez `map` pour transformer chaque mot en une paire clé-valeur.
   - **Étape C :** Utilisez `reduceByKey` pour additionner les valeurs de chaque clé.
3. **Résultats :** Affichez les résultats sous forme de paires clé-valeur pour chaque RDD.

**Questions :**
- Comparez les résultats obtenus pour les trois ensembles. Qu'observez-vous ?
- Expliquez l'impact de la structure des données initiales sur le résultat final.

## EXERCICE #9

**Question 1 :** Pourquoi les résultats des opérations `cogroup` et `join` sur des RDDs dans Apache Spark sont-ils représentés différemment ?

**Question 2 :** Quelle est la différence entre l'utilisation de `fullOuterJoin` et `cogroup` sur des RDDs dans Apache Spark, en termes de type de résultat retourné ?

---

Assurez-vous d'avoir une instance Spark fonctionnelle et d'avoir initialisé SparkContext avant de commencer l'exercice #8. Utilisez les opérations RDD de Spark pour accomplir les tâches demandées et pour manipuler les données. Bonne chance et

 amusez-vous bien à explorer les données avec Spark !

 ## Références :
https://github.com/hrhouma/beginingSpark-part1/blob/main/CoGroupePartie1.md
https://github.com/hrhouma/beginingSpark-part1/blob/main/CoGroupePartie2.md