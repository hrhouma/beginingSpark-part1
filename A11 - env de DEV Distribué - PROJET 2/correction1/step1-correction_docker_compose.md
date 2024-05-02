# 1 - Correction d'une erreur de port dans `docker-composev1.yaml`

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

# 2 - Nouveau docker compose

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

# 3 - Description du docker-compose

Voici un résumé et une explication du fichier `docker-compose` fourni :

### Version
- `version: "3.6"` : Spécifie la version du format du fichier Docker Compose.

### Volumes
- `shared-workspace` : Un volume nommé avec le pilote configuré sur `local`, utilisé pour partager les données entre les différents services. Le nom attribué est `"hadoop-distributed-file-system"`.

### Services
#### JupyterLab
- **Image** : `pavansrivathsa/jupyterlab`
- **Ports** : `4888:4888`, `4040:4040`, `8050:8050` - Expose JupyterLab et ses services associés sur l'hôte.
- **Volumes** : Partage le volume `shared-workspace` pour la persistance des données.

#### Spark Master
- **Image** : `pavansrivathsa/spark-master`
- **Ports** : `3080:8080` pour l'interface web, `7077:7077` pour la communication Spark.
- **Volumes** : Partage le volume `shared-workspace`.
- **Réseaux** : Connecté au réseau `localnet`.

#### Spark Worker 1
- **Image** : `pavansrivathsa/spark-worker`
- **Ports** : `4081:8081` pour la communication Spark.
- **Volumes** : Partage le volume `shared-workspace`.
- **Environnement** : Configure les cœurs et la mémoire du worker.
- **Depends On** : `spark-master` pour s'assurer qu'il démarre après le master.
- **Réseaux** : Connecté au `localnet`.

#### Spark Worker 2
- **Image** : `pavansrivathsa/spark-worker`
- **Ports** : `4082:8081` pour la communication Spark.
- **Volumes** : Partage le volume `shared-workspace`.
- **Environnement** : Configure les cœurs et la mémoire du worker.
- **Depends On** : `spark-master` pour s'assurer qu'il démarre après le master.
- **Réseaux** : Connecté au `localnet`.

#### Zookeeper
- **Image** : `bitnami/zookeeper`
- **Nom d'hôte** : `zookeeper`
- **Ports** : `2181:2181` pour le port client par défaut de Zookeeper.
- **Environnement** : Permet la connexion anonyme pour faciliter les tests.

#### Kafka
- **Image** : `wurstmeister/kafka:2.12-2.5.0`
- **Depends On** : `zookeeper` pour s'assurer que Kafka démarre après Zookeeper.
- **Ports** : `9092:9092` pour exposer Kafka à l'extérieur.
- **Environnement** : Configure Kafka avec divers paramètres pour l'ID du broker, les auditeurs, les auditeurs annoncés, la connexion Zookeeper et les facteurs de réplication.

#### NiFi
- **Image** : `apache/nifi:1.14.0`
- **Nom d'hôte** : `NiFi`
- **Ports** : `2080:2080` pour l'interface utilisateur NiFi.
- **Environnement** : Configure NiFi comme faisant partie d'un cluster et le connecte à Zookeeper.

#### Mongo
- **Image** : `mongo`
- **Ports** : `27017:27017` pour le port par défaut de MongoDB.
- **Restart** : Toujours pour s'assurer que le conteneur redémarre en cas d'échec.

#### Mongo Express
- **Image** : `mongo-express`
- **Ports** : `4141:8081` pour exposer l'interface web Mongo Express.
- **Restart** : Toujours pour s'assurer que le conteneur redémarre en cas d'échec.

### Réseaux
- `localnet` : Un réseau attachable qui permet aux conteneurs de communiquer directement entre eux.

- Cette configuration met en place un environnement complet pour le traitement des données, incluant Spark pour le traitement des données, Kafka pour la messagerie, Zookeeper pour la coordination, MongoDB pour le stockage, ainsi que des outils comme JupyterLab et NiFi pour l'analyse et l'orchestration des flux de données.

# 4 - Accès : 

- Pour accéder aux différents services à l'intérieur et à l'extérieur du réseau Docker, vous pouvez utiliser les adresses et ports suivants :

## 4-1 - Accès depuis l'extérieur (hôte)
- **JupyterLab** : Accessible via `http://localhost:4888` ou `http://IP:4888`, `http://localhost:4040`, ou `http://localhost:8050` en fonction des ports spécifiques.
- **Spark Master** : Accessible via `http://localhost:3080` pour le Web UI.
- **Spark Worker 1** : Accessible via `http://localhost:4081`.
- **Spark Worker 2** : Accessible via `http://localhost:4082`.
- **Zookeeper** : Accessible via `localhost:2181`.
- **Kafka** : Accessible via `localhost:9092`.
- **NiFi** : Accessible via `http://localhost:2080`.
- **MongoDB** : Accessible via `localhost:27017`.
- **Mongo Express** : Accessible via `http://localhost:4141`.

## 4-2 - Accès depuis l'intérieur (entre conteneurs Docker)
Pour accéder aux services entre conteneurs Docker, utilisez leurs noms d'hôte respectifs :

- **JupyterLab** : Utilisez `http://jupyterlab:4888`, `http://jupyterlab:4040`, ou `http://jupyterlab:8050`.
- **Spark Master** : Utilisez `http://spark-master:8080`.
- **Spark Worker 1** : Utilisez `http://spark-worker-1:8081`.
- **Spark Worker 2** : Utilisez `http://spark-worker-2:8081`.
- **Zookeeper** : Connectez-vous sur `zookeeper:2181`.
- **Kafka** : Utilisez `kafka:9092`.
- **NiFi** : Utilisez `http://nifi:2080`.
- **MongoDB** : Utilisez `mongo:27017`.
- **Mongo Express** : Utilisez `http://mongo-express:8081`.

- Les ports indiqués à l'intérieur du réseau sont les ports internes définis dans le fichier `docker-compose`.

## 4-3 - Accès depuis l'intérieur avec curl et tlnet
- Pour accéder aux services depuis l'intérieur d'un conteneur Docker, vous pouvez utiliser `docker exec` pour ouvrir un terminal dans le conteneur et utiliser `curl` ou `telnet` pour tester les connexions.
- Voici quelques exemples de commandes :

## Avec `docker exec`
Pour lancer une session shell dans un conteneur :
```bash
docker exec -it <nom_du_conteneur> bash
```

## Avec `curl` ou `telnet`
Une fois dans le conteneur, vous pouvez tester les connexions aux services de cette façon :

### `curl`
Pour tester une connexion HTTP, utilisez `curl` :
```bash
curl http://<nom_d_hôte>:<port>
```
Par exemple :
```bash
curl http://spark-master:8080
```

### `telnet`
Pour tester une connexion TCP, utilisez `telnet` :
```bash
telnet <nom_d_hôte> <port>
```
Par exemple :
```bash
telnet kafka 9092
```

- Cela vous permettra de vérifier si les services sont correctement accessibles à l'intérieur du réseau Docker.

## 4-4 - Accès depuis l'intérieur à partir d'un conteneur avec `curl` ou `telnet`
- Pour accéder aux différents services de votre configuration Docker à partir d'un conteneur avec `curl` ou `telnet`, voici un guide détaillé :

### JupyterLab
**Nom d'hôte interne:** `jupyterlab`
- **Port 4888:**
  - **Accès avec curl:** `curl http://jupyterlab:4888`
  - **Accès avec telnet:** `telnet jupyterlab 4888`
- **Port 4040:**
  - **Accès avec curl:** `curl http://jupyterlab:4040`
  - **Accès avec telnet:** `telnet jupyterlab 4040`
- **Port 8050:**
  - **Accès avec curl:** `curl http://jupyterlab:8050`
  - **Accès avec telnet:** `telnet jupyterlab 8050`

### Spark Master
**Nom d'hôte interne:** `spark-master`
- **Port 8080:**
  - **Accès avec curl:** `curl http://spark-master:8080`
  - **Accès avec telnet:** `telnet spark-master 8080`
- **Port 7077:**
  - **Accès avec telnet:** `telnet spark-master 7077`

### Spark Worker 1
**Nom d'hôte interne:** `spark-worker-1`
- **Port 8081:**
  - **Accès avec curl:** `curl http://spark-worker-1:8081`
  - **Accès avec telnet:** `telnet spark-worker-1 8081`

### Spark Worker 2
**Nom d'hôte interne:** `spark-worker-2`
- **Port 8081:**
  - **Accès avec curl:** `curl http://spark-worker-2:8081`
  - **Accès avec telnet:** `telnet spark-worker-2 8081`

### Zookeeper
**Nom d'hôte interne:** `zookeeper`
- **Port 2181:**
  - **Accès avec telnet:** `telnet zookeeper 2181`

### Kafka
**Nom d'hôte interne:** `kafka`
- **Port 9092:**
  - **Accès avec telnet:** `telnet kafka 9092`

### NiFi
**Nom d'hôte interne:** `nifi`
- **Port 2080:**
  - **Accès avec curl:** `curl http://nifi:2080`
  - **Accès avec telnet:** `telnet nifi 2080`

### MongoDB
**Nom d'hôte interne:** `mongo`
- **Port 27017:**
  - **Accès avec telnet:** `telnet mongo 27017`

### Mongo Express
**Nom d'hôte interne:** `mongo-express`
- **Port 8081:**
  - **Accès avec curl:** `curl http://mongo-express:8081`
  - **Accès avec telnet:** `telnet mongo-express 8081`

- Cela vous permettra de tester l'accessibilité des services directement depuis un conteneur dans le même réseau Docker.
