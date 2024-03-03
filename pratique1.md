//********************************************************************************
//********************************************************************************
// PRATIQUE 1 - RDD ET TRANSFORMATIONS, ACTIONS DE BASE
//********************************************************************************
//********************************************************************************

// NOUS MANIPULONS DES RDD
// OBJET DE BASE SC = SPARK CONTEXTE
// LECTURE D'UN FICHIER + ACTION COLLECT

## (Section 01/15) 2 façons de créer des RDDs

// 1ère méthode pour créer un RDD
val rdd1 = sc.textFile("test.txt")
rdd1.collect

// Avec un fichier plus volumineux 4300-0.txt
val rdd2 = sc.textFile("4300-0.txt")
rdd2.collect

// 2ème méthode pour créer un RDD avec la méthode parallelize()
val liste = List("Aziz","Mouad","Martha")
val rdd3= sc.parallelize(liste)
rdd3.collect

// Autre exemple
val listeEtudiants = List("Salim","Mouad","Allakouba","Asmae","Asmae","Asmae","Asmae","Salim")
val rdd4 = sc.parallelize (listeEtudiants)
rdd4.collect

## (Section 02/15) LES MÉTHODES textFile - collect - flatMap - map - reduceByKey - saveAsTextFile
val textFchier = sc.textFile("etudiants.txt")
textFchier.collect 
val countsFlatMap = textFchier.flatMap(line => line.split(" "))
countsFlatMap.collect
val countsMap = countsFlatMap.map(word => (word,1))
countsMap.collect
val countsReduce = countsMap.reduceByKey(_+_)  
countsReduce.collect
countsReduce.saveAsTextFile("resultatEtudiants")

// REFORMULATION EN RENOMMANT À (RDD#nombre) pour illustrer la création de plusieurs RDD - DAG
val rdd1 = sc.textFile("etudiants.txt") 
val rdd2 = rdd1.flatMap(line => line.split(" "))
val rdd3 = rdd2.map(word => (word,1))
val rdd4 = rdd3.reduceByKey(_+_) 
rdd4.collect
rdd4.saveAsTextFile("resultatEtudiants")

sc.textFile("etudiants.txt")
	.flatMap(line => line.split(" "))
		.map(word => (word,1))
			.reduceByKey(_+_)
				.collect
				

sc.textFile("etudiants.txt")
	.flatMap(line => line.split(" "))
		.map(word => (word,1))
			.reduceByKey(_+_)
					.saveAsTextFile("resultatEtudiants")

## (Section 03/15) MAP VERSUS flatMap
val rddmap = sc.parallelize (List("test1 test2","test3 test4","test5 test6"))
rddmap.map(x=>x.split(" ")).collect
rddmap.flatMap(x=>x.split(" ")).collect

## (Section 04/15) MÉTHODE FILTER
val rddf=sc.parallelize(List("Salim","Martha-Patricia","Abed","François"))
rddf.collect
rddf.filter(x=> x.contains("-")).collect
rddf.filter(x=> !x.contains("-")).collect

## (Section 05/15) MÉTHODE groupBy ET sortBy

val rddGby = sc.parallelize(List("Salim","Martha-Patricia","Abed","François","Sonia","Madiha"))
val rddGroupBy = rddGby.groupBy (x=> x.charAt(0))
rddGroupBy.collect

val rddSort = rddGby.sortBy (x=> x.charAt(0))
rddSort.collect

val x = rddGby.sortBy (x=> x.charAt(0), ascending=false).collect

## (Section 06/15) Plus de détails pour groupBy
val rddGby1 = sc.parallelize(List("Salim","Martha-Patricia","Abed","François","Sonia","Madiha","Maeva"))
rddGby1.groupBy (x=> x.charAt(0)).collect
rddGby1.groupBy (x=> x.charAt(0)).sortBy (a=> a).collect
rddGby1.groupBy (x=> x.charAt(2)).sortBy (a=> a).collect

## (Section 07/15) GroupByKey - reduceByKey - sortByKey
val rddGroupByKey = sc.parallelize(List("0,11","1,14","0,3","2,19","1,3","5,7","0,3")) 
val rddGroupByKeyMap = rddGroupByKey.map(x=>(x.split(",")(0),x.split(",")(1).toInt))
rddGroupByKeyMap.collect
rddGroupByKeyMap.groupByKey().collect
rddGroupByKeyMap.reduceByKey((x,y)=> x+y ).collect 
val rddreduceByKey= rddGroupByKeyMap.reduceByKey((x,y)=> x+y )

## (Section 08/15) Plus de détails pour sortByKey
val rddsortByKey= rddreduceByKey.sortByKey() 
rddsortByKey.collect

## (Section 09/15) MAP + sortByKey
rddGroupByKeyMap.collect
val rddGroupByKeyMapsortByKey= rddGroupByKeyMap.sortByKey()
rddGroupByKeyMapsortByKey.collect

## (Section 10/15) Explication de liste de transformations  
sc.parallelize(List("0,11","1,14","0,3","2,19","1,3","5,7"))
	.map(x=>(x.split(",")(0),x.split(",")(1).toInt))
		.groupByKey()
			.collect
			
sc.parallelize(List("0,11","1,14","0,3","2,19","1,3","5,7"))
	.map(x=>(x.split(",")(0),x.split(",")(1).toInt))
		.reduceByKey((x,y)=> x+y )
			.collect
		
// La programmation avec une suite de séquences est souvent appelée 
// la composition de fonctions ou la composition de méthodes. 
// C'est une pratique courante en programmation fonctionnelle 
// où vous enchaînez plusieurs appels de fonctions ou de méthodes 
// les unes après les autres pour effectuer une série de transformations sur les données. 
// Chaque fonction ou méthode dans la séquence 
// prend en entrée le résultat de la précédente 
// et produit un nouvel état ou résultat. 
// Cette composition permet de construire des pipelines 
// de traitement de données de manière concise et modulaire. 
// En Apache Spark, par exemple, cela est souvent utilisé 
// avec des transformations sur les RDDs (Resilient Distributed Datasets) ou sur les DataFrames.

## (Section 11/15) KEYS - VALUES
sc.parallelize(List("0,11","1,14","0,3","2,19","1,3","5,7"))
	.map(x=>(x.split(",")(0),x.split(",")(1).toInt))   
		.reduceByKey((x,y)=> x+y )
			.keys
				.collect

// Afficher les valeurs avec la somme par clé			
sc.parallelize(List("0,11","1,14","0,3","2,19","1,3","5,7"))
	.map(x=>(x.split(",")(0),x.split(",")(1).toInt))
		.reduceByKey((x,y)=> x+y )
			.values
				.collect

// Question : Pourquoi le 11 ne figure-t-il pas dans la liste des valeurs?
// Afficher les valeurs juste après la séparation en clé, valeurs				
sc.parallelize(List("0,11","1,14","0,3","2,19","1,3","5,7"))
	.map(x=>(x.split(",")(0),x.split(",")(1).toInt))
			.values
				.collect

## (Section 12/15) Récupérer les clés et les valeurs séparément keys-values
rddGroupByKeyMap.collect
rddGroupByKeyMap.keys.collect
rddGroupByKeyMap.values.collect

## (Section 13/15) VOIR LES RÉPARTITIONS AVEC LA MÉTHODE GLOM
val varReduce= sc.parallelize( 1 to 7, 2)
varReduce.collect 
varReduce.glom.collect 

## (Section 14/15) 3 actions (reduce, fold, collect)

// Démo reduce + collect
val varReduce= sc.parallelize( 1 to 7, 2)
varReduce.collect 
varReduce.glom.collect 
varReduce.reduce((x,y)=>x+y)

// Explications Démo reduce
// Array(1, 2, 3, 4, 5, 6, 7) 
// 1+2+3++++++

// iteration 1 : x=1, y=2, x+y=1+2 =3 ==> devient mon nouveau x,
// iteration 2 : x=3, y=3, x+y=3+3 =6 ==> devient mon nouveau x, 
// iteration 3 : x=6, y=4, x+y=6+4 =10 ==> devient mon nouveau x, etc..
// iteration 4 : x=10, y=5, x+y=10+5 =15 ==> devient mon nouveau x,
// iteration 5 : x=15, y=6, x+y=15+6 =21, ==> devient mon nouveau x,
// iteration 6 : x=21, y=7, x+y=21+7 =28, etc..
// résultat final : 28

// Démo fold
// CONTRAIREMENT À REDUCE QUI RASSEMBLE TOUS LES DONNÉES AVANT DE FAIRE LE CALCUL
// FOLD FAIT LE CALCUL AU NIVEAU DE CHAQUE NOEUD + LE PARMÈTRE ENTRE PARENTHÈSES

val varfold= sc.parallelize( 1 to 5, 2)
varfold.glom.collect 
varfold.fold(1)((x,y)=>x+y) ==> 18
varfold.reduce((x,y)=>x+y)	==> 15

// res3: Array[Array[Int]] = Array(Array(1, 2), Array(3, 4, 5))
// 1er noeud : 1+2 =3 +1(param du fold) = 4 
// 2eme noeud :3+4+5 = 12 +1(param du fold) =13 
// sur les les 2 noeuds : 4+ 13 +1(param du fold) = 18

## (Section 15/15) Exercices

// EXERCICE#1. Pouvez-vous expliquer la différence entre les transformations 
et les actions dans le contexte de Spark, en référence à votre fichier PDF joint ?

// EXERCICE#2. Quelles sont les distinctions entre les opérations 
flatMap et map dans Spark, et comment sont-elles utilisées dans le traitement des données ?

// EXERCICE#3. Pourquoi préférerions-nous utiliser reduceByKey plutôt que reduce dans l'exemple de WORDCOUNT ? 

### 3.1. Pouvez-vous expliquer la distinction entre les transformations et les actions dans 
le contexte de WordCount, en vous référant à votre fichier PDF joint ?

### 3.2. Quelles sont les différences entre les opérations flatMap et map dans le contexte de WordCount ?

### 3.3. Quelle est la différence entre reduceByKey et reduce, et pourquoi 
préférerions-nous utiliser reduceByKey dans l'exemple de WordCount ?

// EXERCICE#4. Comment appelle-t-on généralement la pratique consistant à enchaîner plusieurs 
appels de fonctions ou de méthodes dans une séquence, 
en prenant le résultat de l'appel précédent comme entrée 
pour produire un nouvel état ou résultat, notamment 
en programmation fonctionnelle ? Comment cette pratique, 
qui permet de construire des pipelines de traitement de données 
de manière concise et modulaire, est-elle couramment utilisée 
dans des frameworks comme Apache Spark pour manipuler des RDDs ou des DataFrames ?

// EXERCICE#6. Pouvez-vous explorer et expliquer l'utilisation 
de l'importation scala.util.Sorting._ en Scala ?

// EXERCICE#7. Pouvez-vous expliquer comment Spark effectue le calcul sur deux nœuds 
et différencie les opérations de fold et de reduce, 
en utilisant la première diapositive de l'introduction à Spark comme référence?
Pouvez-vous confirmer ou nier cette affirmation ?
Dans Spark, lorsqu'un calcul est effectué sur deux nœuds, 
chaque nœud traite une partie des données et effectue des calculs localement. 
La différence entre les opérations fold et reduce réside dans leur manière 
de traiter les données distribuées.

- reduce rassemble toutes les données sur un seul nœud avant d'effectuer le calcul. 
Cela peut entraîner des problèmes de performance avec de grandes quantités de données, 
car tout doit être transféré vers un seul nœud pour être traité.

- En revanche, fold effectue le calcul au niveau de chaque nœud, 
en parallèle. Chaque nœud combine ses résultats locaux avec le paramètre 
spécifié entre parenthèses pour produire un résultat global. 
Cela permet un traitement efficace des données distribuées, 
en minimisant les mouvements de données entre les nœuds.

Ainsi, fold est particulièrement adapté aux opérations 
où l'association des résultats intermédiaires sur chaque nœud 
est possible, ce qui peut conduire à une meilleure performance 
dans certaines situations par rapport à reduce.

Est-ce vrai ?