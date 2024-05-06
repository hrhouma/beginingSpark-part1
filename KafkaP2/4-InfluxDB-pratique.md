# InfluxDB

- InfluxDB est une base de données de séries temporelles puissante et facile à utiliser. 
- Voici comment l'installer et la configurer.

## Installation

### Docker

Pour installer InfluxDB en utilisant Docker :

```bash
docker run -d -p 8086:8086 \
  -v $PWD:/var/lib/influxdb2 \
  -e DOCKER_INFLUXDB_INIT_MODE=setup \
  -e DOCKER_INFLUXDB_INIT_USERNAME=admin \
  -e DOCKER_INFLUXDB_INIT_PASSWORD=adminpass \
  -e DOCKER_INFLUXDB_INIT_ORG=example-org \
  -e DOCKER_INFLUXDB_INIT_BUCKET=example-bucket \
  influxdb:2.0
```

### Binaire autonome

Pour installer InfluxDB en utilisant le binaire autonome :

1. Téléchargez la dernière version d'InfluxDB depuis [le site officiel](https://portal.influxdata.com/downloads/).
2. Décompressez le fichier téléchargé et déplacez-le dans un répertoire de votre choix.
3. Lancez le service InfluxDB :
   ```bash
   ./influxd
   ```
4. Configurez InfluxDB en exécutant l'assistant d'initialisation :
   ```bash
   influx setup
   ```

## Configuration

Les fichiers de configuration d'InfluxDB sont généralement nommés `influxdb.conf`. Les principaux paramètres comprennent :

- `reporting-disabled`: Empêche InfluxDB de signaler l'utilisation anonyme.
- `http-enabled`: Active l'interface HTTP pour les requêtes API.
- `retention`: Définit les politiques de rétention des données.

## Utilisation

Après l'installation, vous pouvez utiliser l'interface en ligne de commande (CLI) ou l'interface utilisateur (UI).

### CLI

Pour interroger et manipuler les données via CLI :

1. Lancez le client CLI :
   ```bash
   influx
   ```
2. Utilisez les commandes InfluxQL ou Flux pour interroger la base de données.

### UI

L'interface utilisateur d'InfluxDB permet une gestion et une visualisation faciles :

1. Ouvrez votre navigateur et allez à `http://localhost:8086`.
2. Connectez-vous avec vos identifiants créés lors de la configuration.
3. Explorez les tableaux de bord, créez des requêtes et gérez vos buckets.

## Licence

InfluxDB est distribué sous licence MIT.
