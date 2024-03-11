# ÉVALUATION FORMATIVE #1

## EXERCICE #1
**Transformations vs Actions dans Spark**

Les **transformations** dans Spark créent de nouveaux RDD à partir des RDD existants. Elles sont paresseuses (lazy), c'est-à-dire qu'elles ne sont exécutées qu'en présence d'une action. Exemples : `map`, `filter`, `flatMap`.

Les **actions**, quant à elles, déclenchent l'exécution des transformations et renvoient un résultat au driver ou écrivent dans un système de stockage externe. Exemples : `collect`, `count`, `reduce`.

## EXERCICE #2
**flatMap vs map**

La fonction **flatMap** transforme chaque élément d'un RDD en un ou plusieurs éléments, tandis que **map** applique une transformation à chaque élément d'un RDD, produisant un nouveau RDD d'éléments transformés.

## EXERCICE #3
**Pourquoi `reduceByKey` plutôt que `reduce` dans WORDCOUNT ?**

- **3.1 Transformations et Actions :** Dans le contexte de WordCount, les transformations préparent les données (par exemple, `flatMap` et `map` pour créer des paires clé-valeur), et les actions (comme `collect`) déclenchent l'exécution et affichent les résultats.
  
- **3.2 flatMap vs map :** `flatMap` peut générer zéro ou plusieurs sorties pour chaque entrée, utile pour décomposer les phrases en mots. `map` génère exactement une sortie pour chaque entrée, utilisé pour convertir chaque mot en une paire clé-valeur.
  
- **3.3 reduceByKey vs reduce :** `reduceByKey` agit sur des paires clé-valeur et combine les valeurs pour chaque clé. Il est préféré dans WordCount pour sa capacité à réduire le trafic réseau en combinant les clés identiques sur chaque partition avant de déplacer les données, contrairement à `reduce` qui agit globalement sur tous les éléments.

## EXERCICE #4
**Chaining de Fonctions**

Cette pratique s'appelle le **chaining** ou la composition de fonctions. En programmation fonctionnelle, elle permet de simplifier le code et d'améliorer la lisibilité. Spark utilise largement cette approche pour permettre des transformations de données en chaîne.

## EXERCICE #6
**Utilisation de scala.util.Sorting._**

`scala.util.Sorting._` fournit des méthodes pour trier des tableaux de divers types primitifs et d'objets, permettant un tri efficace dans les applications Scala, y compris celles utilisant Spark.

## EXERCICE #7
**Calcul sur Deux Nœuds : fold vs reduce**

- **reduce :** Peut centraliser les données sur un seul nœud, ce qui pourrait causer des problèmes de performance avec de grandes données.
  
- **fold :** Effectue les calculs parallèlement sur chaque nœud, réduisant le besoin de mouvement des données entre les nœuds, ce qui le rend plus efficace pour les données distribuées.

## EXERCICE #8
**Analyse de Fréquence des Mots avec Spark RDD**

- **Initialisation de RDD :** Utilisez `sc.parallelize` pour chaque ensemble.
  
- **Transformation et Action :**
  - **Étape A :** `flatMap` pour séparer les mots.
  - **Étape B :** `map` pour transformer en paires clé-valeur.
  - **Étape C :** `reduceByKey` pour additionner les valeurs par clé.
  
- **Résultats :** Affichez les comptages de mots pour chaque RDD.

**Questions :**

- Comparez les résultats pour observer l'impact de la structure des données initiales sur le comptage final des mots.

## EXERCICE #9
**cogroup vs join et fullOuterJoin**

- **Question 1 :** `cogroup` regroupe les données de deux RDDs par clé, alors que `join` combine les paires clé-valeur ayant la même clé.
  
- **Question 2 :** `fullOuterJoin` retourne un RDD contenant toutes les paires clé-valeur avec des clés apparaissant dans les deux RDDs, tandis que `cogroup` regroupe les valeurs de chaque RDD séparément.

**Conseil :** Assurez-vous d'avoir initialisé `SparkContext` avant de commencer l'exercice #8 et amusez-vous bien à explorer les données avec Spark !