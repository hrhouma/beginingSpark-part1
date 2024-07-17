### Comment utiliser Docker pour tester interactivement Spark avec Scala ?
Voici un guide étape par étape pour créer une image Docker et exécuter les tests Spark à l'intérieur de cette image. Ce processus implique la création d'un `Dockerfile` qui définit l'environnement nécessaire pour exécuter Spark avec Scala, puis l'exécution d'un conteneur Docker basé sur cette image pour tester les scripts Scala.

### 1. Création du Dockerfile

Vous devez créer un `Dockerfile` qui va :

- Utiliser une image de base avec Spark et Scala installés. Pour cet exemple, nous utiliserons l'image `jupyter/pyspark-notebook` qui contient déjà Spark et permet d'exécuter des notebooks Jupyter. Bien que cette image soit orientée Python, Spark y est installé et peut être utilisé avec Scala via le terminal ou des notebooks Scala.
- Ajouter tout fichier nécessaire, comme vos fichiers de données (`test.txt`, `4300-0.txt`, `etudiants.txt`), dans l'image pour que Spark puisse y accéder.

Voici un exemple de `Dockerfile` :

```Dockerfile
# Utiliser l'image de base avec Jupyter et Spark préinstallés
FROM jupyter/pyspark-notebook

# Copier les fichiers de données dans l'image, ajustez les chemins selon vos fichiers
COPY test.txt /home/jovyan/test.txt
COPY 4300-0.txt /home/jovyan/4300-0.txt
COPY etudiants.txt /home/jovyan/etudiants.txt

# Exposer le port de Jupyter Notebook (optionnel, si vous souhaitez utiliser Jupyter)
EXPOSE 8888

# Commande pour démarrer le conteneur, ici on lance simplement le shell pour rester dans l'exemple interactif
CMD ["/bin/bash"]
```

### 2. Construire l'image Docker

Après avoir créé le `Dockerfile`, vous devez construire l'image Docker. Ouvrez un terminal, naviguez vers le répertoire où se trouve votre `Dockerfile` et exécutez la commande suivante :

```sh
docker build -t spark-scala-docker .
```

Cette commande construit une nouvelle image Docker nommée `spark-scala-docker` basée sur les instructions de votre `Dockerfile`.

### 3. Exécuter un conteneur Docker

Une fois l'image construite, vous pouvez lancer un conteneur Docker basé sur cette image :

```sh
docker run -it --name spark-test spark-scala-docker
docker ps
docker exec -it spark-test bash
spark-shell
```

Cette commande démarre un conteneur nommé `spark-test` à partir de l'image `spark-scala-docker` et vous donne accès à un terminal interactif à l'intérieur du conteneur.

### 4. Exécuter les tests Spark avec Scala

Dans le terminal de votre conteneur, vous pouvez maintenant démarrer `spark-shell` pour exécuter interactivement vos scripts Scala :

```sh
spark-shell
```

Une fois dans le shell Spark, vous pouvez exécuter les commandes Scala fournies pour tester les fonctionnalités de Spark RDD, telles que la création de RDDs, l'exécution de transformations et d'actions, etc.



### 5. Quitter spark-shell : 

Une fois que vous avez terminé de tester vos commandes, vous pouvez quitter `spark-shell` en tapant `:quit` et en appuyant sur Entrée.

```scala
:quit
```

### 6. Quitter le conteneur Docker et nettoyer

1. **Sortir du conteneur** : Tapez `exit` pour sortir du conteneur Docker. Cela vous ramènera à votre terminal local.

```sh
exit
```

2. **Supprimer tous les conteneurs** : Pour nettoyer et supprimer tous les conteneurs Docker (y compris ceux qui sont arrêtés), utilisez la commande suivante. Cela libérera les ressources en supprimant les conteneurs non nécessaires.

```sh
docker rm -f $(docker ps -a -q)
```

3. **Rédémarrer le conteneur pour de nouveaux tests** : Si vous souhaitez réexécuter le conteneur pour effectuer d'autres tests, lancez à nouveau le même conteneur Docker avec la commande suivante. Cela vous permet de démarrer un conteneur frais avec le même environnement Spark et Scala.

```sh
docker run -it --name spark-test spark-scala-docker
```

En suivant ces étapes, vous pouvez efficacement tester vos scripts Scala dans un environnement Spark, quitter et nettoyer votre environnement Docker, puis le redémarrer pour de nouveaux tests. C'est une excellente manière de fournir un environnement de développement et de test reproductible et isolé pour explorer Spark et Scala.


### Résumé

En suivant ces étapes, vous créez une image Docker personnalisée contenant Spark et Scala, vous permettant à  tester interactivement Spark dans un environnement isolé et facilement reproductible. Cette approche facilite la gestion des dépendances et assure que tous le monde travaille dans un environnement de développement cohérent.

