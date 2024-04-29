# Tempest Weather Kafka

Simple program that takes UDP packets broadcast by the Tempest Weather Station 
and puts them into a Kafka topic.

# Étapes : 


Pour exécuter votre programme Java pour Kafka, qui écoute les paquets UDP et les redirige vers un sujet Kafka, vous devez suivre ces étapes. Ce guide suppose que vous avez Kafka et Zookeeper en cours d'exécution localement, et que vous avez Maven installé sur votre système pour gérer les dépendances et les builds du projet.

### Étape 1 : Assurez-vous que Kafka est en cours d'exécution

Avant de lancer votre application, assurez-vous que votre broker Kafka et Zookeeper sont en fonctionnement. Voici comment vous pouvez les démarrer :

1. **Démarrer Zookeeper** :
   ```bash
   bin/zookeeper-server-start.sh config/zookeeper.properties
   ```
   Remplacez `bin/zookeeper-server-start.sh` et `config/zookeeper.properties` par votre chemin et configuration si différent.

2. **Démarrer le serveur Kafka** :
   ```bash
   bin/kafka-server-start.sh config/server.properties
   ```
   Remplacez `bin/kafka-server-start.sh` et `config/server.properties` par votre chemin et configuration si différent.

### Étape 2 : Compiler et empaqueter votre application

Votre projet Maven utilise le `maven-assembly-plugin` pour créer un jar exécutable, qui inclut toutes les dépendances. Naviguez vers le répertoire racine de votre projet où se trouve votre `pom.xml` et exécutez :

```bash
mvn clean compile assembly:single
```

Cette commande nettoie le projet, compile le code source et le package dans un seul jar avec toutes les dépendances.

### Étape 3 : Exécuter votre application

Après avoir construit le projet, vous pouvez exécuter votre application en utilisant la commande suivante :

```bash
java -jar target/tempestUdpListener-1.0-SNAPSHOT-jar-with-dependencies.jar
```

Assurez-vous que le nom du jar correspond à celui généré par Maven. Cette commande démarre le `TempestUdpListener` qui écoute sur le port UDP `50222` et transmet les données reçues à Kafka.

### Étape 4 : Vérifier la configuration

1. **Envoyer des paquets UDP de test** : Vous pouvez utiliser des outils comme `netcat` pour envoyer des messages à votre application :

   ```bash
   echo "Votre message de test" | nc -u localhost 50222
   ```

2. **Consommer les messages de Kafka** : Pour voir si vos messages sont publiés avec succès sur Kafka, utilisez le consommateur de console Kafka :

   ```bash
   bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic kafkasource.tempest-raw-data --from-beginning
   ```

   Cette commande consomme les messages du sujet `kafkasource.tempest-raw-data`.

### Considérations supplémentaires

- **Configuration Kafka** : Assurez-vous que votre configuration Kafka dans la méthode `producerProperties()` correspond à votre configuration Kafka. En particulier, les `bootstrap.servers` doivent pointer vers votre serveur Kafka.
  
- **Gestion des erreurs** : Implémentez une gestion d'erreurs et un journalisation supplémentaires en fonction de vos besoins pour gérer différents scénarios de manière gracieuse.

- **Format des paquets UDP** : Assurez-vous que les paquets UDP envoyés à l'application sont correctement formatés en JSON, car votre application s'attend à des chaînes formatées en JSON.

- **Sécurité** : Si vous prévoyez de déployer cette application dans un environnement de production, envisagez de sécuriser vos communications Kafka et application.

En suivant ces étapes, votre application Java utilisant Kafka devrait être opérationnelle, capable de recevoir des messages UDP et de les publier sur un sujet Kafka.


# À considérer : 

Pour lancer votre application Java qui écoute les paquets UDP et les transmet à un topic Kafka, vous n'avez pas besoin d'ajouter une clé spécifique dans le code actuel, à moins que vous ne souhaitiez configurer des éléments spécifiques liés à la sécurité ou à d'autres aspects de Kafka. Voici les étapes détaillées pour démarrer et exécuter votre programme :

### Prérequis
1. **Assurez-vous que Kafka et Zookeeper sont en cours d'exécution** : Vérifiez que vos services Kafka et Zookeeper sont actifs et à l'écoute des ports configurés. Si ce n'est pas déjà fait, démarrez-les en utilisant les commandes appropriées dans leur répertoire d'installation.

2. **Vérification du port UDP** : Votre application écoute sur le port UDP 50222. Assurez-vous que ce port est libre et n'est pas bloqué par un pare-feu.

### Compilation et Exécution
1. **Compilation avec Maven** : Ouvrez un terminal à la racine de votre projet (où se trouve le fichier `pom.xml`) et exécutez la commande suivante pour compiler votre application et créer un fichier JAR contenant toutes les dépendances nécessaires :
   ```bash
   mvn clean compile assembly:single
   ```
   Cette commande crée un fichier JAR dans le dossier `target` de votre projet.

2. **Exécution de l'application** : Une fois la compilation terminée, exécutez le JAR avec la commande :
   ```bash
   java -jar target/tempestUdpListener-1.0-SNAPSHOT-jar-with-dependencies.jar
   ```
   Assurez-vous que le nom du fichier JAR correspond à celui généré par Maven.

### Dépannage courant
- **Problèmes de connexion Kafka** : Si l'application ne peut pas se connecter à Kafka, vérifiez les configurations de `bootstrap.servers` dans la méthode `producerProperties()` de votre application. Assurez-vous qu'elles correspondent à l'adresse de votre serveur Kafka.
- **Réception des paquets UDP** : Si vous ne recevez pas de paquets, vérifiez que la source des paquets UDP (par exemple, une station météorologique Tempest) est configurée pour envoyer des données au bon port et à la bonne adresse IP.
- **Logs** : Utilisez les logs pour identifier et résoudre les problèmes. Votre application utilise `java.util.logging`, donc ajustez les niveaux de log si nécessaire pour obtenir plus de détails.

### Sécurité Kafka
Si vous décidez de sécuriser les communications Kafka, vous devrez ajouter des configurations supplémentaires pour la sécurité SSL/TLS ou SASL dans votre méthode `producerProperties()`. Voici un exemple de configuration pour la sécurité :

```java
props.put("security.protocol", "SSL");
props.put("ssl.truststore.location", "path_to_truststore.jks");
props.put("ssl.truststore.password", "truststore_password");
```

Remplacez les valeurs selon votre configuration spécifique de sécurité Kafka.

### Conclusion
En suivant ces étapes, vous devriez pouvoir lancer et exécuter votre application Java qui écoute les paquets UDP et les transmet à un topic Kafka. Assurez-vous que tous les composants nécessaires sont correctement configurés et que l'environnement est prêt pour une exécution sans problème.

 
 
 
