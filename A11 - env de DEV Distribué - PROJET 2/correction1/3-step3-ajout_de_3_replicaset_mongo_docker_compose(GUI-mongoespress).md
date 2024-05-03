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


# Annexe 1 : Comment vérifier si les données sont répliquées ? 

**Question** : J'ai inséré des données dans le premier et principal serveur de base de données Mongo. Comment vérifier si les données sont répliquées ? Dois-je utiliser `rs` ?

**Réponse** : Oui, pour vérifier si les données ont été correctement répliquées dans votre Replica Set MongoDB, vous pouvez utiliser les approches suivantes :

### 1. Utiliser `rs.status()`
Exécutez la commande `rs.status()` sur n'importe quel nœud pour obtenir le statut du Replica Set. Cette commande vous montrera l'état de réplication de chaque membre et s'il est synchronisé avec le primaire.

### 2. Vérifier les données sur les nœuds secondaires
Pour vérifier directement si les données sont répliquées sur les nœuds secondaires :

1. **Se connecter à un nœud secondaire** : Vous devrez peut-être modifier la configuration pour permettre les opérations de lecture sur les nœuds secondaires :
   ```javascript
   rs.slaveOk()
   ```
   Notez que cette commande permet les opérations de lecture uniquement pour la session actuelle. Ce n'est pas une modification permanente.

2. **Interroger la collection** : Interrogez la collection sur le nœud secondaire pour voir si les données sont disponibles. Par exemple :
   ```javascript
   db.collectionName.find()
   ```

### 3. Comparer la taille de l'oplog
- Une autre approche consiste à vérifier la taille de l'oplog pour voir si les opérations ont été appliquées de manière cohérente :
```javascript
rs.printReplicationInfo()
```
- Cela vous donnera des informations sur l'oplog, comme sa taille et l'heure de la dernière opération.

### 4. Vérifier le retard de réplication
- Pour s'assurer que vos données sont répliquées avec un retard minimal, vous pouvez vérifier le retard de réplication.
- Un faible retard de réplication signifie que vos nœuds secondaires sont proches d'être synchronisés avec le primaire.

### Résumé
- En utilisant ces méthodes, vous pouvez vérifier si les données sont répliquées avec succès.
- Le statut du Replica Set et les requêtes directes sur les nœuds secondaires vous donneront une bonne indication de la santé de la réplication.

# Annexe 2: liste complète des commandes liées aux Replica Sets (rs) dans MongoDB

- Voici une liste complète des commandes liées aux Replica Sets (rs) dans MongoDB :

1. **rs.status()**
   - Affiche l'état actuel du Replica Set, incluant le statut de chaque membre et leur état de réplication.

2. **rs.initiate()**
   - Initialise un nouveau Replica Set avec une configuration par défaut ou personnalisée.

3. **rs.add()**
   - Ajoute un nouveau nœud secondaire au Replica Set.
   - Exemple : `rs.add("mongodb2:27017")`

4. **rs.remove()**
   - Supprime un nœud du Replica Set.
   - Exemple : `rs.remove("mongodb2:27017")`

5. **rs.reconfig()**
   - Permet de reconfigurer le Replica Set en appliquant une nouvelle configuration.
   - Exemple d'utilisation : 
     ```javascript
     cfg = rs.conf()
     cfg.members[1].priority = 2
     rs.reconfig(cfg)
     ```

6. **rs.stepDown()**
   - Force le nœud primaire actuel à se retirer, permettant à un nœud secondaire d'être élu comme nouveau primaire.
   - Exemple : `rs.stepDown(60)`

7. **rs.freeze()**
   - Empêche un nœud secondaire d'être élu comme primaire pendant une durée spécifiée.
   - Exemple : `rs.freeze(120)`

8. **rs.slaveOk()**
   - Permet les opérations de lecture sur un nœud secondaire dans la session actuelle.
   - Exemple : `rs.slaveOk()`

9. **rs.printReplicationInfo()**
   - Affiche des informations générales sur la réplication, y compris la taille de l'oplog et le temps des dernières opérations.

10. **rs.printSecondaryReplicationInfo()**
    - Affiche des informations détaillées sur la synchronisation des nœuds secondaires, notamment le retard de réplication.

11. **rs.conf()**
    - Renvoie la configuration actuelle du Replica Set.

12. **rs.isMaster()**
    - Retourne les informations du nœud sur lequel la commande est exécutée, y compris s'il est primaire ou secondaire.

- Chaque commande offre des informations et des fonctionnalités essentielles pour la gestion et la maintenance des Replica Sets dans MongoDB.
