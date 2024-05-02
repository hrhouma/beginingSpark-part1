# Étape 1: Installation de Prometheus et Grafana
#### 1. Installation de Prometheus
1. **Télécharger Prometheus**:
   - Téléchargez Prometheus en version `tar.gz` depuis le [site officiel](https://prometheus.io/download/). Par exemple :
     ```bash
     wget https://github.com/prometheus/prometheus/releases/download/v2.37.6/prometheus-2.37.6.linux-amd64.tar.gz
     ```
   - Extrayez l'archive :
     ```bash
     tar -xvf prometheus-2.37.6.linux-amd64.tar.gz
     ```
   - Déplacez-vous dans le répertoire extrait :
     ```bash
     cd prometheus-2.37.6.linux-amd64
     ```

2. **Configurer Prometheus**:
   - Modifiez le fichier `prometheus.yml` pour ajouter les brokers Kafka :
     ```yaml
     global:
       scrape_interval: 15s

     scrape_configs:
       - job_name: 'kafka'
         static_configs:
           - targets: ['localhost:19092', 'localhost:29092', 'localhost:39092']
     ```

3. **Démarrer Prometheus**:
   - Exécutez Prometheus en utilisant le fichier de configuration :
     ```bash
     ./prometheus --config.file=prometheus.yml
     ```
   - Prometheus devrait maintenant être accessible à `http://localhost:9090`.

#### 2. Installation de Grafana
1. **Ajouter le Référentiel Grafana**:
   - Ajoutez le référentiel Grafana à votre système :
     ```bash
     sudo tee /etc/yum.repos.d/grafana.repo <<EOF
     [grafana]
     name=grafana
     baseurl=https://packages.grafana.com/oss/rpm
     repo_gpgcheck=1
     enabled=1
     gpgcheck=1
     gpgkey=https://packages.grafana.com/gpg.key
     EOF
     ```

2. **Installer Grafana**:
   - Installez Grafana :
     ```bash
     sudo yum install grafana
     ```

3. **Démarrer Grafana**:
   - Démarrez Grafana :
     ```bash
     sudo systemctl start grafana-server
     ```
   - Accédez à Grafana à `http://localhost:3000`.

### Étape 2: Configuration de Prometheus et Grafana
1. **Ajouter une Source de Données Prometheus**:
   - Dans Grafana, allez dans **Configuration > Sources de données**.
   - Ajoutez une nouvelle source Prometheus en indiquant l'URL `http://localhost:9090`.

2. **Créer un Tableau de Bord**:
   - Importez un tableau de bord Kafka préconstruit depuis le [site officiel de Grafana](https://grafana.com/dashboards) ou créez-en un personnalisé.

### Étape 3: Intégrer le Monitoring avec Docker Compose
1. **Ajouter des Services pour Prometheus et Grafana**:
   - Ajoutez Prometheus et Grafana à votre fichier Docker Compose existant :
     ```yaml
     version: '3'
     services:
       prometheus:
         image: prom/prometheus:latest
         container_name: prometheus
         ports:
           - "9090:9090"
         volumes:
           - ./prometheus.yml:/etc/prometheus/prometheus.yml

       grafana:
         image: grafana/grafana:latest
         container_name: grafana
         ports:
           - "3000:3000"
     ```

2. **Redémarrer les Services**:
   - Démarrez les nouveaux services :
     ```bash
     docker-compose up -d
     ```

3. **Configurer Grafana**:
   - Accédez à Grafana via `http://localhost:3000` et ajoutez Prometheus comme source de données.

4. **Créer ou Importer un Tableau de Bord**:
   - Créez ou importez un tableau de bord Kafka pour visualiser les métriques.



# Plus de détails - Étape 1: Installation de Prometheus et Grafana

Pour créer ou importer un tableau de bord Kafka dans Grafana, suivez ces étapes :

### Étape 1: Connecter Prometheus à Grafana
1. **Accéder à Grafana**:
   - Ouvrez votre navigateur et accédez à `http://localhost:3000`.
   - Connectez-vous avec le nom d'utilisateur et le mot de passe par défaut : `admin/admin`.

2. **Ajouter une Source de Données**:
   - Dans le menu latéral, allez à **Configuration > Data sources**.
   - Cliquez sur **Add data source** et choisissez **Prometheus**.
   - Configurez le champ `URL` avec `http://localhost:9090` (ou l'URL de votre service Prometheus).
   - Cliquez sur **Save & Test** pour confirmer que la connexion est établie.

### Étape 2: Importer un Tableau de Bord Kafka
1. **Trouver un Tableau de Bord Kafka**:
   - Allez sur [Grafana Dashboard](https://grafana.com/dashboards) et recherchez "Kafka".
   - Choisissez un tableau de bord qui répond à vos besoins. Notez l'ID du tableau de bord ou téléchargez le fichier JSON.

2. **Importer le Tableau de Bord**:
   - Dans Grafana, allez dans **Dashboards** dans le menu latéral.
   - Cliquez sur **Import**.
   - Si vous avez un fichier JSON, téléchargez-le. Sinon, entrez l'ID du tableau de bord et cliquez sur **Load**.
   - Sélectionnez votre source de données Prometheus et cliquez sur **Import**.

### Étape 3: Visualiser les Données
1. **Vérifier les Graphiques**:
   - Assurez-vous que les graphiques du tableau de bord affichent correctement les métriques de Kafka.
   - Si les graphiques ne s'affichent pas correctement, vérifiez la configuration du tableau de bord et de la source de données.

2. **Personnaliser le Tableau de Bord**:
   - Vous pouvez personnaliser les panneaux pour montrer les métriques qui vous intéressent le plus.
   - Sauvegardez vos modifications pour les futures démonstrations.

- En suivant ces étapes, vous pouvez importer un tableau de bord Kafka dans Grafana pour visualiser les métriques en temps réel de votre système Kafka.
