# Kafka Setup with Docker on Amazon Linux 2023

# 1 -  Prérequis et étapes d'Installation
- Amazon Linux 2023
- Clé SSH pour accéder à la machine


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
 ```bash
# cd docker-exp
# docker-compose down
# rm -rf docker-compose.yaml
# nano docker-compose.yaml
 ```
### copier coller à partir du **point 2 -  docker-compose.yml

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

# 2 -  Exemple de `docker-compose.yml`
- Voici un exemple de fichier `docker-compose.yml` pour déployer Kafka :
- Référence : https://jskim1991.medium.com/docker-docker-compose-example-for-kafka-zookeeper-and-schema-registry-c516422532e7
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
# 3 -  Explications de al mécanique de notre `docker-compose.yml`

- Notre fichier YAML est un script Docker Compose. Docker Compose permet de définir et gérer plusieurs conteneurs dans un fichier de configuration unique.
- Dans ce fichier, nous configurons une infrastructure Kafka qui comprend plusieurs services.
- Voici une explication simplifiée :

### 1. **Zookeeper**:
Zookeeper est comme un annuaire téléphonique ou un chef d'orchestre. Il gère la coordination entre les serveurs Kafka (brokers) pour qu'ils fonctionnent en harmonie. 

- **Ports** : Zookeeper utilise le port 2181 pour la communication.

### 2. **Schema Registry**:
Schema Registry gère les schémas de données pour Kafka. Imaginez un traducteur qui s'assure que tout le monde comprend la même langue (le schéma).

- **Ports** : Utilise le port 8081 pour la communication.
- **Depends On** : Le Schema Registry dépend de Zookeeper et des trois brokers Kafka pour fonctionner correctement.

### 3. **Kafka Brokers (1, 2 et 3)**:
Les brokers Kafka sont comme des centres de tri postal. Ils reçoivent des messages de différents producteurs, les stockent et les distribuent aux consommateurs.

- **Ports** : Chaque broker a un port unique (19092, 29092, 39092) pour communiquer.
- **Depends On** : Chaque broker dépend de Zookeeper pour la coordination.
- **KAFKA_BROKER_ID** : Chaque broker a un identifiant unique (1, 2, 3).

### **Résumé**:
1. **Zookeeper** : Gère la coordination des brokers.
2. **Schema Registry** : Gère les schémas de données.
3. **Kafka Brokers** : Les brokers qui gèrent les messages.

En utilisant des exemples de la vie réelle :
- **Zookeeper** est le chef d'orchestre qui dirige l'ensemble.
- **Schema Registry** est le traducteur qui s'assure que tout le monde parle la même langue.
- **Kafka Brokers** sont les centres de tri postal qui réceptionnent, stockent et distribuent les messages.

# 4 - Mais attend !!! C'est quoi un broker ?

- Un broker, dans le contexte de Kafka, est un serveur qui gère le stockage et la distribution des messages. Pour simplifier :

### **Rôle du Broker**
1. **Stockage** : Le broker stocke les messages envoyés par les producteurs dans des sujets (topics) spécifiques. C'est comme une boîte aux lettres où les messages sont organisés.
   
2. **Distribution** : Il distribue ces messages aux consommateurs intéressés, un peu comme un facteur qui livre les lettres aux destinataires appropriés.

### **Comment Ça Marche**
- **Identification Unique** : Chaque broker a un identifiant unique (comme une adresse) pour pouvoir être distingué des autres brokers.
  
- **Réplication** : Les messages sont souvent copiés sur plusieurs brokers pour assurer une redondance (disponibilité), donc si un broker tombe en panne, les messages sont toujours disponibles.

- **Coordination** : Zookeeper aide à coordonner le travail entre les brokers pour qu'ils ne fassent pas d'erreurs, un peu comme un chef d'orchestre qui dirige une équipe.

### **Exemple de la Vie Réelle**
Imagine un centre de tri postal :
- **Messages** : Les lettres et colis sont les messages.
- **Brokers** : Les centres de tri sont les brokers, qui reçoivent, stockent et redistribuent les lettres.
- **Zookeeper** : Le responsable du centre (Zookeeper) veille à ce que les centres de tri fonctionnent bien ensemble.

- Le broker est donc un élément clé de Kafka, responsable de la gestion efficace des messages.

  # 5 - Explication détaillée de notre docker-compose avec des commentaires

- Ce fichier Docker Compose décrit une infrastructure Kafka avec les services suivants :

1. **Zookeeper** : Coordonne les brokers Kafka pour assurer une communication et une synchronisation efficaces.
2. **Schema Registry** : Gère les schémas de données, aidant les producteurs et les consommateurs à parler le même langage.
3. **Kafka Brokers (1, 2 et 3)** : Reçoivent, stockent et distribuent les messages, assurant la réplication pour garantir la redondance des données.

- L'ensemble constitue un environnement Kafka complet, permettant un traitement fiable des flux de données.

```yaml
version: '3'
# La version de la syntaxe Docker Compose à utiliser

services:
  zookeeper:
    # Configuration du service Zookeeper
    image: confluentinc/cp-zookeeper:latest
    # Utilisation de l'image Zookeeper officielle de Confluent
    container_name: zookeeper
    # Le conteneur sera nommé "zookeeper" pour faciliter son identification
    environment:
      # Variables d'environnement pour configurer Zookeeper
      ZOOKEEPER_CLIENT_PORT: 2181
      # Port client sur lequel Zookeeper écoute
      ZOOKEEPER_TICK_TIME: 2000
      # Intervalle de temps de tick pour Zookeeper, mesuré en millisecondes
    ports:
      - "2181:2181"
      # Mappage du port 2181 du conteneur au port 2181 de la machine hôte

  schema-registry:
    # Configuration du service Schema Registry
    image: confluentinc/cp-schema-registry:latest
    # Utilisation de l'image Schema Registry officielle de Confluent
    hostname: schema-registry
    # Le conteneur Schema Registry sera accessible via le nom d'hôte "schema-registry"
    depends_on:
      # Liste des services dont dépend Schema Registry
      - kafka-broker-1
      - kafka-broker-2
      - kafka-broker-3
      # Schema Registry dépend de ces trois brokers Kafka
    ports:
      - "8081:8081"
      # Mappage du port 8081 du conteneur au port 8081 de la machine hôte
    environment:
      # Variables d'environnement pour configurer Schema Registry
      SCHEMA_REGISTRY_HOST_NAME: schema-registry
      # Le nom d'hôte que Schema Registry utilisera
      SCHEMA_REGISTRY_KAFKASTORE_CONNECTION_URL: 'zookeeper:2181'
      # URL de connexion à Zookeeper
      SCHEMA_REGISTRY_LISTENERS: http://schema-registry:8081
      # Endroit où Schema Registry écoutera les demandes
      SCHEMA_REGISTRY_KAFKASTORE_BOOTSTRAP_SERVERS: PLAINTEXT://kafka-broker-2:9092,PLAINTEXT_INTERNAL://localhost:29092
      # Les brokers Kafka auxquels Schema Registry se connectera
      SCHEMA_REGISTRY_DEBUG: 'true'
      # Active le mode débogage pour Schema Registry

  kafka-broker-1:
    # Configuration du premier broker Kafka
    image: confluentinc/cp-kafka:latest
    # Utilisation de l'image Kafka officielle de Confluent
    hostname: kafka-broker-1
    # Le conteneur Kafka Broker 1 sera accessible via le nom d'hôte "kafka-broker-1"
    ports:
      - "19092:19092"
      # Mappage du port 19092 du conteneur au port 19092 de la machine hôte
    depends_on:
      # Liste des services dont dépend le broker
      - zookeeper
      # Le broker dépend de Zookeeper pour la coordination
    environment:
      # Variables d'environnement pour configurer le broker
      KAFKA_BROKER_ID: 1
      # Identifiant unique pour ce broker Kafka
      KAFKA_ZOOKEEPER_CONNECT: 'zookeeper:2181'
      # URL de connexion à Zookeeper
      KAFKA_LISTENER_SECURITY_PROTOCOL_MAP: PLAINTEXT:PLAINTEXT,PLAINTEXT_INTERNAL:PLAINTEXT
      # Définit les protocoles de sécurité pour les communications
      KAFKA_ADVERTISED_LISTENERS: PLAINTEXT://kafka-broker-1:9092,PLAINTEXT_INTERNAL://localhost:19092
      # Les points de connexion annoncés par ce broker
      KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR: 3
      # Réplication des données sur trois brokers pour la redondance

  kafka-broker-2:
    # Configuration du deuxième broker Kafka
    image: confluentinc/cp-kafka:latest
    # Utilisation de l'image Kafka officielle de Confluent
    hostname: kafka-broker-2
    # Le conteneur Kafka Broker 2 sera accessible via le nom d'hôte "kafka-broker-2"
    ports:
      - "29092:29092"
      # Mappage du port 29092 du conteneur au port 29092 de la machine hôte
    depends_on:
      # Liste des services dont dépend le broker
      - zookeeper
      # Le broker dépend de Zookeeper pour la coordination
    environment:
      # Variables d'environnement pour configurer le broker
      KAFKA_BROKER_ID: 2
      # Identifiant unique pour ce broker Kafka
      KAFKA_ZOOKEEPER_CONNECT: 'zookeeper:2181'
      # URL de connexion à Zookeeper
      KAFKA_LISTENER_SECURITY_PROTOCOL_MAP: PLAINTEXT:PLAINTEXT,PLAINTEXT_INTERNAL:PLAINTEXT
      # Définit les protocoles de sécurité pour les communications
      KAFKA_ADVERTISED_LISTENERS: PLAINTEXT://kafka-broker-2:9092,PLAINTEXT_INTERNAL://localhost:29092
      # Les points de connexion annoncés par ce broker
      KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR: 3
      # Réplication des données sur trois brokers pour la redondance

  kafka-broker-3:
    # Configuration du troisième broker Kafka
    image: confluentinc/cp-kafka:latest
    # Utilisation de l'image Kafka officielle de Confluent
    hostname: kafka-broker-3
    # Le conteneur Kafka Broker 3 sera accessible via le nom d'hôte "kafka-broker-3"
    ports:
      - "39092:39092"
      # Mappage du port 39092 du conteneur au port 39092 de la machine hôte
    depends_on:
      # Liste des services dont dépend le broker
      - zookeeper
      # Le broker dépend de Zookeeper pour la coordination
    environment:
      # Variables d'environnement pour configurer le broker
      KAFKA_BROKER_ID: 3
      # Identifiant unique pour ce broker Kafka
      KAFKA_ZOOKEEPER_CONNECT: 'zookeeper:2181'
      # URL de connexion à Zookeeper
      KAFKA_LISTENER_SECURITY_PROTOCOL_MAP: PLAINTEXT:PLAINTEXT,PLAINTEXT_INTERNAL:PLAINTEXT
      # Définit les protocoles de sécurité pour les communications
      KAFKA_ADVERTISED_LISTENERS: PLAINTEXT://kafka-broker-3:9092,PLAINTEXT_INTERNAL://localhost:39092
      # Les points de connexion annoncés par ce broker
      KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR: 3
      # Réplication des données sur trois brokers pour la redondance
```

 # 6 - Explication détaillée de notre producer.py et consumer.py
Les scripts `producer.py` et `consumer.py` fonctionnent avec l'environnement Kafka décrit dans le fichier Docker Compose précédent. Voici comment ils interagissent :

### **Producer (producer.py)**
1. **Connexion** : Le producteur se connecte aux trois brokers Kafka (`kafka-broker-1`, `kafka-broker-2` et `kafka-broker-3`) via les ports 19092, 29092, et 39092.
2. **Configuration** : Il utilise un sérialiseur pour convertir les messages en JSON.
3. **Envoi de messages** : Le producteur envoie 10 messages au sujet (topic) nommé `test-topic`. Chaque message est au format JSON et contient une clé et un message texte.
4. **Délai entre les messages** : Le producteur attend 2 secondes avant d'envoyer le message suivant.

### **Consumer (consumer.py)**
1. **Connexion** : Le consommateur se connecte également aux trois brokers Kafka via les mêmes ports.
2. **Configuration** : Il utilise un désérialiseur pour convertir les messages JSON en objets Python.
3. **Lecture de messages** : Il écoute les messages du sujet `test-topic` et les lit depuis le début (réinitialise les offsets avec `auto_offset_reset='earliest'`).
4. **Groupe de consommateurs** : Les messages sont lus dans le cadre d'un groupe de consommateurs nommé `test-group`.

### **Résumé du Processus**
- **Producer** : Le producteur envoie des messages à Kafka via les brokers.
- **Consumer** : Le consommateur lit ces messages du sujet `test-topic` et les affiche.

- Ce processus illustre le fonctionnement d'un pipeline de données Kafka simple, où un producteur publie des messages et un consommateur les lit et les traite.
  
 # 7 - Code avec les commentaires de producer.py et consumer.py

Voici une version commentée pour expliquer le code :

### **Producer (producer.py)**
```python
from kafka import KafkaProducer
# Importe la classe KafkaProducer pour envoyer des messages à Kafka

import json
import time
# Bibliothèques pour la manipulation des données JSON et la gestion du temps

# Création d'un producteur Kafka
producer = KafkaProducer(
    bootstrap_servers=['localhost:19092', 'localhost:29092', 'localhost:39092'],
    # Liste des brokers Kafka où le producteur va se connecter
    value_serializer=lambda v: json.dumps(v).encode('utf-8')
    # Sérialisation des données pour les convertir en JSON et les encoder en UTF-8
)

# Envoie de 10 messages
for i in range(10):
    # Création d'un message sous forme d'un dictionnaire Python
    message = {'key': i, 'message': f'Hello Kafka {i}'}
    
    # Envoi du message au sujet 'test-topic'
    producer.send('test-topic', message)
    
    # Affichage d'une confirmation d'envoi du message
    print(f'Sent: {message}')
    
    # Pause de 2 secondes avant d'envoyer le prochain message
    time.sleep(2)
```

### **Consumer (consumer.py)**
```python
from kafka import KafkaConsumer
# Importe la classe KafkaConsumer pour recevoir des messages de Kafka

import json
# Bibliothèque pour la manipulation des données JSON

# Création d'un consommateur Kafka
consumer = KafkaConsumer(
    'test-topic',
    # Sujet (topic) que le consommateur écoutera
    bootstrap_servers=['localhost:19092', 'localhost:29092', 'localhost:39092'],
    # Liste des brokers Kafka où le consommateur va se connecter
    value_deserializer=lambda v: json.loads(v.decode('utf-8')),
    # Désérialisation des données en JSON et décodage en UTF-8
    auto_offset_reset='earliest',
    # Lire les messages depuis le début du sujet
    enable_auto_commit=True,
    # Permet au consommateur de valider automatiquement le traitement des messages
    group_id='test-group'
    # Identifiant du groupe de consommateurs
)

# Lecture des messages du sujet
for message in consumer:
    # Affichage du message reçu
    print(f'Received: {message.value}')
```

### **Résumé des Scripts**
- **Producer (producer.py)** : 
  - Se connecte à un cluster Kafka et envoie 10 messages à un sujet (`test-topic`).
  - Chaque message contient une clé unique (`key`) et un texte (`message`).
  - Pause de 2 secondes entre l'envoi de chaque message.

- **Consumer (consumer.py)** :
  - Se connecte à un cluster Kafka et écoute les messages du sujet (`test-topic`).
  - Les messages sont affichés à mesure qu'ils sont reçus.

# 8 - Représentation schématique de l'architecture : 

- Voici une représentation simple pour montrer les relations entre les composants :

```
                  +--------------+                        +-------------------+
                  |              |----------------------->| Kafka Broker 1   |
                  |              |         +------------>| Port 19092        |
                  |              |         |             +-------------------+
                  |              |         |
                  |              |         |             +-------------------+
+---------------->|   Zookeeper  |---------+------------>| Kafka Broker 2   |
|                 |              |         |             | Port 29092        |
|   +-----------+ |              |         |             +-------------------+
|   | Producer  | |              |         |
|   +-----------+ |              |         |             +-------------------+
|                 |              |         +------------>| Kafka Broker 3   |
|                 +--------------+                       | Port 39092        |
|                                                       +-------------------+
|
|                                                       +-------------------+
|                                                       |   Schema Registry |
|                                                       | Port 8081         |
|                                                       +-------------------+
|
|       +-----------+                                   +-------------------+
+------>| Consumer  |---------------------------------->| 'test-topic'      |
        +-----------+                                   |                   |
                                                        +-------------------+

```

### **Explication**
1. **Zookeeper** : Coordonne les brokers Kafka et le Schema Registry.
2. **Kafka Brokers (1, 2, 3)** : Gèrent le stockage et la distribution des messages.
3. **Schema Registry** : Fournit des schémas pour les messages JSON.
4. **Producer** : Envoie des messages à un sujet (topic) Kafka.
5. **Consumer** : Lit les messages du sujet.

La communication se fait comme suit :
- **Producer** envoie les messages aux **Kafka Brokers** via Zookeeper.
- **Consumer** lit les messages du même sujet à partir des brokers.

Le **Schema Registry** maintient la structure des messages, assurant que les consommateurs comprennent les données du producteur.


# 9 - Représentation plus simple de l'architecture ?: 

+----------+                  +-----------------+
|          |                  |                 |
| Producer | +------------->  | Kafka Brokers   |
|          |                  | (Cluster)       |
+----------+                  |                 |
                              +-----------------+
                                     |
                                     |
                              +-----------------+
                              |                 |
                              | Schema Registry |
                              |                 |
                              +-----------------+
                                     |
                                     |
+----------+                  +-----------------+
|          |                  |                 |
| Consumer | <--------------- +-----------------+
|          |       
+----------+
