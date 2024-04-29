# Atelier Kafka sur Windows

- Bienvenue à l'atelier Kafka ! Ce guide vous aidera à configurer Kafka sur une machine Windows et à réaliser des opérations de base avec les topics. 
- Assurez-vous d'exécuter ces commandes dans l'Invite de commandes.
- Théorie : https://drive.google.com/drive/folders/1mlmSfboVO8VRhFRiO0bol0AlnHgCMBQI?usp=sharing
## Prérequis

- Kafka doit être installé dans le répertoire `C:\HADOOP\kafka_2.12-3.5.0`.
- Assurez-vous que Java est correctement installé et configuré sur votre système.

## Configuration

### 1. Démarrer ZooKeeper
Pour démarrer ZooKeeper, utilisez la commande suivante :
```bat
:: Démarrage de ZooKeeper
C:\HADOOP\kafka_2.12-3.5.0\bin\windows\zookeeper-server-start.bat C:\HADOOP\kafka_2.12-3.5.0\config\zookeeper.properties
```

### 2. Démarrer le serveur Kafka
Une fois que ZooKeeper est opérationnel, démarrez le serveur Kafka avec cette commande :
```bat
:: Démarrage du serveur Kafka
C:\HADOOP\kafka_2.12-3.5.0\bin\windows\kafka-server-start.bat C:\HADOOP\kafka_2.12-3.5.0\config\server.properties
```

## Gestion des Topics Kafka

### 3. Créer un Topic Simple
Pour créer un seul topic nommé `justine`, utilisez la commande suivante :
```bat
:: Création d'un topic simple
kafka-topics --bootstrap-server localhost:9092 --topic justine --create --partitions 1 --replication-factor 1
```

### 4. Créer Plusieurs Topics
Créez plusieurs topics avec ces commandes :
```bat
:: Création de plusieurs topics
kafka-topics --bootstrap-server localhost:9092 --topic myfirst --create --partitions 1 --replication-factor 1
kafka-topics --bootstrap-server localhost:9092 --topic mysecond --create --partitions 1 --replication-factor 1
kafka-topics --bootstrap-server localhost:9092 --topic mythird --create --partitions 1 --replication-factor 1
```

### 5. Lister Tous les Topics
Pour lister tous les topics sur le serveur :
```bat
:: Lister tous les topics
kafka-topics --bootstrap-server localhost:9092 --list
```

### 6. Décrire des Topics Spécifiques
Pour obtenir des détails sur des topics spécifiques :
```bat
:: Décrire des topics spécifiques
kafka-topics --bootstrap-server localhost:9092 --describe --topic justine
kafka-topics --bootstrap-server localhost:9092 --describe --topic myfirst
kafka-topics --bootstrap-server localhost:9092 --describe --topic mysecond
kafka-topics --bootstrap-server localhost:9092 --describe --topic mythird
```

### 7. Créer un Topic avec Plusieurs Partitions
Pour créer un topic `myfourth` avec trois partitions :
```bat
:: Créer un topic avec plusieurs partitions
kafka-topics --bootstrap-server localhost:9092 --topic myfourth --create --partitions 3 --replication-factor 1
kafka-topics --bootstrap-server localhost:9092 --describe --topic myfourth
```

### 8. Créer un Topic avec un Facteur de Réplication Plus Élevé
Pour créer un topic `myfifth` avec un facteur de réplication de 3 :
```bat
:: Créer un topic avec un facteur de réplication élevé
kafka-topics --bootstrap-server localhost:9092 --topic myfifth --create --partitions 1 --replication-factor 3
```

## Référence de Toutes les Commandes
Voici une référence rapide de toutes les commandes utilisées dans cet atelier :
```plaintext
:: Référence rapide des commandes
C:\HADOOP\kafka_2.12-3.5.0\bin\windows\zookeeper-server-start.bat C:\HADOOP\kafka_2.12-3.5.0\config\zookeeper.properties
C:\HADOOP\kafka_2.12-3.5.

0\bin\windows\kafka-server-start.bat C:\HADOOP\kafka_2.12-3.5.0\config\server.properties
kafka-topics --bootstrap-server localhost:9092 --topic justine --create --partitions 1 --replication-factor 1
kafka-topics --bootstrap-server localhost:9092 --topic myfirst --create --partitions 1 --replication-factor 1
kafka-topics --bootstrap-server localhost:9092 --topic mysecond --create --partitions 1 --replication-factor 1
kafka-topics --bootstrap-server localhost:9092 --topic mythird --create --partitions 1 --replication-factor 1
kafka-topics --bootstrap-server localhost:9092 --list
kafka-topics --bootstrap-server localhost:9092 --describe --topic justine
kafka-topics --bootstrap-server localhost:9092 --describe --topic myfirst
kafka-topics --bootstrap-server localhost:9092 --describe --topic mysecond
kafka-topics --bootstrap-server localhost:9092 --describe --topic mythird
kafka-topics --bootstrap-server localhost:9092 --describe --topic myfourth
kafka-topics --bootstrap-server localhost:9092 --describe --topic myfifth
```

