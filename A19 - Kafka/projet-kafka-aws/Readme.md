D'accord, voici un tutoriel étape par étape complet, avec tous les détails nécessaires pour configurer Kafka, Airflow, MongoDB, et un producteur Python dans un environnement Docker sur une instance AWS EC2.

### Prérequis

- Vous avez accès à une instance AWS EC2 avec Docker et Docker Compose installés.
- Les ports nécessaires sont ouverts dans votre groupe de sécurité AWS EC2 : 9092 pour Kafka, 8080 pour Airflow, 27017 pour MongoDB et 5432 pour PostgreSQL.

### Étape 1 : Création de votre fichier `docker-compose.yml`

Sur votre instance EC2, dans le répertoire de votre choix (que nous appellerons `my_project`), créez un fichier `docker-compose.yml` avec le contenu suivant :

```yaml
version: '3.8'
services:
  zookeeper:
    image: confluentinc/cp-zookeeper:latest
    environment:
      ZOOKEEPER_CLIENT_PORT: 2181
      ZOOKEEPER_TICK_TIME: 2000

  kafka:
    image: confluentinc/cp-kafka:latest
    depends_on:
      - zookeeper
    ports:
      - "9092:9092"
    environment:
      KAFKA_BROKER_ID: 1
      KAFKA_ZOOKEEPER_CONNECT: zookeeper:2181
      KAFKA_ADVERTISED_LISTENERS: PLAINTEXT://kafka:9092
      KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR: 1

  mongo:
    image: mongo:latest
    environment:
      MONGO_INITDB_ROOT_USERNAME: admin
      MONGO_INITDB_ROOT_PASSWORD: password
    ports:
      - "27017:27017"

  postgres:
    image: postgres:13
    environment:
      POSTGRES_USER: airflow
      POSTGRES_PASSWORD: airflow
      POSTGRES_DB: airflow
    ports:
      - "5432:5432"

  airflow-webserver:
    image: apache/airflow:2.2.3
    depends_on:
      - postgres
    environment:
      - AIRFLOW__CORE__SQL_ALCHEMY_CONN=postgresql+psycopg2://airflow:airflow@postgres/airflow
      - AIRFLOW__CORE__EXECUTOR=LocalExecutor
    ports:
      - "8080:8080"
    command: webserver

  airflow-scheduler:
    image: apache/airflow:2.2.3
    depends_on:
      - airflow-webserver
    environment:
      - AIRFLOW__CORE__SQL_ALCHEMY_CONN=postgresql+psycopg2://airflow:airflow@postgres/airflow
      - AIRFLOW__CORE__EXECUTOR=LocalExecutor

  airflow-init:
    image: apache/airflow:2.2.3
    depends_on:
      - postgres
    environment:
      - AIRFLOW__CORE__SQL_ALCHEMY_CONN=postgresql+psycopg2://airflow:airflow@postgres/airflow
    command: db init
```

### Étape 2 : Création du producteur Python Kafka

Dans le répertoire `my_project`, créez un sous-répertoire nommé `producer`.

Dans le répertoire `producer`, créez trois fichiers :

1. `Dockerfile` :
   ```Dockerfile
   FROM python:3.9
   WORKDIR /app
   COPY requirements.txt ./
   RUN pip install --no-cache-dir -r requirements.txt
   COPY producer.py .
   CMD ["python", "./producer.py"]
   ```

2. `requirements.txt` :
   ```
   confluent-kafka
   ```

3. `producer.py` (ce script suppose l'existence d'un fichier `data.csv` dans le même répertoire) :
   ```python
   from confluent_kafka import Producer
   import csv
   import os

   def delivery_report(err, msg):
       if err is not None:
           print('Message delivery failed: {}'.format(err))
       else:
           print('Message delivered to {} [{}]'.format(msg.topic(), msg.partition()))

   producer = Producer({
       'bootstrap.servers': 'kafka:9092',
       'client.id': 'producer-1'
   })

   with open('data.csv', 'r') as csvfile:
       csvreader = csv.reader(csvfile)
       next(csvreader)  # Skip header line
       for row in csvreader:
           producer.produce('my_topic', ','.join(row).encode('utf-8'), callback=delivery_report)
           producer.poll(0)

   producer.flush()
   ```

### Étape 3 : Mise à jour de `docker-compose.yml`

Ajoutez la définition du service `python-producer` à votre

 `docker-compose.yml` :

```yaml
  python-producer:
    build: ./producer
    depends_on:
      - kafka
    volumes:
      - ./producer:/app
    environment:
      KAFKA_BOOTSTRAP_SERVERS: "kafka:9092"
```

### Étape 4 : Lancement de vos services avec Docker Compose

Exécutez la commande suivante dans votre répertoire `my_project` pour lancer tous les services :

```bash
docker-compose up -d
```

### Étape 5 : Vérifiez que tout fonctionne correctement

Après avoir exécuté `docker-compose up`, utilisez les commandes suivantes pour vérifier que vos services sont opérationnels :

```bash
docker-compose ps
```

Pour vérifier les logs :

```bash
docker-compose logs
```

### Étape 6 : Accès à l'interface utilisateur d'Airflow

Ouvrez un navigateur et accédez à `http://<IP_Instance_AWS>:8080` pour voir l'interface utilisateur d'Airflow.

### Étape 7 : Interagir avec Kafka

Vous pouvez créer des topics, produire et consommer des messages en utilisant les commandes `docker-compose exec` comme décrit dans les messages précédents.

---

Ce guide vous mènera à travers le processus complet pour configurer un environnement de développement intégrant Kafka, Airflow, et MongoDB, et pour exécuter un script Python qui produit des messages dans un topic Kafka. Si vous avez des fichiers spécifiques (comme `data.csv`) que vous souhaitez inclure, ils doivent être placés dans le répertoire approprié et référencés correctement dans votre script Python.
