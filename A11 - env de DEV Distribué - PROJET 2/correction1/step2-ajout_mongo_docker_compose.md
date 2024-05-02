# 1 - Transition de `docker-composev1.yaml` vers `docker-composev2.yaml`

## Contexte

- Dans `docker-composev1.yaml`, l'objectif principal était de créer une infrastructure de base pour un environnement de développement comprenant Spark, Zookeeper, Kafka et d'autres services. Cependant, l'extension de cet environnement pour inclure un cluster MongoDB Replica Set a nécessité des modifications supplémentaires.

## Objectif

- L'objectif de `docker-composev2.yaml` était d'ajouter un cluster MongoDB Replica Set en s'appuyant sur le fichier `docker-composev1.yaml`. 
- La référence de base utilisée pour cette étape provenait de [cette documentation](https://github.com/RWaltersMA/mongo-spark-jupyter/blob/master/docker-compose.yml). L'idée était de combiner les services précédemment définis avec un cluster MongoDB Replica Set.

# Référence 1 : 
- docker-compose.yaml dans step1
# Référence 2 : 
- https://github.com/RWaltersMA/mongo-spark-jupyter/blob/master/docker-compose.yml ( ne contient pas de mongo-express pour l'affichage)
# Référence 3 : Réponse de siddharthans2000  (Dec 21, 2022 ) ,  ça fonctionne !! 
- https://github.com/mongo-express/mongo-express-docker/issues/67

# 2 - Troubleshooting
### L'ancienne Configuration MongoDB Replica Set dans référence 2 ne contient pas mongo-express !!!!

- https://github.com/RWaltersMA/mongo-spark-jupyter/blob/master/docker-compose.yml
```yaml
# MongoDB Replica Set
mongo1:
  image: "mongo:latest"
  container_name: mongo1
  command: --replSet rs0 --oplogSize 128 --bind_ip 0.0.0.0
  volumes:
    - rs1:/data/db
  networks:
    - localnet
  ports:
    - "27017:27017"
  restart: always

mongo2:
  image: "mongo:latest"
  container_name: mongo2
  command: --replSet rs0 --oplogSize 128 --bind_ip 0.0.0.0
  volumes:
    - rs2:/data/db
  networks:
    - localnet
  ports:
    - "27018:27017"
  restart: always

mongo3:
  image: "mongo:latest"
  container_name: mongo3
  command: --replSet rs0 --oplogSize 128 --bind_ip 0.0.0.0
  volumes:
    - rs3:/data/db
  networks:
    - localnet
  ports:
    - "27019:27017"
  restart: always
```

## Résolution du problème Mongo-Express

- Malheureusement, Mongo-Express (interface graphique) ne fonctionnait pas avec cette configuration.
- En utilisant [cette discussion](https://github.com/mongo-express/mongo-express-docker/issues/67), j'ai simplifié la configuration en utilisant la réponse de `siddharthans2000`, et cela a fonctionné.
- https://github.com/mongo-express/mongo-express-docker/issues/67

# 3-Nouvelle Configuration `docker-composev2.yaml`

```yaml
version: '3'
services:
  mongodb:
    image:  mongo:4.4.17-focal
    container_name: mongodb
    ports:
      - 27017:27017
    environment:
      - MONGO_INITDB_ROOT_USERNAME=admin
      - MONGO_INITDB_ROOT_PASSWORD=password
  mongo-express:
    image: mongo-express:0.54.0
    restart: always
    container_name: mongo-express
    ports:
      - 8081:8081
    environment:
      - ME_CONFIG_MONGODB_ADMINUSERNAME=admin
      - ME_CONFIG_MONGODB_ADMINPASSWORD=password
      - ME_CONFIG_MONGODB_SERVER=mongodb
```

- Grâce à cette configuration simplifiée, Mongo-Express fonctionne désormais correctement en utilisant `docker-composev2.yaml`.


# 4 - docker-compose.yaml (version2 finale)
```yaml
version: "3"

volumes:
  shared-workspace:
    name: "hadoop-distributed-file-system"
    driver: local
  rs1:
  rs2:
  rs3:


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

  
  mongodb:
    image:  mongo:4.4.17-focal
    container_name: mongodb
    ports:
      - 27017:27017
    environment:
      - MONGO_INITDB_ROOT_USERNAME=admin
      - MONGO_INITDB_ROOT_PASSWORD=password
  mongo-express:
    image: mongo-express:0.54.0
    restart: always
    container_name: mongo-express
    ports:
      - 8081:8081
    environment:
      - ME_CONFIG_MONGODB_ADMINUSERNAME=admin
      - ME_CONFIG_MONGODB_ADMINPASSWORD=password
      - ME_CONFIG_MONGODB_SERVER=mongodb
networks:
  localnet:
    driver: bridge
    attachable: true
```


# 5 - Résumé des différents services  : 

- Voici un résumé des services sous forme de points :

- **Volumes :**
  - `shared-workspace`: Espace de travail partagé
  - `rs1`, `rs2`, `rs3`: Autres volumes

- **Services :**
  - **JupyterLab:**
    - Image : `pavansrivathsa/jupyterlab`
    - Ports : `4888`, `4040`, `8050`
    - Volume partagé : `shared-workspace`

  - **Spark Master:**
    - Image : `pavansrivathsa/spark-master`
    - Ports : `3080`, `7077`
    - Volume partagé : `shared-workspace`
    - Réseau : `localnet`

  - **Spark Worker 1:**
    - Image : `pavansrivathsa/spark-worker`
    - Ports : `4081`
    - Variables d'environnement : `SPARK_WORKER_CORES`, `SPARK_WORKER_MEMORY`
    - Volume partagé : `shared-workspace`
    - Dépendances : `spark-master`
    - Réseau : `localnet`

  - **Spark Worker 2:**
    - Image : `pavansrivathsa/spark-worker`
    - Ports : `4082`
    - Variables d'environnement : `SPARK_WORKER_CORES`, `SPARK_WORKER_MEMORY`
    - Volume partagé : `shared-workspace`
    - Dépendances : `spark-master`
    - Réseau : `localnet`

  - **Zookeeper:**
    - Image : `bitnami/zookeeper`
    - Ports : `2181`
    - Variables d'environnement : `ALLOW_ANONYMOUS_LOGIN`

  - **Kafka:**
    - Image : `wurstmeister/kafka`
    - Ports : `9092`
    - Dépendances : `zookeeper`
    - Variables d'environnement : `KAFKA_*`

  - **NiFi:**
    - Image : `apache/nifi`
    - Ports : `2080`
    - Variables d'environnement : `NIFI_*`

  - **MongoDB:**
    - Image : `mongo`
    - Ports : `27017`
    - Variables d'environnement : `MONGO_INITDB_*`

  - **Mongo Express:**
    - Image : `mongo-express`
    - Ports : `8081`
    - Variables d'environnement : `ME_CONFIG_*`

- **Réseaux :**
  - `localnet`: Réseau bridge attachable
 
# 6 - Accès aux différents services: 

- Pour accéder aux services depuis l'extérieur ou l'intérieur, voici les instructions:

### Accès depuis l'extérieur

- **JupyterLab:** Accédez via votre navigateur à `http://<IP_EXTERNE>:4888`.
- **Spark Master:** Accédez via votre navigateur à `http://<IP_EXTERNE>:3080`.
- **Kafka:** Assurez-vous d'avoir les ports ouverts sur votre réseau. Connectez-vous à `EXTERNAL://<IP_EXTERNE>:9092`.
- **NiFi:** Accédez via votre navigateur à `http://<IP_EXTERNE>:2080`.
- **MongoDB:** Utilisez `mongodb://admin:password@<IP_EXTERNE>:27017` pour vous connecter.
- **Mongo Express:** Accédez via votre navigateur à `http://<IP_EXTERNE>:8081`.

### Accès depuis l'intérieur (dans le réseau Docker)

- **JupyterLab:** Utilisez `docker exec -it jupyterlab bash` pour ouvrir un terminal.
- **Spark Master:** Utilisez `docker exec -it spark-master bash` pour ouvrir un terminal.
- **Kafka:**
  - Vérifiez les sujets avec `docker exec -it kafka kafka-topics.sh --list --bootstrap-server kafka:9092`.
  - Créez des messages avec `docker exec -it kafka kafka-console-producer.sh --broker-list kafka:9092 --topic <topic>`.
- **NiFi:** Utilisez `docker exec -it nifi bash` pour ouvrir un terminal.
- **MongoDB:**
  - Utilisez `docker exec -it mongodb mongosh` pour ouvrir une session.
  - Énumérez les bases de données avec `show dbs`.
- **Mongo Express:** Utilisez `docker exec -it mongo-express bash` pour ouvrir un terminal.

- Assurez-vous d'adapter `<IP_EXTERNE>` avec l'adresse IP de votre machine ou du serveur qui héberge vos conteneurs.
  
# 7 - Accès aux différents services en utilisant curl:

- Pour accéder aux services avec `curl`, vous pouvez suivre ces exemples :

### Depuis l'extérieur (utilisez `<IP_EXTERNE>` pour l'adresse de la machine)

- **JupyterLab:**
  ```bash
  curl http://<IP_EXTERNE>:4888
  ```

- **Spark Master:**
  ```bash
  curl http://<IP_EXTERNE>:3080
  ```

- **NiFi:**
  ```bash
  curl http://<IP_EXTERNE>:2080/nifi
  ```

### Depuis l'intérieur (à partir d'un autre conteneur dans le réseau Docker)

- **JupyterLab:**
  ```bash
  curl http://jupyterlab:4888
  ```

- **Spark Master:**
  ```bash
  curl http://spark-master:8080
  ```

- **Kafka:**
  - Vérifiez la connectivité:
    ```bash
    curl kafka:9092
    ```

- **NiFi:**
  ```bash
  curl http://nifi:2080/nifi
  ```

- Assurez-vous d'avoir les services en cours d'exécution et disponibles sur les ports mentionnés.
