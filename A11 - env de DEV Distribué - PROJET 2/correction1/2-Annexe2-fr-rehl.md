# Configuration de Kafka sur Amazon Linux 2023

## Introduction
Ce guide fournit des instructions détaillées pour configurer Kafka, Zookeeper et Docker sur une machine Amazon Linux 2023. Il couvre la copie du fichier Docker Compose, l'installation de Docker et Docker Compose, et la configuration de Kafka avec des clients Python.

## PARTIE (1/4) : Copier docker-compose dans la MACHINE AMAZON LINUX 2023
1. Connectez-vous à votre machine Amazon Linux via SSH :
   ```sh
   ssh -i "master.pem" ec2-user@35.175.171.81 \
   -L 2081:localhost:2041 -L 4888:localhost:4888 \
   -L 2080:localhost:2080 -L 27017:localhost:27017 \
   -L 28017:localhost:28017 -L 8050:localhost:8050 \
   -L 4141:localhost:4141 -L 3880:localhost:3880
   ```

2. Passez en mode superutilisateur et créez un répertoire pour stocker le fichier Docker Compose :
   ```sh
   sudo -s
   cd /home/ec2-user/
   mkdir docker_exp
   ```

3. Copiez le fichier Docker Compose sur la machine Amazon Linux :
   ```sh
   scp -r -i "master.pem" docker-compose.yml \
   ec2-user@35.175.171.81:/home/ec2-user/docker_exp
   ```

## PARTIE (2/4) : Installer Docker
1. Mettez à jour le système et installez Docker :
   ```sh
   yum update
   yum install -y docker
   ```

2. Démarrez le service Docker et vérifiez l'installation :
   ```sh
   sudo systemctl start docker
   docker ps
   ```

## PARTIE (3/4) : Installer Docker Compose
1. Téléchargez et installez Docker Compose :
   ```sh
   sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
   sudo chmod +x /usr/local/bin/docker-compose
   ```

2. Vérifiez l'installation :
   ```sh
   docker-compose version
   ```

## PARTIE (4/4) : Configurer Kafka avec des clients Python
1. Démarrez les services Kafka en utilisant Docker Compose :
   ```sh
   docker-compose up -d
   ```

2. Configurez un environnement virtuel Python et installez le client Kafka Python :
   ```sh
   sudo yum install -y python3
   python3 -m venv kafka_env
   source kafka_env/bin/activate
   pip install kafka-python
   ```

3. Créez un consommateur Kafka (`consumer.py`) :
   ```python
   from kafka import KafkaConsumer
   import json

   # Initialiser le consommateur
   consumer = KafkaConsumer(
       'test-topic',
       bootstrap_servers=['localhost:19092', 'localhost:29092', 'localhost:39092'],
       value_deserializer=lambda v: json.loads(v.decode('utf-8')),
       auto_offset_reset='earliest',
       enable_auto_commit=True,
       group_id='test-group'
   )

   # Consommer les messages
   for message in consumer:
       print(f'Received: {message.value}')
   ```

4. Créez un producteur Kafka (`producer.py`) :
   ```python
   from kafka import KafkaProducer
   import json
   import time

   # Configurer le producteur Kafka
   producer = KafkaProducer(
       bootstrap_servers=['localhost:19092', 'localhost:29092', 'localhost:39092'],
       value_serializer=lambda v: json.dumps(v).encode('utf-8')
   )

   # Envoyer des messages à Kafka avec un délai entre chaque message
   for i in range(10):
       message = {'key': i, 'message': f'Hello Kafka {i}'}
       producer.send('test-topic', message)
       print(f'Sent: {message}')
       time.sleep(2)  # Introduire un délai de 2 secondes

   # Assurer l'envoi de tous les messages
   producer.flush()
   ```

5. Exécutez le producteur et le consommateur :
   ```sh
   python producer.py
   python consumer.py
   ```

## Référence
- [Exemple de Docker Compose pour Kafka, Zookeeper, et Schema Registry](https://jskim1991.medium.com/docker-docker-compose-example-for-kafka-zookeeper-and-schema-registry-c516422532e7)
