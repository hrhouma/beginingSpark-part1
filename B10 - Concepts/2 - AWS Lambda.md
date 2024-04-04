# AWS Lambda - Guide de démarrage

AWS Lambda est un service de calcul sans serveur qui vous permet d'exécuter votre code en réponse à des événements et des déclencheurs automatiques provenant de plus de 200 services AWS et applications SaaS, sans provisionner ni gérer des serveurs. AWS Lambda exécute votre code uniquement quand cela est nécessaire et s'adapte automatiquement, de quelques requêtes par jour à des milliers par seconde.

## Caractéristiques Principales

- **Sans serveur**: Aucune gestion de serveur nécessaire. AWS Lambda s'occupe de toute la capacité, la mise à l'échelle, le patching, et la gestion de l'infrastructure.
- **Facturation à l'utilisation**: Vous payez uniquement pour le temps de calcul que vous consommez.
- **Évolutif**: S'adapte automatiquement à l'échelle de l'exécution de votre code.
- **Intégration avec l'écosystème AWS**: Intègre et répond aux événements provenant de services AWS tels que S3, DynamoDB, Kinesis, et SNS, ainsi que des applications SaaS.

## Premiers Pas avec AWS Lambda

### 1. Configuration de l'Environnement

Assurez-vous d'avoir un compte AWS actif. Installez et configurez l'AWS CLI et configurez vos identifiants AWS pour interagir avec les services AWS.

### 2. Création de votre première fonction Lambda

- **Console AWS**:
  1. Connectez-vous à la console AWS et ouvrez le service AWS Lambda.
  2. Cliquez sur **Créer une fonction**.
  3. Suivez l'assistant de création en choisissant un runtime pour votre code, en configurant les déclencheurs d'événements, et en définissant les droits d'accès nécessaires via les rôles IAM.

- **AWS CLI**:
  Exécutez la commande suivante pour créer une fonction Lambda qui exécute un exemple de code Python.

  ```sh
  aws lambda create-function --function-name MaPremiereFonction \
  --zip-file fileb://mon-code.zip --handler mon-code.main --runtime python3.8 \
  --role arn:aws:iam::123456789012:role/execution_role
  ```

### 3. Invocation de votre fonction

- **Console AWS**:
  1. Naviguez à votre fonction dans la console AWS Lambda.
  2. Cliquez sur l'onglet **Tester** pour créer un événement de test.
  3. Cliquez sur **Tester** pour exécuter votre fonction avec l'événement de test.

- **AWS CLI**:
  Utilisez la commande suivante pour invoquer votre fonction avec un payload d'événement.

  ```sh
  aws lambda invoke --function-name MaPremiereFonction \
  --payload '{"key": "value"}' response.json
  ```

## Bonnes Pratiques

- **Sécurité**: Utilisez des rôles IAM avec le principe du moindre privilège.
- **Monitoring et Logging**: Utilisez Amazon CloudWatch pour surveiller et enregistrer les exécutions de votre fonction.
- **Optimisation des Performances**: Ajustez la mémoire et le temps d'exécution en fonction des besoins de votre application.
- **Gestion des Dépendances**: Incluez uniquement les bibliothèques nécessaires dans votre package de déploiement pour réduire la taille et améliorer les temps de démarrage à froid.

## Ressources Utiles

- [Documentation officielle AWS Lambda](https://docs.aws.amazon.com/lambda/latest/dg/welcome.html)
- [Meilleures pratiques pour AWS Lambda](https://docs.aws.amazon.com/lambda/latest/dg/best-practices.html)
- [FAQ AWS Lambda](https://aws.amazon.com/lambda/faqs/)
