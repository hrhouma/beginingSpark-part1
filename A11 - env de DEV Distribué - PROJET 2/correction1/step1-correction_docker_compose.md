# Correction d'une erreur de port dans `docker-composev1.yaml`

## Contexte

Une erreur a été identifiée dans l'ancien fichier `docker-composev1.yaml` concernant la configuration des ports. Le port interne utilisé par le service `spark-master` n'était pas correct.

## Modification apportée

Dans `docker-composev1.yaml`, le port interne a été corrigé à `8080`. De plus, un réseau interne a été ajouté pour améliorer la connectivité entre les services Docker.

### Ancienne Configuration

```yaml
services:
  spark-master:
    image: pavansrivathsa/spark-master
    container_name: spark-master
    ports:
      - <port_externe>:<port_interne_incorrect>
```

### Nouvelle Configuration

```yaml
services:
  spark-master:
    image: pavansrivathsa/spark-master
    container_name: spark-master
    ports:
      - 3080:8080  # Correction du port interne
      - 7077:7077
    volumes:
      - shared-workspace:/opt/workspace
    networks:
      - localnet

networks:
  localnet:
    driver: bridge
    attachable: true
```

## Résumé

Cette correction permet d'assurer que le service `spark-master` utilise le port interne `8080`, tout en ajoutant un réseau interne pour une meilleure connectivité.

# Nouveau docker compose

```yaml
version: "3.6"

volumes:
  shared-workspace:
    name: "hadoop-distributed-file-system"
    driver: local

services:
  jupyterlab:
    image: pavansrivathsa/jupyterlab
    container_name: jupyterlab
    ports:
      - 4888:4888
      - 4040:4040
      - 8050:8050
    volumes:
      - shared-workspace:/opt/workspace

  spark-master:
    image: pavansrivathsa/spark-master
    container_name: spark-master
    ports:
      - 3080:8080
      - 7077:7077
    volumes:
      - shared-workspace:/opt/workspace
    networks:
      - localnet

  spark-worker-1:
    image: pavansrivathsa/spark-worker
    container_name: spark-worker-1
    environment:
      - SPARK_WORKER_CORES=1
      - SPARK_WORKER_MEMORY=512m
    ports:
      - 4081:8081
    volumes:
      - shared-workspace:/opt/workspace
    depends_on:
      - spark-master
    networks:
      - localnet

  spark-worker-2:
    image: pavansrivathsa/spark-worker
    container_name: spark-worker-2
    environment:
      - SPARK_WORKER_CORES=1
      - SPARK_WORKER_MEMORY=512m
    ports:
      - 4082:8081
    volumes:
      - shared-workspace:/opt/workspace
    depends_on:
      - spark-master
    networks:
      - localnet

  zookeeper:
    image: 'bitnami/zookeeper'
    hostname: zookeeper
    container_name: zookeeper
    ports:
      - 2181:2181
    environment:
      - ALLOW_ANONYMOUS_LOGIN=yes

  kafka:
    image: wurstmeister/kafka:2.12-2.5.0
    depends_on:
      - zookeeper
    ports:
      - 9092:9092
    environment:
      KAFKA_BROKER_ID: 1
      KAFKA_ZOOKEEPER_CONNECT: zookeeper:2181
      KAFKA_LISTENERS: INTERNAL://:29092,EXTERNAL://:9092
      KAFKA_ADVERTISED_LISTENERS: INTERNAL://localhost:29092,EXTERNAL://35.168.10.157:9092
      KAFKA_LISTENER_SECURITY_PROTOCOL_MAP: INTERNAL:PLAINTEXT,EXTERNAL:PLAINTEXT
      KAFKA_INTER_BROKER_LISTENER_NAME: INTERNAL
      KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR: 1

  nifi:
    image: apache/nifi:1.14.0
    hostname: NiFi
    ports:
      - 2080:2080
    environment:
      - NIFI_WEB_HTTP_PORT=2080
      - NIFI_CLUSTER_IS_NODE=true
      - NIFI_CLUSTER_NODE_PROTOCOL_PORT=2084
      - NIFI_ZK_CONNECT_STRING=zookeeper:2181
      - NIFI_ELECTION_MAX_WAIT=1min
      - NIFI_SENSITIVE_PROPS_KEY='12345678901234567890A'

  mongo:
    image: mongo
    restart: always
    ports:
      - 27017:27017

  mongo-express:
    image: mongo-express
    restart: always
    ports:
      - 4141:8081

networks:
  localnet:
    attachable: true

```
