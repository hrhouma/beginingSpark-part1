# Atelier Kafka sur Linux

Bienvenue à l'atelier Kafka sous Linux ! Ce guide vous aidera à configurer Kafka et à exécuter des opérations de base sur les topics. Veuillez exécuter ces commandes dans un terminal Linux.

## Prérequis

- Kafka doit être installé dans votre système.
- Assurez-vous que Java est correctement installé et configuré sur votre système.

## Configuration

### 1. Démarrer ZooKeeper
Pour démarrer ZooKeeper, utilisez la commande suivante :
```bash
# Démarrage de ZooKeeper
bin/zookeeper-server-start.sh config/zookeeper.properties
```

### 2. Démarrer le serveur Kafka
Une fois ZooKeeper en cours d'exécution, démarrez le serveur Kafka avec cette commande :
```bash
# Démarrage du serveur Kafka
bin/kafka-server-start.sh config/server.properties
```

## Gestion des Topics Kafka

### 3. Créer un Premier Topic
Pour créer un premier topic nommé `justine`, utilisez cette commande :
```bash
# Création d'un premier topic
./kafka-topics.sh --bootstrap-server localhost:9092 --topic justine --create --partitions 1 --replication-factor 1
```

### 4. Créer Plusieurs Topics
Créez plusieurs topics avec ces commandes :
```bash
# Création de plusieurs topics
./kafka-topics.sh --bootstrap-server localhost:9092 --topic myfirst --create --partitions 1 --replication-factor 1
./kafka-topics.sh --bootstrap-server localhost:9092 --topic mysecond --create --partitions 1 --replication-factor 1
./kafka-topics.sh --bootstrap-server localhost:9092 --topic mythird --create --partitions 1 --replication-factor 1
```

### 5. Lister Tous les Topics
Pour lister tous les topics sur le serveur :
```bash
# Lister tous les topics
./kafka-topics.sh --bootstrap-server localhost:9092 --list
```

### 6. Décrire des Topics Spécifiques
Pour obtenir des détails sur des topics spécifiques :
```bash
# Décrire des topics spécifiques
./kafka-topics.sh --bootstrap-server localhost:9092 --describe --topic justine
./kafka-topics.sh --bootstrap-server localhost:9092 --describe --topic myfirst
./kafka-topics.sh --bootstrap-server localhost:9092 --describe --topic mysecond
./kafka-topics.sh --bootstrap-server localhost:9092 --describe --topic mythird
```

### 7. Créer un Topic avec Plusieurs Partitions
Pour créer un topic `myfourth` avec trois partitions :
```bash
# Créer un topic avec plusieurs partitions
./kafka-topics.sh --bootstrap-server localhost:9092 --topic myfourth --create --partitions 3 --replication-factor 1
./kafka-topics.sh --bootstrap-server localhost:9092 --describe --topic myfourth
```

### 8. Créer un Topic avec un Facteur de Réplication Plus Élevé
Pour créer un topic `myfifth` avec un facteur de réplication de 3 :
```bash
# Créer un topic avec un facteur de réplication élevé
./kafka-topics.sh --bootstrap-server localhost:9092 --topic myfifth --create --partitions 1 --replication-factor 3
```

## Référence de Toutes les Commandes
Voici une référence rapide de toutes les commandes utilisées dans cet atelier :
```plaintext
# Référence rapide des commandes
bin/zookeeper-server-start.sh config/zookeeper.properties
bin/kafka-server-start.sh config/server.properties
./kafka-topics.sh --bootstrap-server localhost:9092 --topic justine --create --partitions 1 --replication-factor 1
./kafka-topics.sh --bootstrap-server localhost:9092 --topic myfirst --create --partitions 1 --replication-factor 1
./kafka-topics.sh --bootstrap-server localhost:9092 --topic mysecond --create --partitions 1 --replication-factor 1
./kafka-topics.sh --bootstrap-server localhost:9092 --topic mythird --create --partitions 1 --replication-factor 1
./kafka-topics.sh --bootstrap-server localhost:9092 --list
./kafka-topics.sh --bootstrap-server localhost:9092 --describe --topic justine


./kafka-topics.sh --bootstrap-server localhost:9092 --describe --topic myfirst
./kafka-topics.sh --bootstrap-server localhost:9092 --describe --topic mysecond
./kafka-topics.sh --bootstrap-server localhost:9092 --describe --topic mythird
./kafka-topics.sh --bootstrap-server localhost:9092 --describe --topic myfourth
./kafka-topics.sh --bootstrap-server localhost:9092 --describe --topic myfifth
```

