# Kafdrop

- Kafdrop est une interface utilisateur web pour Apache Kafka, conçue pour faciliter la gestion et la surveillance des clusters Kafka. 
- Elle sert d'interface visuelle intuitive pour observer et interagir avec les composants essentiels d'un environnement Kafka.

## Concepts clés de Kafka

- Avant de plonger dans Kafdrop, il est utile de comprendre certains concepts fondamentaux de Kafka :

- **Broker**: Un serveur Kafka individuel qui gère le stockage et la transmission des messages.
- **Cluster**: Un ensemble de brokers Kafka qui travaillent ensemble.
- **Sujet (Topic)**: Un flux de données sur Kafka. Les sujets permettent d'organiser les messages en catégories.
- **Partition**: Division logique d'un sujet, ce qui permet la parallélisation du traitement.
- **Producteur**: Les applications ou services qui publient des messages dans les sujets Kafka.
- **Consommateur**: Les applications ou services qui lisent les messages depuis les sujets Kafka.
- **Groupe de consommateurs**: Un ensemble de consommateurs travaillant ensemble pour traiter des partitions distinctes.

## Fonctionnalités de Kafdrop

- Kafdrop fournit une interface utilisateur pour visualiser et gérer ces concepts clés :

- **Visualisation des sujets et des partitions**: Voir les partitions associées à chaque sujet, les réplicas, et le leader actuel de chaque partition.
- **Gestion des consommateurs et des groupes de consommateurs**: Suivre le décalage des consommateurs et l'état des groupes de consommateurs.
- **Exploration des messages**: Parcourir les messages dans les sujets, filtrer par clé ou valeur, et afficher les détails du message.
- **Administration des partitions**: Examiner la répartition des partitions et vérifier leur état de réplication.

## Pourquoi utiliser Kafdrop ?

- Kafka est une plateforme de streaming puissante, mais la gestion et la surveillance de ses composants peuvent être complexes.
- Kafdrop offre les avantages suivants :

- **Facilité d'utilisation**: Une interface graphique simple pour naviguer dans les sujets, partitions et consommateurs.
- **Diagnostique**: Permet d'identifier les problèmes potentiels dans le traitement des messages, comme les décalages élevés des consommateurs.
- **Exploration des messages**: Un accès facile aux messages bruts pour des analyses plus approfondies.
- **Réduction du temps de configuration**: Des installations rapides grâce aux paramètres Java et Docker.

## Installation

### Docker

La méthode la plus simple pour utiliser Kafdrop est avec Docker :

```bash
docker run -d -p 9000:9000 \
  -e KAFKA_BROKERCONNECT=<BROKER_URL>:<BROKER_PORT> \
  obsidiandynamics/kafdrop
```

### Binaire autonome

Vous pouvez également télécharger le binaire autonome depuis le [dépôt GitHub](https://github.com/obsidiandynamics/kafdrop), et le lancer avec :

```bash
java -jar kafdrop.jar --kafka.brokerConnect=<BROKER_URL>:<BROKER_PORT>
```

### Compilation à partir du code source

Pour compiler Kafdrop vous-même :

1. Clonez le dépôt GitHub :
   ```bash
   git clone https://github.com/obsidiandynamics/kafdrop.git
   ```
2. Compilez le projet avec Maven :
   ```bash
   mvn clean package
   ```
3. Lancez l'application :
   ```bash
   java -jar target/kafdrop-*.jar --kafka.brokerConnect=<BROKER_URL>:<BROKER_PORT>
   ```

## Configuration

Kafdrop peut être configuré à l'aide de variables d'environnement ou d'arguments Java. Les options clés comprennent :

- `KAFKA_BROKERCONNECT`: L'adresse du broker Kafka.
- `SERVER_PORT`: Le port sur lequel Kafdrop sera accessible (par défaut: 9000).
- `ZOOKEEPER_CONNECT`: Adresse de Zookeeper pour les consommateurs.
- `SCHEMAREGISTRY_URL`: URL du registre des schémas Avro.

## Contribution

Kafdrop est un projet open-source accueillant les contributions. Pour plus de détails, consultez les [instructions de contribution](https://github.com/obsidiandynamics/kafdrop/blob/master/CONTRIBUTING.md).

## Licence

Kafdrop est distribué sous licence Apache 2.0.
