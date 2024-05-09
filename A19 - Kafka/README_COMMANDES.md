# Partie 1
Voici la liste des commandes avec des commentaires succincts pour votre atelier Kafka :

***********************************
**************ATELIER KAFKA********* 
***********************************

*****1- Démarrez ZOOKEEPER
```bash
# Démarrez le serveur Zookeeper pour la gestion des nœuds Kafka.
bin/zookeeper-server-start.sh config/zookeeper.properties 
```

*****2- Démarrez le serveur KAFKA 
```bash
# Démarrez le serveur Kafka pour le traitement des messages.
bin/kafka-server-start.sh config/server.properties
```

*****3- Création d'un premier topic (ouvrir CMD dans Windows)
```bash
# Créez un topic 'justine' pour stocker des messages.
./kafka-topics.sh --bootstrap-server localhost:9092 --topic justine --create --partitions 1 --replication-factor 1
```

*****4- Création de plusieurs topics (ouvrir CMD dans Windows)
```bash
# Créez plusieurs topics pour divers types de données.
./kafka-topics.sh --bootstrap-server localhost:9092 --topic myfirst --create --partitions 1 --replication-factor 1
./kafka-topics.sh --bootstrap-server localhost:9092 --topic mysecond --create --partitions 1 --replication-factor 1
./kafka-topics.sh --bootstrap-server localhost:9092 --topic mythird --create --partitions 1 --replication-factor 1
```

*****5- Lister les topics 
```bash
# Liste tous les topics disponibles dans Kafka.
./kafka-topics.sh --bootstrap-server localhost:9092 --list
```

*****6- Décrire un topic spécifique 
```bash
# Affiche les détails des topics spécifiques.
./kafka-topics.sh --bootstrap-server localhost:9092 --describe --topic justine
./kafka-topics.sh --bootstrap-server localhost:9092 --describe --topic myfirst
./kafka-topics.sh  --bootstrap-server localhost:9092 --describe --topic mysecond
./kafka-topics.sh --bootstrap-server localhost:9092 --describe --topic mythird
```

*****7- Création d'un 4ème topic avec un facteur de partition = 3 (ouvrir CMD dans Windows)
```bash
# Créez un topic 'myfourth' avec 3 partitions pour une meilleure distribution des données.
./kafka-topics.sh --bootstrap-server localhost:9092 --topic myfourth --create --partitions 3 --replication-factor 1
./kafka-topics.sh --bootstrap-server localhost:9092 --describe --topic myfourth
```

*****8- Création d'un 5ème topic avec un facteur de réplication = 3 (ouvrir CMD dans Windows)
```bash
# Créez un topic 'myfifth' avec un facteur de réplication de 3 pour la haute disponibilité.
kafka-topics --bootstrap-server localhost:9092 --topic myfifth --create --partitions 1 --replication-factor 3
```

***Toutes les commandes pour Windows
```bash
C:\HADOOP\kafka_2.12-3.5.0\bin\windows\zookeeper-server-start.bat C:\HADOOP\kafka_2.12-3.5.0\config\zookeeper.properties 
C:\HADOOP\kafka_2.12-3.5.0\bin\windows\kafka-server-start.bat C:\HADOOP\kafka_2.12-3.5.0\config\server.properties
kafka-topics --bootstrap-server localhost:9092 --topic justine --create --partitions 1 --replication-factor 1
kafka-topics --bootstrap-server localhost:9092 --topic myfirst --create --partitions 1 --replication-factor 1
kafka-topics --bootstrap-server localhost:9092 --topic mysecond --create --partitions 1 --replication-factor 1
kafka-topics --bootstrap-server localhost:9092 --topic mythird --create --partitions 1 --replication-factor 1
kafka-topics --bootstrap-server localhost:9092 --list
kafka-topics --bootstrap-server localhost:9092 --describe --topic justine
kafka-topics --bootstrap-server localhost:9092 --describe --topic myfirst
kafka-topics --bootstrap-server localhost:9092 --describe --topic mysecond
kafka-topics --bootstrap-server localhost:9092 --describe --topic mythird
```


# Partie2
D'accord, voici une liste étendue de commandes Kafka pour différents usages, sans explications :

```bash
# Démarrer Zookeeper
bin/zookeeper-server-start.sh config/zookeeper.properties 

# Démarrer le serveur Kafka
bin/kafka-server-start.sh config/server.properties

# Créer un topic 'justine'
./kafka-topics.sh --bootstrap-server localhost:9092 --topic justine --create --partitions 1 --replication-factor 1

# Créer plusieurs topics ('myfirst', 'mysecond', 'mythird')
./kafka-topics.sh --bootstrap-server localhost:9092 --topic myfirst --create --partitions 1 --replication-factor 1
./kafka-topics.sh --bootstrap-server localhost:9092 --topic mysecond --create --partitions 1 --replication-factor 1
./kafka-topics.sh --bootstrap-server localhost:9092 --topic mythird --create --partitions 1 --replication-factor 1

# Lister tous les topics
./kafka-topics.sh --bootstrap-server localhost:9092 --list

# Décrire un topic 'justine'
./kafka-topics.sh --bootstrap-server localhost:9092 --describe --topic justine
./kafka-topics.sh --bootstrap-server localhost:9092 --describe --topic myfirst
./kafka-topics.sh --bootstrap-server localhost:9092 --describe --topic mysecond
./kafka-topics.sh --bootstrap-server localhost:9092 --describe --topic mythird

# Créer un topic 'myfourth' avec 3 partitions
./kafka-topics.sh --bootstrap-server localhost:9092 --topic myfourth --create --partitions 3 --replication-factor 1
./kafka-topics.sh --bootstrap-server localhost:9092 --describe --topic myfourth

# Créer un topic 'myfifth' avec un facteur de réplication de 3
kafka-topics --bootstrap-server localhost:9092 --topic myfifth --create --partitions 1 --replication-factor 3

# Supprimer un topic 'myfifth'
kafka-topics --bootstrap-server localhost:9092 --topic myfifth --delete

# Modifier le facteur de réplication d'un topic
kafka-configs --bootstrap-server localhost:9092 --entity-type topics --entity-name myfourth --alter --add-config min.insync.replicas=2

# Lire des messages depuis le début d'un topic
kafka-console-consumer --bootstrap-server localhost:9092 --topic justine --from-beginning

# Lire des messages avec un décalage spécifique
kafka-console-consumer --bootstrap-server localhost:9092 --topic justine --offset 10 --partition 0

# Produire des messages dans un topic
kafka-console-producer --bootstrap-server localhost:9092 --topic justine

# Modifier les partitions d'un topic
kafka-topics --bootstrap-server localhost:9092 --topic myfourth --alter --partitions 5

# Obtenir des informations sur le groupe de consommateurs
kafka-consumer-groups --bootstrap-server localhost:9092 --list

# Décrire un groupe de consommateurs
kafka-consumer-groups --bootstrap-server localhost:9092 --describe --group my-consumer-group

# Réinitialiser l'offset d'un groupe de consommateurs
kafka-consumer-groups --bootstrap-server localhost:9092 --group my-consumer-group --reset-offsets --to-earliest --execute --topic justine

# Supprimer un groupe de consommateurs
kafka-consumer-groups --bootstrap-server localhost:9092 --delete --group my-consumer-group
```
# Partie 3
Bien sûr, voici d'autres commandes Kafka pour diverses opérations :

```bash
# Lister les groupes de consommateurs
kafka-consumer-groups --bootstrap-server localhost:9092 --list

# Réinitialiser les offsets pour un groupe de consommateurs à un horodatage spécifique
kafka-consumer-groups --bootstrap-server localhost:9092 --group my-consumer-group --reset-offsets --to-datetime 2024-05-10T12:00:00.000 --execute --topic justine

# Ajouter des partitions à un topic existant
kafka-topics --bootstrap-server localhost:9092 --alter --topic mysecond --partitions 3

# Supprimer tous les messages d'un topic sans supprimer le topic
kafka-topics --bootstrap-server localhost:9092 --delete --topic mythird --if-empty

# Créer un topic avec une configuration personnalisée
kafka-topics --bootstrap-server localhost:9092 --create --topic mycustom --partitions 2 --replication-factor 2 --config cleanup.policy=compact

# Lister toutes les configurations d'un topic
kafka-configs --bootstrap-server localhost:9092 --entity-type topics --entity-name mycustom --describe

# Modifier la configuration d'un topic existant
kafka-configs --bootstrap-server localhost:9092 --entity-type topics --entity-name mycustom --alter --add-config max.message.bytes=204800

# Supprimer une configuration spécifique d'un topic
kafka-configs --bootstrap-server localhost:9092 --entity-type topics --entity-name mycustom --alter --delete-config max.message.bytes

# Créer un consommateur pour lire des messages
kafka-console-consumer --bootstrap-server localhost:9092 --topic myfirst --from-beginning

# Lire des messages à partir d'un offset spécifique pour un topic
kafka-console-consumer --bootstrap-server localhost:9092 --topic mysecond --offset 5 --partition 0 --max-messages 10

# Écrire des messages dans un topic avec un producteur
kafka-console-producer --bootstrap-server localhost:9092 --topic mythird --property "parse.key=true" --property "key.separator=:"

# Créer un topic avec un temps de rétention spécifié
kafka-topics --bootstrap-server localhost:9092 --create --topic mytimed --partitions 1 --replication-factor 1 --config retention.ms=3600000

# Afficher les détails du cluster Kafka
kafka-broker-api-versions --bootstrap-server localhost:9092

# Migrer les partitions d'un topic vers d'autres brokers
kafka-reassign-partitions --bootstrap-server localhost:9092 --topics-to-move-json-file topics.json --broker-list "1,2,3" --generate
kafka-reassign-partitions --bootstrap-server localhost:9092 --reassignment-json-file reassignment.json --execute

# Lire des messages filtrés par une clé spécifique
kafka-console-consumer --bootstrap-server localhost:9092 --topic mycustom --property print.key=true --property key.separator="," --from-beginning
```
# Partie 4
Voici encore plus de commandes Kafka pour gérer divers aspects de vos topics et consommateurs :

```bash
# Lire des messages d'un topic en format avancé
kafka-console-consumer --bootstrap-server localhost:9092 --topic myfirst --formatter kafka.tools.DefaultMessageFormatter --property print.key=true --property key.separator="," --property print.timestamp=true

# Écrire des messages avec des clés et des valeurs sérialisées
kafka-console-producer --bootstrap-server localhost:9092 --topic mysecond --property "parse.key=true" --property "key.separator=," --property "key.serializer=org.apache.kafka.common.serialization.StringSerializer" --property "value.serializer=org.apache.kafka.common.serialization.StringSerializer"

# Vérifier l'état des brokers dans le cluster
kafka-broker-api-versions --bootstrap-server localhost:9092 --describe

# Récupérer les détails de tous les topics, y compris ceux internes
kafka-topics --bootstrap-server localhost:9092 --list --include-internal

# Supprimer un topic de manière forcée
kafka-topics --bootstrap-server localhost:9092 --delete --topic myfourth --force

# Créer un groupe de consommateurs et s'abonner à plusieurs topics
kafka-console-consumer --bootstrap-server localhost:9092 --group my-group --topic justine,myfirst,mysecond

# Désabonner un groupe de consommateurs de tous les topics
kafka-consumer-groups --bootstrap-server localhost:9092 --group my-group --reset-offsets --all-topics --execute

# Exporter les offsets d'un groupe de consommateurs vers un fichier
kafka-consumer-groups --bootstrap-server localhost:9092 --group my-group --export --to-file group-offsets.txt

# Importer les offsets d'un groupe de consommateurs à partir d'un fichier
kafka-consumer-groups --bootstrap-server localhost:9092 --group my-group --import --from-file group-offsets.txt --execute

# Ajouter une règle d'ACL pour un utilisateur spécifique sur un topic
kafka-acls --bootstrap-server localhost:9092 --add --allow-principal User:myuser --operation All --topic mycustom

# Retirer une règle d'ACL pour un utilisateur sur un topic
kafka-acls --bootstrap-server localhost:9092 --remove --deny-principal User:myuser --operation Write --topic mycustom

# Lister toutes les ACLs en vigueur sur le cluster
kafka-acls --bootstrap-server localhost:9092 --list

# Produire des messages dans un topic avec partitionnement manuel
kafka-console-producer --bootstrap-server localhost:9092 --topic mythird --property "partitioner.class=org.apache.kafka.clients.producer.internals.DefaultPartitioner" --property "key.serializer=org.apache.kafka.common.serialization.StringSerializer" --property "value.serializer=org.apache.kafka.common.serialization.StringSerializer"

# Afficher les statistiques d'utilisation du topic
kafka-topics --bootstrap-server localhost:9092 --describe --topic myfifth --unavailable-partitions
```
# Partie 5
Voici une autre série de commandes Kafka pour une gestion avancée et des diagnostics :

```bash
# Simuler une consommation de messages pour tester la performance
kafka-consumer-perf-test --bootstrap-server localhost:9092 --topic myfirst --fetch-size 1048576 --messages 10000 --threads 1

# Produire des messages en masse pour tester la performance
kafka-producer-perf-test --producer-props bootstrap.servers=localhost:9092 --topic mysecond --num-records 10000 --record-size 1000 --throughput -1

# Obtenir des métriques détaillées sur le broker
kafka-run-class kafka.tools.JmxTool --jmx-url service:jmx:rmi:///jndi/rmi://localhost:9999/jmxrmi --object-name kafka.server:type=BrokerTopicMetrics,name=MessagesInPerSec

# Copier des données entre deux clusters Kafka (MirrorMaker)
kafka-mirror-maker --consumer.config source-cluster-consumer.properties --producer.config target-cluster-producer.properties --whitelist ".*"

# Vérifier les délais de latence pour un topic
kafka-run-class kafka.tools.EndToEndLatency localhost:9092 mythird 500 100000

# Obtenir des informations sur les réplicas pour un topic
kafka-topics --bootstrap-server localhost:9092 --describe --topic myfourth --under-replicated-partitions

# Équilibrer les leaders de partitions entre les brokers
kafka-preferred-replica-election --bootstrap-server localhost:9092

# Trouver l'offset le plus ancien pour un topic et une partition
kafka-run-class kafka.tools.GetOffsetShell --broker-list localhost:9092 --topic myfifth --time -2 --partition 0

# Modifier la priorité des brokers pour les réplicas de topic
kafka-reassign-partitions --bootstrap-server localhost:9092 --reassignment-json-file reassignment.json --verify

# Créer un consumer pour consommer des messages avec un délai spécifique
kafka-console-consumer --bootstrap-server localhost:9092 --topic justine --max-messages 100 --timeout-ms 5000

# Supprimer un enregistrement spécifique d'un topic avec sa clé
kafka-delete-records --bootstrap-server localhost:9092 --offset-json '{"partitions": [{"topic": "mysecond", "partition": 0, "offset": 1}]}'

# Créer un topic avec un facteur de réplication et des partitions spécifiques
kafka-topics --bootstrap-server localhost:9092 --create --topic advancedtopic --partitions 4 --replication-factor 2 --config cleanup.policy=delete

# Exporter les statistiques du topic en format JSON pour des analyses
kafka-run-class kafka.tools.DumpLogSegments --files /path/to/logfile.log --print-data-log --deep-iteration --json
```
# Partie 6
Bien sûr, voici encore plus de commandes Kafka pour diverses opérations et diagnostics :

```bash
# Créer un snapshot des offsets actuels pour un groupe de consommateurs
kafka-consumer-groups --bootstrap-server localhost:9092 --group my-group --describe --members --verbose

# Supprimer un topic et ignorer le contrôle des erreurs
kafka-topics --bootstrap-server localhost:9092 --delete --topic mythird --if-exists

# Changer le propriétaire d'un groupe de consommateurs
kafka-consumer-groups --bootstrap-server localhost:9092 --group my-group --reset-offsets --to-offset 5 --execute

# Lister les brokers disponibles dans le cluster
kafka-broker-api-versions --bootstrap-server localhost:9092 --describe

# Émuler un scénario de haute latence pour les consommateurs
kafka-consumer-perf-test --bootstrap-server localhost:9092 --topic myfirst --messages 5000 --show-detailed-stats --reporting-interval 1000

# Configurer un délai maximal pour l'attente de messages par les consommateurs
kafka-console-consumer --bootstrap-server localhost:9092 --topic mysecond --max-messages 50 --timeout-ms 10000

# Exécuter une tâche administrative spécifique avec l'utilitaire kafka-admin-client
kafka-admin-client --bootstrap-server localhost:9092 --command-config /path/to/command.properties --operation describe-cluster

# Surveiller les topics pour une augmentation soudaine du volume des messages
kafka-topics --bootstrap-server localhost:9092 --watch --topic myfourth

# Créer un topic avec une stratégie de rétention basée sur la taille
kafka-topics --bootstrap-server localhost:9092 --create --topic sizebased --partitions 2 --replication-factor 1 --config retention.bytes=104857600

# Afficher les logs du broker pour un diagnostic rapide
kafka-logs --bootstrap-server localhost:9092 --describe --broker-id 1

# Reconfigurer le délai de rétention pour un topic existant
kafka-configs --bootstrap-server localhost:9092 --entity-type topics --entity-name myfifth --alter --add-config retention.ms=7200000

# Trouver les leaders de toutes les partitions pour un topic
kafka-topics --bootstrap-server localhost:9092 --describe --topic advancedtopic --unavailable-partitions

# Valider les modifications de configuration avant de les appliquer
kafka-configs --bootstrap-server localhost:9092 --entity-type topics --entity-name mycustom --validate-only --alter --add-config max.message.bytes=512000

# Mesurer le débit des producteurs pour un topic spécifique
kafka-producer-perf-test --topic mysecond --num-records 20000 --record-size 500 --throughput 1000 --producer-props bootstrap.servers=localhost:9092

# Rétablir un état précédent pour un groupe de consommateurs en utilisant un fichier de sauvegarde
kafka-consumer-groups --bootstrap-server localhost:9092 --group my-group --reset-offsets --from-file /path/to/backup-file.json --execute
```
# Partie 7
Voici une nouvelle série de commandes Kafka pour vous aider à gérer et surveiller vos systèmes Kafka :

```bash
# Purger les données d'un topic sans supprimer le topic lui-même
kafka-topics --bootstrap-server localhost:9092 --topic mycustom --purge-data

# Ajouter une configuration de compression pour un topic
kafka-configs --bootstrap-server localhost:9092 --entity-type topics --entity-name myfirst --alter --add-config compression.type=gzip

# Simuler un consommateur pour lire des messages avec un délai spécifié entre chaque message
kafka-console-consumer --bootstrap-server localhost:9092 --topic mythird --max-messages 100 --consumer-property fetch.min.bytes=50000 --consumer-property fetch.max.wait.ms=500

# Mettre à jour le niveau de log pour un broker Kafka
kafka-configs --bootstrap-server localhost:9092 --entity-type brokers --entity-name 1 --alter --add-config log4j.logger.kafka=DEBUG

# Afficher les métadonnées pour toutes les partitions d'un topic
kafka-topics --bootstrap-server localhost:9092 --describe --topic mysecond --report-over-under-replicated-partitions

# Créer un topic avec des options avancées pour la rétention et la suppression
kafka-topics --bootstrap-server localhost:9092 --create --topic myadvanced --partitions 3 --replication-factor 2 --config retention.ms=86400000 --config delete.retention.ms=600000 --config cleanup.policy=compact

# Tester la connectivité avec un cluster Kafka
kafka-verifiable-producer --bootstrap-server localhost:9092 --topic myfourth --max-messages 10

# Réinitialiser les offsets pour un groupe de consommateurs pour plusieurs topics simultanément
kafka-consumer-groups --bootstrap-server localhost:9092 --group my-group --reset-offsets --to-earliest --execute --topics justine,myfirst,mysecond

# Afficher les statistiques d'utilisation pour un broker spécifique
kafka-broker-api-versions --bootstrap-server localhost:9092 --describe --broker 1

# Simuler un scénario de charge élevée pour le producteur de messages
kafka-producer-perf-test --producer-props bootstrap.servers=localhost:9092 --topic sizebased --num-records 50000 --record-size 1024 --throughput 5000

# Récupérer et afficher les informations détaillées des consommateurs
kafka-consumer-groups --bootstrap-server localhost:9092 --group my-group --describe --state --members --verbose

# Déplacer un topic vers un autre ensemble de brokers
kafka-reassign-partitions --bootstrap-server localhost:9092 --topics-to-move-json-file topics-move.json --broker-list "2,3,4" --generate --execute

# Lire les messages d'un topic en respectant un schéma spécifique
kafka-avro-console-consumer --bootstrap-server localhost:9092 --topic myfifth --property schema.registry.url=http://localhost:8081 --from-beginning

# Supprimer une ACL pour un utilisateur sur tous les topics et groupes
kafka-acls --bootstrap-server localhost:9092 --remove --allow-principal User:anotheruser --operation All --topic '*' --group '*'

# Configurer la taille maximale des lots de messages pour un producteur
kafka-producer-perf-test --producer-props bootstrap.servers=localhost:9092 --topic myadvanced --num-records 10000 --record-size 500 --throughput 1000 --producer-property batch.size=16384
```
# Partie 8
Voici encore plus de commandes Kafka pour divers usages et configurations :

```bash
# Surveiller et afficher les statistiques des requêtes pour un topic
kafka-consumer-perf-test --bootstrap-server localhost:9092 --topic myfirst --fetch-size 1024 --messages 5000 --print-metrics

# Migrer les partitions d'un topic vers un broker spécifique pour l'équilibrage de charge
kafka-reassign-partitions --bootstrap-server localhost:9092 --reassignment-json-file migrate.json --execute

# Écrire des messages dans un topic en utilisant un format spécifique pour la clé et la valeur
kafka-console-producer --bootstrap-server localhost:9092 --topic mysecond --property parse.key=true --property key.serializer=org.apache.kafka.common.serialization.StringSerializer --property value.serializer=org.apache.kafka.common.serialization.StringSerializer

# Afficher les détails de la configuration d'un topic avec toutes les options configurées
kafka-configs --bootstrap-server localhost:9092 --entity-type topics --entity-name mythird --describe

# Créer un topic avec des ACLs pour restreindre l'accès
kafka-acls --bootstrap-server localhost:9092 --add --allow-principal User:myuser --operation Read --operation Write --topic myfourth

# Supprimer un broker du cluster Kafka en toute sécurité
kafka-cluster-manager --bootstrap-server localhost:9092 --delete-broker 5

# Surveiller le débit et la latence des producteurs pour un topic donné
kafka-producer-perf-test --producer-props bootstrap.servers=localhost:9092 --topic myfifth --num-records 20000 --record-size 100 --throughput 2000

# Vérifier et corriger les réplicas sous-répliqués pour un topic
kafka-topics --bootstrap-server localhost:9092 --describe --topic myadvanced --under-replicated-partitions

# Simuler un consommateur pour lire des messages d'un topic en respectant une stratégie de consommation particulière
kafka-console-consumer --bootstrap-server localhost:9092 --topic mycustom --property fetch.min.bytes=1024 --consumer-property enable.auto.commit=false

# Exporter les données d'un topic vers un fichier CSV pour analyse
kafka-run-class kafka.tools.ExportZkOffsets --zkconnect localhost:2181 --group my-group --topic justine --to-file topic_data.csv

# Réinitialiser les offsets d'un groupe de consommateurs à un offset spécifique pour chaque partition
kafka-consumer-groups --bootstrap-server localhost:9092 --group my-group --reset-offsets --to-offset 100 --topic myfirst:0,mysecond:1

# Surveiller en continu les changements de configuration pour un broker
kafka-configs --bootstrap-server localhost:9092 --entity-type brokers --entity-name 1 --watch

# Restaurer les données d'un topic à partir d'une sauvegarde précédente
kafka-topics --bootstrap-server localhost:9092 --create --topic myrestored --config-file /path/to/backup-config.properties

# Créer un consommateur pour simuler un retard de traitement des messages
kafka-console-consumer --bootstrap-server localhost:9092 --topic myfirst --group simulation-group --consumer-property fetch.max.wait.ms=1000 --max-messages 100
```
# Partie 9
Voici une série de commandes pour envoyer (produire) des messages dans un topic Kafka et pour recevoir (consommer) ces messages directement à partir de la ligne de commande, sans l'utilisation de programmes Python.

### Pour envoyer des messages dans un topic spécifique

```bash
# Envoyer un message simple dans un topic 'mytopic'
echo "Mon premier message" | kafka-console-producer --broker-list localhost:9092 --topic mytopic

# Envoyer plusieurs messages dans un topic 'mytopic'
echo -e "Message 1\nMessage 2\nMessage 3" | kafka-console-producer --broker-list localhost:9092 --topic mytopic

# Envoyer un message avec une clé spécifique dans un topic 'mytopic'
echo "clé1:Mon message avec clé" | kafka-console-producer --broker-list localhost:9092 --topic mytopic --property "parse.key=true" --property "key.separator=:"

# Envoyer des messages depuis un fichier dans un topic 'mytopic'
kafka-console-producer --broker-list localhost:9092 --topic mytopic < /path/to/message_file.txt

# Envoyer des messages en mode non bloquant (asynchrone) pour un débit élevé
kafka-producer-perf-test --producer-props bootstrap.servers=localhost:9092 --topic mytopic --num-records 10000 --record-size 100 --throughput -1
```

### Pour recevoir (consommer) des messages d'un topic spécifique

```bash
# Lire tous les messages d'un topic 'mytopic' depuis le début
kafka-console-consumer --bootstrap-server localhost:9092 --topic mytopic --from-beginning

# Lire les messages d'un topic 'mytopic' en temps réel (ne s'arrête pas après avoir lu les messages existants)
kafka-console-consumer --bootstrap-server localhost:9092 --topic mytopic

# Lire les messages d'un topic 'mytopic' et afficher la clé et le message
kafka-console-consumer --bootstrap-server localhost:9092 --topic mytopic --property print.key=true --property key.separator=" - "

# Lire un nombre spécifique de messages d'un topic 'mytopic' et s'arrêter
kafka-console-consumer --bootstrap-server localhost:9092 --topic mytopic --max-messages 10

# Lire les messages d'un topic 'mytopic' en limitant le délai d'attente maximal entre les messages
kafka-console-consumer --bootstrap-server localhost:9092 --topic mytopic --timeout-ms 5000
```

Ces commandes vous permettent de tester et de simuler des interactions avec vos topics Kafka directement à partir de la ligne de commande, facilitant ainsi le développement et le débogage sans l'intervention de scripts ou de programmes supplémentaires.

# Partie 10
Pour interagir avec plusieurs brokers Kafka pour envoyer et recevoir des messages, vous devez spécifier la liste des brokers lors de l'utilisation des commandes. Voici comment vous pouvez procéder :

### Envoyer des messages à un topic en spécifiant plusieurs brokers

```bash
# Envoyer un message dans un topic 'mytopic' en spécifiant plusieurs brokers
echo "Message pour plusieurs brokers" | kafka-console-producer --broker-list localhost:9092,localhost:9093,localhost:9094 --topic mytopic

# Envoyer plusieurs messages dans un topic 'mytopic' avec plusieurs brokers
echo -e "Message A\nMessage B\nMessage C" | kafka-console-producer --broker-list localhost:9092,localhost:9093,localhost:9094 --topic mytopic

# Envoyer un message avec une clé dans un topic 'mytopic' en utilisant plusieurs brokers
echo "clé2:Message avec clé pour plusieurs brokers" | kafka-console-producer --broker-list localhost:9092,localhost:9093,localhost:9094 --topic mytopic --property "parse.key=true" --property "key.separator=:"

# Envoyer des messages depuis un fichier vers un topic 'mytopic' en utilisant plusieurs brokers
kafka-console-producer --broker-list localhost:9092,localhost:9093,localhost:9094 --topic mytopic < /path/to/another_message_file.txt

# Envoyer des messages en masse pour tester la performance avec plusieurs brokers
kafka-producer-perf-test --producer-props bootstrap.servers=localhost:9092,localhost:9093,localhost:9094 --topic mytopic --num-records 5000 --record-size 500 --throughput 500
```

### Recevoir (consommer) des messages d'un topic en spécifiant plusieurs brokers

```bash
# Lire tous les messages d'un topic 'mytopic' depuis le début en utilisant plusieurs brokers
kafka-console-consumer --bootstrap-server localhost:9092,localhost:9093,localhost:9094 --topic mytopic --from-beginning

# Lire les messages d'un topic 'mytopic' en temps réel avec plusieurs brokers
kafka-console-consumer --bootstrap-server localhost:9092,localhost:9093,localhost:9094 --topic mytopic

# Lire les messages d'un topic 'mytopic', en affichant la clé et le message, en utilisant plusieurs brokers
kafka-console-consumer --bootstrap-server localhost:9092,localhost:9093,localhost:9094 --topic mytopic --property print.key=true --property key.separator=" : "

# Lire un nombre spécifique de messages d'un topic 'mytopic' avec plusieurs brokers et s'arrêter
kafka-console-consumer --bootstrap-server localhost:9092,localhost:9093,localhost:9094 --topic mytopic --max-messages 20

# Lire les messages d'un topic 'mytopic' avec un délai d'attente maximal spécifié en utilisant plusieurs brokers
kafka-console-consumer --bootstrap-server localhost:9092,localhost:9093,localhost:9094 --topic mytopic --timeout-ms 10000
```

Ces commandes vous permettent de simuler des interactions avec un cluster Kafka composé de plusieurs brokers, ce qui est essentiel pour tester des scénarios de tolérance aux pannes et de distribution de charge dans des environnements de production.
# Partie 11

Parfait, voici d'autres commandes pour continuer à explorer et à vous amuser avec Kafka en utilisant plusieurs brokers :

### Envoyer des messages à un topic en utilisant plusieurs brokers

```bash
# Envoyer un message JSON dans un topic 'mytopic' en spécifiant plusieurs brokers
echo '{"id": 1, "name": "John"}' | kafka-console-producer --broker-list localhost:9092,localhost:9093,localhost:9094 --topic mytopic

# Envoyer des messages avec des timestamps pour simuler des événements temporels
echo "timestamp1:$(date +%s):Event at $(date)" | kafka-console-producer --broker-list localhost:9092,localhost:9093,localhost:9094 --topic mytopic --property "parse.key=true" --property "key.separator=:"

# Envoyer des messages en boucle pour simuler un flux continu
for i in {1..100}; do echo "Message $i" | kafka-console-producer --broker-list localhost:9092,localhost:9093,localhost:9094 --topic mytopic; sleep 1; done

# Envoyer des messages complexes avec des clés et des valeurs structurées
echo "user1:{\"name\":\"Alice\",\"age\":30}" | kafka-console-producer --broker-list localhost:9092,localhost:9093,localhost:9094 --topic mytopic --property "parse.key=true" --property "key.separator=:"

# Envoyer des messages en utilisant la sérialisation Avro (nécessite un schéma)
kafka-avro-console-producer --broker-list localhost:9092,localhost:9093,localhost:9094 --topic myavrotopic --property schema.registry.url=http://localhost:8081 --property value.schema='{"type":"record","name":"User","fields":[{"name":"name","type":"string"}]}' <<EOF
{"name": "Bob"}
{"name": "Eve"}
EOF
```

### Recevoir (consommer) des messages d'un topic en utilisant plusieurs brokers

```bash
# Lire et afficher des messages JSON d'un topic 'mytopic' avec plusieurs brokers
kafka-console-consumer --bootstrap-server localhost:9092,localhost:9093,localhost:9094 --topic mytopic --from-beginning --formatter kafka.tools.DefaultMessageFormatter --property print.key=true --property key.separator=" : " --property value.deserializer=org.apache.kafka.common.serialization.StringDeserializer

# Lire les messages en spécifiant un groupe de consommateurs
kafka-console-consumer --bootstrap-server localhost:9092,localhost:9093,localhost:9094 --topic mytopic --group test-group

# Lire les messages en filtrant par clé spécifique
kafka-console-consumer --bootstrap-server localhost:9092,localhost:9093,localhost:9094 --topic mytopic --property print.key=true --property key.separator=" : " --include "user1"

# Lire les messages tout en surveillant les performances et la latence
kafka-consumer-perf-test --bootstrap-server localhost:9092,localhost:9093,localhost:9094 --topic mytopic --fetch-size 1048576 --messages 5000 --threads 1 --print-metrics

# Lire les messages d'un topic 'myavrotopic' en utilisant Avro pour la désérialisation
kafka-avro-console-consumer --bootstrap-server localhost:9092,localhost:9093,localhost:9094 --topic myavrotopic --property schema.registry.url=http://localhost:8081 --from-beginning
```

Ces commandes couvrent une variété de scénarios, y compris l'envoi et la réception de messages simples, structurés et sérialisés, ainsi que des tests de performance pour vous aider à comprendre et à maîtriser Kafka dans un environnement plus dynamique et réaliste.

