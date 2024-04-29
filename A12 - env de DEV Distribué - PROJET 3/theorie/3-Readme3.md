# Guide des Technologies Clés

- Ce guide fournit une introduction rapide à diverses technologies essentielles dans le domaine de l'informatique.
- Utilisez les liens ci-dessous pour naviguer vers la section qui vous intéresse.

## Table des Matières

- [Nginx](#nginx)
- [Kafka](#kafka)
- [Docker](#docker)
- [Debezium](#debezium)
- [PostgreSQL](#postgresql)
- [NiFi](#nifi)
- [AWS Glue](#aws-glue)
- [Crawler](#crawler)
- [Amazon Athena](#amazon-athena)
- [Terraform](#terraform)

## Nginx

Nginx est un serveur web léger et un reverse proxy, utilisé également pour la mise en cache, le load balancing et la gestion des médias HTTP. Pour plus de détails, visitez [leur site web](https://nginx.org).
D'accord, voici un exemple de section pour un fichier `README.md` qui explique en détail l'utilisation de Nginx comme reverse proxy, et pourquoi il est utilisé dans cette architecture avec FastAPI :

# Nginx comme Reverse Proxy pour FastAPI

## Pourquoi utiliser Nginx avec FastAPI?

Dans notre architecture de projet, Nginx est utilisé comme reverse proxy devant FastAPI. Les raisons principales pour utiliser Nginx dans ce rôle sont :

- **Performance**: Nginx est conçu pour gérer un grand nombre de connexions simultanées avec une utilisation efficace de la mémoire et du CPU. Il est donc idéal pour gérer les pics de trafic vers notre API.

- **Sécurité**: En masquant les détails de l'infrastructure interne, Nginx contribue à protéger les serveurs d'applications comme FastAPI contre les attaques externes.

- **Équilibrage de charge**: Nginx peut distribuer le trafic entre plusieurs instances de FastAPI, améliorant la disponibilité et la répartition de la charge.

- **Mise en cache**: Nginx peut mettre en cache les réponses de l'API, réduisant le temps de réponse pour l'utilisateur final et diminuant la charge sur le serveur FastAPI.

- **Gestion des SSL/TLS**: Nginx peut gérer les certificats SSL/TLS pour le chiffrement HTTPS, ce qui simplifie la configuration de la sécurité pour FastAPI.

## Comment Nginx est-il configuré comme Reverse Proxy?

Nginx agit comme intermédiaire pour les requêtes HTTP/HTTPS venant des clients. Voici un exemple de configuration de Nginx en tant que reverse proxy pour FastAPI :

```nginx
http {
    server {
        listen 80;
        server_name example.com;

        location / {
            proxy_pass http://fastapi:8000;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection "upgrade";
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
            proxy_set_header X-Forwarded-Host $server_name;
        }
    }
}
```

Dans cette configuration, Nginx écoute sur le port 80 (HTTP) et transfère les requêtes au service FastAPI, qui est supposé s'exécuter localement sur le port 8000. Il définit également des en-têtes nécessaires pour que FastAPI puisse comprendre l'origine de la requête et gérer correctement le protocole HTTP.

En résumé, Nginx sert de point d'entrée fiable et efficace pour les requêtes destinées à notre API FastAPI, offrant des performances optimales et une sécurité renforcée.


## Kafka

Apache Kafka est une plateforme de streaming distribuée qui permet de publier, de s'abonner, de stocker et de traiter des flux de données en temps réel. Pour plus d'informations, consultez [leur site web](https://kafka.apache.org).
Bien sûr, voici une section détaillée pour un fichier `README.md` qui décrit Apache Kafka et son modèle de publication et d'abonnement :

```markdown
# Apache Kafka et le Modèle Publish-Subscribe

## Qu'est-ce qu'Apache Kafka?

Apache Kafka est un système de messagerie distribué qui utilise un modèle de publication et d'abonnement pour traiter les flux de données en temps réel. C'est une plateforme scalable et fault-tolerant conçue pour gérer des volumes de données élevés et permettre le traitement de messages en streaming.

## Pourquoi utiliser Apache Kafka dans notre architecture?

Kafka est utilisé dans notre architecture pour plusieurs raisons clés :

- **Débit élevé**: Kafka peut gérer des milliers de messages par seconde, ce qui le rend idéal pour des applications qui nécessitent de gros volumes de données, comme le traitement des transactions boursières dans notre cas.

- **Durabilité et fiabilité**: Kafka stocke les messages sur le disque avec une réplication intra-cluster, ce qui garantit que les données ne sont pas perdues même en cas de défaillance du nœud.

- **Scalabilité**: Kafka peut être étendu simplement en ajoutant plus de nœuds au cluster, sans interruption de service.

- **Faible latence**: La conception de Kafka lui permet de fournir des messages avec une faible latence, ce qui est crucial pour les applications temps réel.

## Le Modèle de Publication et d'Abonnement

Kafka implémente un modèle publish-subscribe avancé avec des concepts clés tels que les producteurs, les consommateurs, les topics, les partitions et les offsets.

- **Producteurs**: Les applications qui publient (écrivent) des messages dans Kafka sont appelées producteurs. Dans notre projet, cela pourrait être une application collectant des données en temps réel sur le marché boursier.

- **Consommateurs**: Les applications qui s'abonnent et lisent les messages à partir de Kafka sont appelées consommateurs. Par exemple, une application d'analyse qui traite les données du marché boursier pour prédire les tendances.

- **Topics**: Un topic est une catégorie ou un flux de messages dans Kafka. Les producteurs écrivent des messages dans des topics et les consommateurs lisent des messages à partir de ces topics.

- **Partitions**: Chaque topic peut être divisé en plusieurs partitions, où chaque partition est une séquence ordonnée et immuable de messages. Les partitions permettent à Kafka de paralléliser le traitement car chaque partition peut être lue par un consommateur différent dans le groupe de consommateurs.

- **Offsets**: Un offset est un identifiant unique pour chaque message dans une partition. Il permet aux consommateurs de garder une trace des messages qui ont été lus et de ceux qui doivent l'être.

## Exemple de Configuration Kafka pour le Projet

Voici un exemple simplifié de configuration de Kafka pour notre projet de traitement de données en temps réel :

```yaml
# Exemple de configuration pour un topic Kafka
topic: "stock-market-data"
partitions: 3
replication-factor: 2
```

Cette configuration définit un topic nommé `stock-market-data` avec trois partitions pour permettre la parallélisation du traitement et un facteur de réplication de deux pour assurer la redondance des données.

## Résumé

En conclusion, Kafka joue un rôle vital dans notre architecture en fournissant une plateforme robuste et fiable pour le transport de messages en temps réel entre différents composants du système, tels que les sources de données, les services de traitement de flux et les bases de données. Son modèle de publication et d'abonnement hautement configurable nous permet de construire des pipelines de données résilients et évolutifs qui sont essentiels à la réussite de notre projet.

### Référence :  document ci-joint !

## Docker

Docker est une plateforme de conteneurisation qui permet de simplifier le déploiement d'applications dans des conteneurs logiciels. Pour en savoir plus, visitez [leur site web](https://www.docker.com).
Voici une section détaillée pour un fichier `README.md` qui explique l'utilisation de Docker dans le contexte d'une architecture de projet :

```markdown
# Docker dans l'Architecture de Projet

## Qu'est-ce que Docker?

Docker est une plateforme de conteneurisation populaire qui permet de développer, déployer et exécuter des applications dans des conteneurs. Un conteneur est une unité standardisée de logiciel qui package le code de l'application et toutes ses dépendances afin que l'application s'exécute rapidement et de manière fiable dans différents environnements informatiques.

## Vulgarisation :

- Docker est un outil très pratique qui permet aux développeurs de créer, déployer et exécuter des applications plus facilement en utilisant ce qu’on appelle des "conteneurs".
- Imagine que tu as une application, comme un petit programme qui fait quelque chose de cool, et que tu veux l’envoyer à un ami pour qu'il puisse l'utiliser. Cela pourrait être compliqué parce que ton programme nécessite peut-être d’autres logiciels pour fonctionner, et si ton ami ne les a pas, ça ne marchera pas chez lui. Même si tu lui envoies toutes les instructions pour installer ces logiciels, cela peut prendre du temps et il peut rencontrer des problèmes imprévus.
- Ici entre en jeu Docker. Docker "emballe" ton application et tout ce dont elle a besoin pour fonctionner dans un conteneur. Tu peux imaginer un conteneur comme une petite boîte qui contient ton programme et tout ce qui est nécessaire pour le faire fonctionner, comme un système d'exploitation léger, un serveur web, des bases de données, etc.
- Lorsque tu utilises Docker, tu n'as pas à t’inquiéter si l’ordinateur de ton ami est différent du tien ou s'il a d'autres versions des logiciels nécessaires. Ton ami peut simplement utiliser Docker pour télécharger et exécuter ton conteneur et, magie, ça fonctionnera exactement de la même manière que sur ton ordinateur. Cela simplifie beaucoup les choses, surtout si tu veux déployer ton application sur beaucoup d'ordinateurs différents, que ce soit les ordinateurs de tes amis ou des serveurs dans le cloud.
- En bref, Docker aide à résoudre le problème du "mais ça marche sur mon ordinateur !" en s'assurant que si ça marche dans un conteneur Docker sur ton ordinateur, ça marchera dans le même conteneur partout ailleurs.

## Pourquoi utiliser Docker dans notre architecture ?

Dans notre architecture, Docker est utilisé pour encapsuler les applications et les services pour plusieurs raisons clés :

- **Isolation**: Docker assure que chaque service s'exécute dans un environnement isolé, ce qui évite les conflits de dépendances et assure la cohérence entre les environnements de développement, de test et de production.

- **Portabilité**: Les conteneurs Docker peuvent être déployés sur n'importe quelle machine hôte prenant en charge Docker, ce qui facilite le déploiement et les migrations entre les environnements.

- **Contrôle des versions et réplicabilité**: Docker permet de versionner les images de conteneurs, de sorte que vous pouvez suivre les versions de manière précise et répliquer les environnements de manière fiable.

- **Microservices**: Docker est idéal pour l'architecture microservices, car il permet de déployer et de gérer chaque microservice de manière indépendante.

- **Développement Agile et CI/CD**: Docker s'intègre bien avec les pratiques de développement agile et les pipelines CI/CD, facilitant l'intégration et le déploiement continus.

## Utilisation de Docker Comme Partie de Notre Architecture

Docker est utilisé pour exécuter nos services, y compris l'API FastAPI, Debezium pour la capture de données changées, et NiFi pour l'orchestration de flux de données. Voici un aperçu de comment Docker interagit avec les autres composants de notre système :

1. **FastAPI** : Un conteneur Docker est utilisé pour déployer notre API FastAPI, qui expose les endpoints nécessaires pour notre application.
   
2. **Debezium** : Debezium est déployé dans un conteneur Docker pour capturer les changements de notre base de données MySQL et les publier sur Kafka.
   
3. **NiFi** : NiFi est conteneurisé et utilisé pour orchestrer et transformer les flux de données avant de les charger dans les entrepôts de données.

## Exemple de Dockerfile pour FastAPI

```dockerfile
# Utiliser une image de base Python officielle
FROM python:3.8-slim

# Définir le répertoire de travail dans le conteneur
WORKDIR /app

# Copier les fichiers de dépendances et installer les dépendances
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copier le reste du code de l'application dans le conteneur
COPY . .

# Exposer le port sur lequel l'API s'exécutera
EXPOSE 8000

# Commande pour exécuter l'application
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
```

Dans ce `Dockerfile`, nous partons d'une image de base Python, installons les dépendances de notre application, copions notre code source, exposons le port 8000 et définissons la commande pour démarrer notre application FastAPI.

## Résumé

En utilisant Docker, nous nous assurons que notre application s'exécute de manière uniforme et prévisible, tout en facilitant la gestion des déploiements et la scalabilité de nos services. Cela constitue une partie essentielle de notre infrastructure et soutient nos objectifs de développement agile et de livraison continue.



## Debezium

Debezium est un outil open source pour la capture de données modifiées (CDC), qui permet de capturer les changements de bases de données en temps réel. Plus d'informations sont disponibles sur [leur site web](https://debezium.io).

## PostgreSQL

PostgreSQL est un système de gestion de base de données relationnelles et objet (ORDBMS) reconnu pour sa robustesse et ses fonctionnalités. Pour plus de détails, consultez [leur site web](https://www.postgresql.org).

## NiFi

Apache NiFi est une plateforme automatisée et extensible pour déplacer, transformer, et gérer les données entre systèmes. Pour plus d'informations, visitez [leur site web](https://nifi.apache.org).

## AWS Glue

AWS Glue est un service ETL (Extract, Transform, Load) entièrement géré qui facilite la préparation et le chargement de données pour l'analyse. Découvrez plus sur [leur page AWS](https://aws.amazon.com/glue).

## Crawler

Dans le contexte d'AWS Glue, un Crawler est utilisé pour catégoriser les données et populer automatiquement les catalogues de données. Plus de détails sur [la documentation AWS](https://docs.aws.amazon.com/glue/latest/dg/add-crawler.html).

## Amazon Athena

Amazon Athena est un service de requête interactif qui permet d'analyser des données dans Amazon S3 en utilisant SQL standard. Plus d'informations sur [leur page AWS](https://aws.amazon.com/athena).

## Terraform

Terraform est un outil d'Infrastructure as Code (IaC) qui permet de construire, modifier, et versionner l'infrastructure de manière efficace. Pour en savoir plus, visitez [leur site web](https://www.terraform.io).

```

Ce modèle vous permet de créer un `README.md` organisé et facile à naviguer, avec des sections dédiées à chaque technologie et des liens pour approfondir chaque sujet.
