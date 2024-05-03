# Mise en place d'un Replica Set MongoDB

# 1 - Contexte

- J'ai voulu créer un Replica Set MongoDB composé de plusieurs réplicas.
- J'ai passé 3 heures pour créer 3 versions `docker-composev3-v4-v5.yaml`.
- Cependant, les fichiers `docker-composev3-v4-v5.yaml` ne fonctionnaient pas comme prévu.
- Finalement, je suis arrivé à une solution finale !
  
# 2- Configuration initiale

- À partir de cette référence : https://github.com/RWaltersMA/mongo-spark-jupyter/blob/master/docker-compose.yml
- Voici la configuration initiale que j'ai utilisée :


## 2-1- MongoDB Replica Set

```yaml
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

## 2-2- Ajout de Mongo Express

```yaml
mongo-express:
  image: mongo-express:0.54.0
  restart: always
  container_name: mongo-express
  ports:
    - 8081:8081
  environment:
    - ME_CONFIG_MONGODB_ADMINUSERNAME=admin
    - ME_CONFIG_MONGODB_REPLICA_SET=rs0
```

## Solution trouvée

- Après avoir essayé, essayé et réessayé plusieurs fois pendant 3 heures de manière intensive, j'ai décidé d'isoler le travail et de le faire à part.
- J'ai trouvé ce [lien](https://blog.devgenius.io/how-to-deploy-a-mongodb-replicaset-using-docker-compose-a538100db471) qui offre une solution détaillée pour déployer un Replica Set MongoDB avec Docker Compose.
- Référence principale : https://blog.devgenius.io/how-to-deploy-a-mongodb-replicaset-using-docker-compose-a538100db471
  
## D'autres liens utiles :
- [Guide MongoDB Replica Set avec Docker Compose](https://medium.com/@JosephOjo/mongodb-replica-set-with-docker-compose-5ab95c02af0d)
- [Guide complet pour MongoDB Replica Set avec Docker Compose](https://medium.com/workleap/the-only-local-mongodb-replica-set-with-docker-compose-guide-youll-ever-need-2f0b74dd8384)

## Étapes de configuration

1. Cloner le dépôt :
   ```bash
   git clone <LIEN_A_AJOUTER>
   git clone https://github.com/hrhouma/MongoDB_replica_set.git
   cd <NOM_DU_REPO>
   cd MongoDB_replica_set
   ```
2. Initialiser le Replica Set :
   ```sh
   chmod u+x startReplicaSetEnvironment.sh
   sh startReplicaSetEnvironment.sh
   docker ps
   ```
3. Observez les services (conteneurs avec la commande docker ps). mongo1, mongo2 et mongo3 sont up mais mongoexpress est à l'état de redémarrage (restarting).
   Pour résoudre ce problème, passez à l'étape 5.
5. Initialiser le Replica Set :
   ```bash
   docker exec -it mongo1 mongo
   rs.status()
   rs.initiate({_id:"rs0",members:[{_id:0,host:"mongo1:27017"},{_id:1,host:"mongo2:27017"},{_id:2,host:"mongo3:27017"}]})
   ```

   **Note :** Le code suivant n'a pas fonctionné :
   ```bash
   rs.initiate({_id:"rs0",members:[{_id:0,host:"mongo1:27017"},{_id:1,host:"mongo2:27018"},{_id:2,host:"mongo3:27019"}]})
   ```

3. Redémarrer les services :
   ```bash
   docker restart mongo1 mongo2 mongo3
   docker logs mongo1
   docker logs mongo2
   docker logs mongo3
   docker logs mongo-express
   ```


- Voici le lien du travail final :
# Référence finale: 
https://blog.devgenius.io/how-to-deploy-a-mongodb-replicaset-using-docker-compose-a538100db471
# Solution finale : 
https://github.com/hrhouma/MongoDB_replica_set

- N'hésitez pas à ajouter des détails spécifiques à votre cas d'utilisation.
https://blog.devgenius.io/how-to-deploy-a-mongodb-replicaset-using-docker-compose-a538100db471
