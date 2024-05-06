# Kafdrop

Kafdrop est une interface utilisateur web pour Apache Kafka, conçue pour faciliter la gestion et la surveillance des clusters Kafka. Avec Kafdrop, vous pouvez visualiser et gérer vos sujets, partitions, producteurs, consommateurs et messages dans un environnement Kafka.

## Fonctionnalités

- **Visualisation des sujets**: Parcourez les sujets Kafka, affichez leurs partitions, et obtenez des informations détaillées sur les réplicas.
- **Gestion des consommateurs**: Suivez l'état des consommateurs et des groupes de consommateurs, et surveillez leurs décalages.
- **Exploration des messages**: Parcourez les messages d'un sujet spécifique, avec des fonctionnalités de recherche et de filtrage.
- **Administration des partitions**: Analysez la répartition des partitions et l'état des réplicas dans vos clusters.
- **Configuration aisée**: Configurez facilement Kafdrop via des paramètres Java ou des variables d'environnement.

## Installation

### Conditions préalables
- Java 8 ou supérieur
- Apache Kafka

### Méthodes d'installation

#### Docker

La méthode recommandée est d'utiliser Docker. Pour démarrer Kafdrop, utilisez la commande suivante :

```bash
docker run -d -p 9000:9000 \
  -e KAFKA_BROKERCONNECT=<BROKER_URL>:<BROKER_PORT> \
  obsidiandynamics/kafdrop
```

Remplacez `<BROKER_URL>` et `<BROKER_PORT>` par l'adresse et le port de votre broker Kafka.

#### Binaire autonome

Vous pouvez également télécharger le binaire autonome de Kafdrop à partir du [dépôt GitHub](https://github.com/obsidiandynamics/kafdrop). Ensuite, lancez l'application avec la commande suivante :

```bash
java -jar kafdrop.jar --kafka.brokerConnect=<BROKER_URL>:<BROKER_PORT>
```

#### Compilation à partir du code source

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

Vous pouvez configurer Kafdrop à l'aide de variables d'environnement ou de paramètres Java. Voici quelques options de configuration clés :

- `KAFKA_BROKERCONNECT`: (Requis) L'adresse du broker Kafka.
- `SERVER_PORT`: Le port sur lequel Kafdrop sera accessible (par défaut: 9000).
- `ZOOKEEPER_CONNECT`: Adresse de Zookeeper si utilisée pour la gestion des consommateurs.
- `SCHEMAREGISTRY_URL`: URL du registre des schémas Avro.

## Utilisation

Une fois Kafdrop lancé, ouvrez votre navigateur et allez à `http://localhost:9000`. Vous accéderez alors à une interface vous permettant de :

- Explorer et gérer les sujets Kafka
- Visualiser les groupes de consommateurs et leurs décalages
- Explorer les messages dans les sujets

