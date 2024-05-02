# Kafka Setup with Docker on Amazon Linux 2023

## Prérequis
- Amazon Linux 2023
- Clé SSH pour accéder à la machine

## Étapes d'Installation

### **Partie (1/4) : Copier docker-compose.yml dans la machine Amazon Linux**
1. Connectez-vous à la machine en utilisant SSH :
   ```bash
   $ ssh -i "master.pem" ec2-user@35.175.171.81
   ```

2. Passez en mode superutilisateur et créez un répertoire pour le fichier docker-compose :
   ```bash
   $ sudo -s
   # cd /home/ec2-user/
   # mkdir docker_exp
   ```

3. Copiez le fichier `docker-compose.yml` dans le répertoire créé :
   ```bash
   # scp -i "master.pem" docker-compose.yml ec2-user@35.175.171.81:/home/ec2-user/docker_exp
   ```

### **Partie (2/4) : Installer Docker**
1. Mettez à jour les paquets de la machine :
   ```bash
   # yum update -y
   ```
   
2. Installez Docker :
   ```bash
   # yum install -y docker
   ```
   
3. Démarrez le service Docker :
   ```bash
   # sudo systemctl start docker
   ```
   
4. Vérifiez que Docker fonctionne correctement :
   ```bash
   # docker ps
   ```

### **Partie (3/4) : Installer Docker Compose**
1. Téléchargez la dernière version de Docker Compose :
   ```bash
   # sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
   ```
   
2. Rendre Docker Compose exécutable :
   ```bash
   # sudo chmod +x /usr/local/bin/docker-compose
   ```
   
3. Vérifiez l'installation de Docker Compose :
   ```bash
   # docker-compose version
   ```

### **Partie (4/4) : Déployer Kafka et Consommer des Messages**
1. Déployez les services Kafka à l'aide de `docker-compose` :
   ```bash
   # docker-compose up -d
   ```

2. Installez Python et configurez un environnement virtuel :
   ```bash
   # yum install -y python3
   # python3 -m venv kafka_env
   # source kafka_env/bin/activate
   # pip install kafka-python
   ```
   
3. Créez les scripts **producer** et **consumer** en utilisant les commandes suivantes :
   **Producer (producer.py)**
   ```python
   from kafka import KafkaProducer
   import json
   import time

   producer = KafkaProducer(
       bootstrap_servers=['localhost:19092', 'localhost:29092', 'localhost:39092'],
       value_serializer=lambda v: json.dumps(v).encode('utf-8')
   )

   for i in range(10):
       message = {'key': i, 'message': f'Hello Kafka {i}'}
       producer.send('test-topic', message)
       print(f'Sent: {message}')
       time.sleep(2)
   ```

   **Consumer (consumer.py)**
   ```python
   from kafka import KafkaConsumer
   import json

   consumer = KafkaConsumer(
       'test-topic',
       bootstrap_servers=['localhost:19092', 'localhost:29092', 'localhost:39092'],
       value_deserializer=lambda v: json.loads(v.decode('utf-8')),
       auto_offset_reset='earliest',
       enable_auto_commit=True,
       group_id='test-group'
   )

   for message in consumer:
       print(f'Received: {message.value}')
   ```
   
4. Exécutez les scripts producer et consumer :
   ```bash
   $ python producer.py
   $ python consumer.py
   ```

## Exemple de `docker-compose.yml`
Voici un exemple de fichier `docker-compose.yml` pour déployer Kafka :
```yaml
version: '3'
services:
  zookeeper:
    image: confluentinc/cp-zookeeper:latest
    container_name: zookeeper
    environment:
      ZOOKEEPER_CLIENT_PORT: 2181
      ZOOKEEPER_TICK_TIME: 2000
    ports:
      - "2181:2181"

  schema-registry:
    image: confluentinc/cp-schema-registry:latest
    hostname: schema-registry
    depends_on:
      - kafka-broker-1
      - kafka-broker-2
      - kafka-broker-3
    ports:
      - "8081:8081"
    environment:
      SCHEMA_REGISTRY_HOST_NAME: schema-registry
      SCHEMA_REGISTRY_KAFKASTORE_CONNECTION_URL: 'zookeeper:2181'
      SCHEMA_REGISTRY_LISTENERS: http://schema-registry:8081
      SCHEMA_REGISTRY_KAFKASTORE_BOOTSTRAP_SERVERS: PLAINTEXT://kafka-broker-2:9092,PLAINTEXT_INTERNAL://localhost:29092
      SCHEMA_REGISTRY_DEBUG: 'true'

  kafka-broker-1:
    image: confluentinc/cp-kafka:latest
    hostname: kafka-broker-1
    ports:
      - "19092:19092"
    depends_on:
      - zookeeper
    environment:
      KAFKA_BROKER_ID: 1
      KAFKA_ZOOKEEPER_CONNECT: 'zookeeper:2181'
      KAFKA_LISTENER_SECURITY_PROTOCOL_MAP: PLAINTEXT:PLAINTEXT,PLAINTEXT_INTERNAL:PLAINTEXT
      KAFKA_ADVERTISED_LISTENERS: PLAINTEXT://kafka-broker-1:9092,PLAINTEXT_INTERNAL://localhost:19092
      KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR: 3

  kafka-broker-2:
    image: confluentinc/cp-kafka:latest
    hostname: kafka-broker-2
    ports:
      - "29092:29092"
    depends_on:
      - zookeeper
    environment:
      KAFKA_BROKER_ID: 2
      KAFKA_ZOOKEEPER_CONNECT: 'zookeeper:2181'
      KAFKA_LISTENER_SECURITY_PROTOCOL_MAP: PLAINTEXT:PLAINTEXT,PLAINTEXT_INTERNAL:PLAINTEXT
      KAFKA_ADVERTISED_LISTENERS: PLAINTEXT://kafka-broker-2:9092,PLAINTEXT_INTERNAL://localhost:29092
      KAFKA_OFFSETS_TOPIC REPLICATION_FACTOR: 3

  kafka-broker-3:
    image: confluentinc/cp-kafka:latest
    hostname: kafka-broker-3
    ports:
      - "39092:39092"
    depends_on:
      - zookeeper
    environment:
      KAFKA_BROKER_ID: 3
      KAFKA_ZOOKEEPER_CONNECT: 'zookeeper:2181'
      KAFKA_LISTENER SECURITY_PROTOCOL_MAP: PLAINTEXT:PLAINTEXT,PLAINTEXT_INTERNAL:PLAINTEXT
      KAFKA_ADVERTISED LISTENERS: PLAINTEXT://kafka-broker-3:9092,PLAINTEXT_INTERNAL://localhost:39092
      KAFKA_OFFSETS_TOPIC REPLICATION FACTOR: 3
```
