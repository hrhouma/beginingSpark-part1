# Telegraf

- Pour installer et configurer Telegraf dans un projet Kafka-TIG, suivez ces étapes.

## Installation

### Docker

Pour installer Telegraf en utilisant Docker :

```bash
docker run -d \
  --name telegraf \
  -v /path/to/mytelegraf.conf:/etc/telegraf/telegraf.conf:ro \
  telegraf
```

### Binaire autonome

1. Téléchargez Telegraf depuis [le site officiel](https://portal.influxdata.com/downloads/).
2. Installez le package téléchargé en suivant les instructions spécifiques à votre système d'exploitation.
3. Modifiez le fichier de configuration `/etc/telegraf/telegraf.conf` selon vos besoins.

## Configuration

Voici un exemple de fichier `mytelegraf.conf` pour intégrer Telegraf avec InfluxDB et Kafka :

```toml
# Telegraf Configuration

# Agent Configuration
[agent]
  interval = "10s"
  round_interval = true
  metric_batch_size = 1000
  metric_buffer_limit = 10000

# Input Plugin - Kafka Consumer
[[inputs.kafka_consumer]]
  brokers = ["localhost:9092"]
  topics = ["states1", "states2"]
  consumer_group = "telegraf_consumer"
  offset = "oldest"

# Output Plugin - InfluxDB
[[outputs.influxdb_v2]]
  urls = ["http://localhost:8086"]
  token = "random_token"
  organization = "ORG"
  bucket = "system_state"
```

- **Input Plugin (kafka_consumer)**: Ce plugin lit les messages des sujets Kafka `states1` et `states2`.
- **Output Plugin (influxdb_v2)**: Les métriques sont envoyées à InfluxDB, où `bucket` fait référence à la base de données `system_state`.

## Exécution

Pour démarrer Telegraf :

- **Docker** : 
  ```bash
  docker start telegraf
  ```
- **Binaire autonome** :
  ```bash
  telegraf --config /path/to/mytelegraf.conf
  ```

## Surveillance

Surveillez les logs de Telegraf pour vérifier s'il collecte correctement les métriques :

```bash
docker logs -f telegraf
```

ou

```bash
tail -f /var/log/telegraf/telegraf.log
```

# Autres explications du fichier de configuration : 

- Décomposons chaque section de la configuration de Telegraf pour mieux comprendre :

### Agent Configuration

```toml
[agent]
  interval = "10s"
  round_interval = true
  metric_batch_size = 1000
  metric_buffer_limit = 10000
```

- **Agent**: L'agent est le cœur de Telegraf. Il orchestre la collecte et l'envoi des métriques en utilisant les plugins configurés.
- **interval**: Définit la fréquence de collecte des métriques. Ici, il est réglé sur `10s`, ce qui signifie que Telegraf collecte les métriques toutes les 10 secondes.
- **round_interval**: Lorsqu'il est défini sur `true`, cet attribut garantit que les collections se produisent à des intervalles précis, par exemple 00:00, 00:10, 00:20, etc.
- **metric_batch_size**: Le nombre maximal de métriques à envoyer en une seule fois. Ici, il est réglé sur 1000.
- **metric_buffer_limit**: Le nombre maximal de métriques qui peuvent être mises en mémoire tampon avant d'être envoyées aux plugins de sortie. Le réglage ici est de 10 000 métriques.

### Input Plugin - Kafka Consumer

```toml
[[inputs.kafka_consumer]]
  brokers = ["localhost:9092"]
  topics = ["states1", "states2"]
  consumer_group = "telegraf_consumer"
  offset = "oldest"
```

- **Input Plugins**: Les plugins d'entrée (input plugins) collectent des métriques à partir de diverses sources. Ici, `kafka_consumer` collecte les données de Kafka.
- **brokers**: Définit les brokers Kafka auxquels se connecter. `localhost:9092` signifie que Telegraf se connecte à un broker Kafka en local sur le port 9092.
- **topics**: La liste des sujets Kafka à partir desquels Telegraf collectera les données. Ici, il lit à partir de `states1` et `states2`.
- **consumer_group**: Spécifie le groupe de consommateurs Kafka auquel Telegraf appartient. Ici, c'est `telegraf_consumer`.
- **offset**: Spécifie à partir de quel offset les messages sont lus. `oldest` signifie que Telegraf commencera à lire les messages les plus anciens.

### Output Plugin - InfluxDB

```toml
[[outputs.influxdb_v2]]
  urls = ["http://localhost:8086"]
  token = "random_token"
  organization = "ORG"
  bucket = "system_state"
```

- **Output Plugins**: Les plugins de sortie (output plugins) envoient les métriques collectées vers une base de données ou un service de traitement. Ici, `influxdb_v2` envoie les données à InfluxDB.
- **urls**: Définit l'adresse URL de la base de données InfluxDB. Ici, il envoie les métriques à une instance InfluxDB s'exécutant localement sur le port 8086.
- **token**: Token d'authentification pour l'API InfluxDB. Le `random_token` est utilisé pour autoriser Telegraf à écrire des données dans InfluxDB.
- **organization**: Le nom de l'organisation InfluxDB dans laquelle les métriques sont écrites.
- **bucket**: Le bucket InfluxDB où les métriques seront stockées. Ici, c'est `system_state`.

- Chaque section de la configuration Telegraf est essentielle pour définir où et comment les métriques seront collectées et envoyées.


