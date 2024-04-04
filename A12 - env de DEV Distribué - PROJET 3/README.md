Références : 
- https://github.com/hrhouma/projet2-Stock_streaming_pipeline_project-main
- https://github.com/hrhouma/projet1-dataStreaming-main

# 1 -  PARTIE 1 - Architecture du Projet de Streaming de Données

Ce document présente l'architecture de notre projet de streaming de données conçu pour capturer, traiter et analyser des données en temps réel.

![image](https://github.com/hrhouma/beginingSpark-part1/assets/10111526/608923e4-0551-493a-b632-6a047fed0e70)

## Vue d'ensemble

Le diagramme d'architecture illustre une configuration robuste pour une application de streaming de données. Elle implique des services Web, la capture de données, le traitement, le streaming d'événements, le stockage de données et l'analyse.

## Composants

### Amazon EC2 avec NGINX et FastAPI

- **Rôle** : Sert de point d'entrée pour les requêtes Web et héberge l'application Web.
- **Description** : Amazon EC2 héberge un serveur Web NGINX qui agit comme un proxy inverse pour l'application FastAPI. Cette configuration assure une gestion efficace des requêtes Web et l'équilibrage de charge.
- **Alternatives** : Serveur HTTP Apache, Caddy, Microsoft IIS.

### Ubuntu avec Docker

- **Rôle** : Fournit un environnement cohérent pour l'exécution des applications.
- **Description** : Ubuntu sert de système d'exploitation hôte avec Docker pour la conteneurisation, permettant l'isolation et le déploiement facile des applications.
- **Alternatives** : CentOS avec Podman, Debian avec Docker, Alpine Linux.

### Kafka

- **Rôle** : Gère le streaming d'événements à haut débit.
- **Description** : Kafka est une plateforme de streaming d'événements distribuée qui facilite le flux de données en temps réel entre les systèmes ou les applications.
- **Alternatives** : RabbitMQ, ActiveMQ, Amazon Kinesis.

### Debezium

- **Rôle** : Capture de données de changement (CDC) pour la surveillance des changements de base de données.
- **Description** : Debezium est une plateforme distribuée open source pour la CDC, diffusant les changements de base de données dans des topics Kafka.
- **Alternatives** : Maxwell's Daemon, Oracle GoldenGate, AWS Database Migration Service.

### PostgreSQL

- **Rôle** : Base de données principale pour le stockage et la gestion des données.
- **Description** : PostgreSQL est une base de données relationnelle open source robuste et riche en fonctionnalités.
- **Alternatives** : MySQL, MariaDB, Microsoft SQL Server.

### Apache NiFi

- **Rôle** : Gestion de flux de données.
- **Description** : NiFi prend en charge l'automatisation du flux de données entre les systèmes et fournit une interface utilisateur Web pour gérer les flux de données en temps réel.
- **Alternatives** : Apache Camel, StreamSets, Talend.

### Python

- **Rôle** : Scripting et automatisation.
- **Description** : Python est utilisé pour écrire des scripts qui interagissent avec des services tels qu'Amazon S3 pour la manipulation et le traitement des données.
- **Alternatives** : Ruby, Perl, Node.js.

### Amazon S3

- **Rôle** : Stockage de données et sauvegarde.
- **Description** : S3 est utilisé pour stocker de grandes quantités de données dans le cloud, offrant une haute disponibilité et une évolutivité.
- **Alternatives** : Google Cloud Storage, Azure Blob Storage, MinIO.

### Crawler

- **Rôle** : Extraction de données.
- **Description** : Le Crawler extrait des données de diverses sources pour les traiter.
- **Alternatives** : Scrapy, Apache Nutch, Octoparse.

### Amazon Athena

- **Rôle** : Service de requête de données.
- **Description** : Athena permet d'interroger les données dans S3 en utilisant SQL, permettant une analyse rapide des données sans la nécessité de solutions complexes de data warehouse.
- **Alternatives** : Presto, Google BigQuery, Snowflake.

### Amazon Glue

- **Rôle** : ETL et catalogue de données.
- **Description** : AWS Glue est un service ETL entièrement géré qui simplifie la préparation et le chargement des données pour l'analyse.
- **Alternatives** : Apache Spark, Informatica, Talend Open Studio.

## Conclusion

L'architecture fournit une solution complète pour la capture, le traitement, le streaming, le stockage et l'analyse des données en temps réel. Chaque composant joue un rôle crucial, et des alternatives sont disponibles en fonction des besoins spécifiques ou des préférences de l'équipe de développement ou des exigences du projet.


# 2 - PARTIE 2 - Workflow 

![image](https://github.com/hrhouma/beginingSpark-part1/assets/10111526/608923e4-0551-493a-b632-6a047fed0e70)

Le workflow illustré dans l'image représente un système de traitement et d'analyse de données en temps réel qui utilise une pile de technologies pour ingérer, traiter, stocker et analyser des données. Voici une explication étape par étape du processus :

1. **FastAPI sur Amazon EC2**:
    - **Point de départ**: Le service web est hébergé sur une instance Amazon EC2.
    - **Fonctionnement**: NGINX sert de serveur web et de reverse proxy pour FastAPI, un framework Python utilisé pour construire des API rapides et efficaces.
    - **Processus**: Les clients envoient des requêtes HTTP qui sont reçues par NGINX et transférées à l'application FastAPI.

2. **Containerisation avec Docker sur Ubuntu**:
    - **Environnement**: Les composants de l'application sont conteneurisés avec Docker, fonctionnant sur un système d'exploitation Ubuntu, pour une meilleure gestion des dépendances et isolation.

3. **Stream Processing avec Kafka et Debezium**:
    - **Change Data Capture (CDC)**: Debezium est configuré pour écouter les changements dans la base de données PostgreSQL et émettre ces événements de changement à Kafka, qui sert de système de messagerie distribué.
    - **Intégration de données**: Apache NiFi utilise ces données et peut les transformer ou les acheminer vers d'autres systèmes.

4. **Scripting avec Python**:
    - **Automatisation**: Un script Python est utilisé pour automatiser certaines tâches ou traiter les données avant qu'elles ne soient envoyées à un service de stockage tel qu'Amazon S3.

5. **Stockage de données dans Amazon S3**:
    - **Archivage**: Les données transformées ou extraites sont stockées dans Amazon S3, un service de stockage d'objets hautement scalable et durable.

6. **Extraction de données avec un Crawler**:
    - **Récupération de données externes**: Un crawler (programme qui visite automatiquement les sites web pour indexer leur contenu) récupère des données externes nécessaires au système.

7. **AWS Glue**:
    - **ETL (Extract, Transform, Load)**: AWS Glue est un service géré qui prépare et transforme les données pour l'analyse.
    - **Catalogue de données**: Il fournit également un catalogue de données qui sert de référentiel central pour la métadonnée et peut organiser les données en provenance de diverses sources.

8. **Analyse de données avec Amazon Athena**:
    - **Requêtes SQL sur S3**: Amazon Athena permet d'exécuter des requêtes SQL directement sur les fichiers stockés dans S3, ce qui rend l'analyse de données volumineuses plus facile et rapide sans nécessiter de serveurs de données traditionnels.

En résumé, le système décrit est un pipeline de données complet, depuis la collecte de données par l'API FastAPI, la capture de modifications avec Debezium, le traitement et le routage avec Kafka et NiFi, le stockage sur S3, suivi par l'extraction avec un crawler, et finalement l'analyse avec AWS Glue et Athena. Ce type de système est typique dans les scénarios de big data où la vitesse, la flexibilité et l'évolutivité sont cruciales.

# 3 - PARTIE 3 - Autres descriptions  - Décomposition du workflow étape par étape et expliquation de chaque composant et son rôle dans le système proposé

Voici comment les différentes parties du diagramme interagissent :

1. **Amazon EC2 avec NGINX et FastAPI** :
    - **Amazon EC2** : C'est un service de cloud computing qui permet de louer des serveurs virtuels sur lesquels vous pouvez exécuter vos applications. Imaginez-le comme un ordinateur que vous pouvez utiliser à distance.
    - **NGINX** : C'est un serveur web qui peut également servir de "reverse proxy", c'est-à-dire qu'il reçoit les requêtes internet avant de les transmettre à l'application FastAPI. Il peut gérer de nombreux utilisateurs simultanément, en distribuant la charge pour garder l'application rapide.
    - **FastAPI** : C'est un cadre (framework) pour créer des interfaces de programmation d'applications (API), qui sont des moyens pour les logiciels de communiquer entre eux. FastAPI est connu pour sa vitesse et facilite la création d'API robustes et bien documentées.

2. **Ubuntu avec Docker** :
    - **Ubuntu** : Il s'agit d'un système d'exploitation, comme Windows ou macOS, mais il est souvent utilisé sur les serveurs pour sa stabilité et sa sécurité.
    - **Docker** : Docker permet de créer des "conteneurs", qui emballent une application et tout ce dont elle a besoin pour fonctionner. Cela garantit que l'application se comportera de la même manière, peu importe où elle est exécutée, que ce soit sur votre ordinateur personnel ou un serveur dans le cloud.

3. **Kafka et Debezium** :
    - **Kafka** : C'est une plateforme de traitement des flux de données qui peut gérer des quantités massives d'événements (comme des messages ou des actions des utilisateurs) en temps réel. C'est comme un système de messagerie géant pour vos données.
    - **Debezium** : C'est un outil qui surveille votre base de données (dans ce cas, PostgreSQL) et détecte les changements. Lorsque des données sont ajoutées, modifiées ou supprimées, Debezium crée un "événement" avec ces détails et l'envoie à Kafka.

4. **PostgreSQL** :
    - **PostgreSQL** : C'est un système de gestion de base de données relationnelle. Cela signifie qu'il stocke les données de manière structurée, en utilisant des tables comme un classeur très organisé.

5. **Apache NiFi** :
    - **NiFi** : C'est un système de gestion de flux de données. Il permet de créer des workflows visuels qui automatisent le mouvement des données entre les systèmes et leur traitement. NiFi est comme un chef d'orchestre qui dirige les données là où elles doivent aller.

6. **Python** :
    - **Python** : C'est un langage de programmation populaire et facile à apprendre. Dans ce système, des scripts Python peuvent être utilisés pour effectuer des tâches comme analyser les données, les formater, ou les déplacer d'un service à un autre.

7. **Amazon S3, Crawler, AWS Glue, et Amazon Athena** :
    - **Amazon S3** : C'est un système de stockage dans le cloud où vous pouvez garder de grandes quantités de données. Pensez à S3 comme à un disque dur géant dans le cloud.
    - **Crawler** : C'est un programme qui automatise la collecte de données à partir de différentes sources. C'est comme un robot qui va sur internet, récupère des données et les ramène pour que vous puissiez les utiliser.
    - **AWS Glue** : C'est un service qui permet de préparer et de charger les données pour l'analyse, souvent en les transformant et en les organisant. Il crée également un catalogue de données, qui est comme un index qui vous aide à trouver et à gérer vos données.
    - **Amazon Athena** : C'est un service d'interrogation qui vous permet d'exécuter des requêtes SQL, un langage utilisé pour communiquer avec les bases de données, directement sur les données stockées dans S3. Vous pouvez poser des questions complexes à vos données et obtenir des réponses rapidement, sans avoir à configurer un serveur de base de données.

Dans l'ensemble, ce système est conçu pour traiter de grandes quantités de données en temps réel, de leur collecte initiale à l'analyse finale. Il permet aux utilisateurs de voir des informations actualisées, de prendre des décisions basées sur les données, et d'automatiser les processus qui nécessitent une compréhension des données en constante évolution.

# 4 - Scénario 1 

Imaginons un scénario où une entreprise souhaite surveiller en temps réel les avis des clients sur ses produits à partir de différentes sources en ligne, les analyser pour en tirer des insights et réagir rapidement aux retours négatifs.

1. **Collecte des Avis via FastAPI sur Amazon EC2** :
    - Un **développeur** crée une API avec FastAPI qui permet de recueillir les avis des clients envoyés depuis l'application mobile de l'entreprise.
    - L'API est déployée sur un serveur Amazon EC2, et NGINX est utilisé pour gérer les requêtes entrantes, garantissant que le système peut gérer de nombreux avis simultanément sans ralentissement.

2. **Conteneurisation avec Docker sur Ubuntu** :
    - Le **développeur d'infrastructures** configure Docker sur une machine Ubuntu pour que l'API FastAPI et d'autres services associés puissent être déployés dans des conteneurs, assurant la portabilité et l'indépendance du système d'exploitation.

3. **Flux de Données avec Kafka et Debezium** :
    - Chaque fois qu'un avis est ajouté à la base de données PostgreSQL, **Debezium** détecte ce changement et envoie un message à **Kafka**.
    - Kafka s'occupe de la gestion de ces messages qui représentent des avis, garantissant qu'ils sont traités efficacement et sans perte de données.

4. **Gestion des Données avec Apache NiFi** :
    - **NiFi**, configuré par l'ingénieur de données, récupère les avis depuis Kafka, les transforme si nécessaire (par exemple, en éliminant les informations personnelles pour respecter la confidentialité), et les transmet pour stockage ou analyse supplémentaire.

5. **Stockage de Données dans Amazon S3** :
    - Les avis traités sont ensuite stockés de manière sécurisée et durable dans **Amazon S3** par un script Python, où ils peuvent être récupérés et analysés à tout moment.

6. **Extraction de Données avec un Crawler** :
    - Parallèlement, un **Crawler** configuré par l'ingénieur de données extrait des avis sur les produits de l'entreprise à partir de sites web tiers pour obtenir une vue complète de l'opinion des clients sur le web.

7. **Préparation des Données avec AWS Glue** :
    - **AWS Glue** est utilisé pour cataloguer et préparer toutes les données collectées, les avis de l'application mobile et ceux du Crawler, pour l'analyse.

8. **Analyse des Données avec Amazon Athena** :
    - Un analyste de données utilise **Amazon Athena** pour exécuter des requêtes sur les données stockées dans S3, permettant d'obtenir rapidement des insights sur les tendances des avis des clients, les problèmes de produits récurrents, ou les points forts à promouvoir.

Avec ce système, l'entreprise peut désormais réagir rapidement aux avis négatifs, ajuster sa stratégie produit et marketing, et améliorer l'expérience client de manière proactive.

# Scénario 2 

Imaginons que vous êtes un ingénieur de données travaillant pour une firme de trading. Vous devez concevoir et mettre en œuvre une pipeline de streaming en temps réel pour extraire les données de marché des actions, de l'Ethereum et du Bitcoin à partir d'une API boursière et construire des tableaux de bord qui surveillent ces actifs en temps réel.

**Résumé du Projet :**
- **But du projet** : Créer un système capable de capturer en continu et d'analyser les données de marché pour les actions et les cryptomonnaies en temps réel.
- **Utilisateurs finaux** : Les traders, analystes financiers et gestionnaires de fonds qui ont besoin de suivre les mouvements du marché instantanément pour prendre des décisions éclairées.

**Mise en Œuvre :**

1. **Ingestion des Données avec Apache NiFi** :
    - Vous utilisez **Apache NiFi** pour ingérer les données des stocks en temps réel depuis l'API boursière. NiFi collecte les données, les traite pour assurer qu'elles sont dans le format requis et les transfère vers le système de base de données.

2. **Stockage des Données dans MySQL** :
    - Les données sont stockées dans une base de données **MySQL**. Cette base sert de système central pour conserver toutes les informations de marché que vous collectez.

3. **Capture de Données de Changement avec Debezium** :
    - Pour capturer et diffuser les modifications en temps réel de votre base de données, vous mettez en place **Debezium**. C'est un outil de CDC qui surveille la base de données MySQL et envoie chaque événement de modification (insertion, mise à jour, suppression) à un sujet Kafka dans Amazon MSK (Managed Streaming for Apache Kafka).

4. **Traitement des Flux avec Spark Streaming** :
    - **Spark Streaming** prend les données de marché brutes du sujet Kafka et les transforme. Cela pourrait inclure le nettoyage des données, le calcul de nouvelles métriques (comme les moyennes mobiles), ou l'enrichissement des données avec d'autres sources.

5. **Chargement dans la Base de Données Glue** :
    - Une fois transformées, les données sont chargées dans une base de données **AWS Glue**. Glue est un service ETL managé et sert ici comme une couche d'entrepôt de données analytiques.

6. **Requêtes et Tableaux de Bord avec Athena, Power BI et Tableau** :
    - Pour l'analyse et la visualisation, vous utilisez **Amazon Athena** pour interroger les données dans la base de données Glue.
    - Les résultats sont ensuite utilisés pour alimenter des tableaux de bord en temps réel dans **Power BI** et **Tableau**, des outils de visualisation de données qui permettent aux utilisateurs finaux d'observer et d'analyser les tendances du marché.

7. **Orchestration avec Airflow** :
    - Pour coordonner l'ensemble du flux de données, de l'ingestion à l'analyse, vous utilisez **Airflow**. Airflow est une plateforme d'orchestration qui vous permet de programmer, planifier et surveiller tous les processus de votre pipeline.

**Scénario d'Utilisation :**
- Un trader ouvre son tableau de bord et voit une fluctuation importante sur le Bitcoin. La pipeline a capturé cette donnée, l'a traitée et mise à disposition en quelques secondes.
- L'analyste financier, en observant les tableaux de bord, détecte une corrélation entre les actions d'une entreprise technologique et l'Ethereum. Il utilise cette information pour conseiller sur les futures positions à prendre.
- Le gestionnaire de fonds surveille la performance globale du portefeuille d'investissement et repère une opportunité basée sur les données en temps réel fournies par le pipeline.

Ce pipeline assure une visibilité immédiate sur les marchés financiers et permet à la firme de trading de réagir rapidement aux opportunités et aux risques potentiels.


