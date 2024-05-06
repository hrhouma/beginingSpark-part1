# Configuration de Kafka sur Ubuntu 22.04

## Introduction
Ce guide fournit des instructions détaillées pour configurer Kafka, Zookeeper et Docker sur une machine Ubuntu 22.04. Il couvre la copie du fichier Docker Compose, l'installation de Docker et Docker Compose, et la configuration de Kafka avec des clients Python.

## PARTIE (1/4) : Préparation du fichier docker-compose
1. Créez un répertoire pour stocker le fichier Docker Compose :
   ```sh
   sudo mkdir -p /opt/docker_exp
   ```

2. Placez votre fichier Docker Compose dans ce répertoire :
   ```sh
   sudo cp /path/to/docker-compose.yml /opt/docker_exp
   ```

## PARTIE (2/4) : Installer Docker méthode 1
 ```sh
su
#ou sudo -s
pwd
git clone https://github.com/hrhouma/install-docker.git
cd /install-docker/
chmod +x install-docker.sh
./install-docker.sh
#ou sh install-docker.sh
docker version
docker compose version
 ```


## PARTIE (3/4) : Installer Docker méthode 2
## Installer Docker 
1. Mettez à jour le système et installez les prérequis :
   ```sh
   sudo apt-get update
   sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
   ```

2. Ajoutez le dépôt officiel Docker et installez Docker :
   ```sh
   curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
   echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
   sudo apt-get update
   sudo apt-get install -y docker-ce
   ```

3. Démarrez le service Docker et vérifiez l'installation :
   ```sh
   sudo systemctl start docker
   sudo systemctl enable docker
   docker ps
   ```

## Installer Docker Compose
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
   cd /opt/docker_exp
   docker-compose up -d
   ```

2. Configurez un environnement virtuel Python et installez le client Kafka Python :
   ```sh
   sudo apt-get install -y python3 python3-venv python3-pip
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
       bootstrap_servers=['localhost:9092'],
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
       bootstrap_servers=['localhost:9092'],
       value_serializer=lambda v: json.dumps(v).encode('utf-8')
   )

   # Envoyer des messages à Kafka avec un délai entre chaque message
   for i in range 10):
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
