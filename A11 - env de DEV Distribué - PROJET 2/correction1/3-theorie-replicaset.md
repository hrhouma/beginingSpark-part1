# Cours sur MongoDB et les Ensembles de Réplicas

## Introduction

- Bienvenue dans ce cours sur les ensembles de réplicas dans MongoDB !
- Nous allons plonger dans les concepts essentiels pour comprendre cette fonctionnalité clé de MongoDB, et vous verrez comment l'implémenter et l'utiliser efficacement.
  
# Référence : 
- https://blog.devgenius.io/how-to-deploy-a-mongodb-replicaset-using-docker-compose-a538100db471
---

## Table des Matières

1. [Qu'est-ce qu'un ensemble de réplicas ?](#qu-est-ce-qu-un-ensemble-de-réplicas)
2. [Pourquoi avez-vous besoin d'un ensemble de réplicas ?](#pourquoi-avez-vous-besoin-d-un-ensemble-de-réplicas)
3. [Oplog](#oplog)
4. [Comment fonctionne la réplication dans MongoDB ?](#comment-fonctionne-la-réplication-dans-mongodb)
5. [Qu'est-ce qu'un arbitre dans les ensembles de réplicas MongoDB ?](#qu-est-ce-qu-un-arbitre-dans-les-ensembles-de-réplicas-mongodb)
6. [Sécurité](#sécurité)
7. [Stratégies de Déploiement](#stratégies-de-déploiement)
8. [Réplication vs Sharding](#réplication-vs-sharding)
9. [Mise en Pratique](#mise-en-pratique)
10. [Conclusion](#conclusion)
11. [BONUS](#bonus)

---

## Qu'est-ce qu'un ensemble de réplicas ?

Un ensemble de réplicas dans MongoDB est un groupe d'instances MongoDB qui conservent les mêmes données. Plutôt que de dépendre d'une seule instance, un ensemble de réplicas assure la redondance et la disponibilité des données, jusqu'à 50 instances.

![image](https://github.com/hrhouma/beginingSpark-part1/assets/10111526/958a9b11-4640-465f-9dd1-6dc25a6d3601)


## Pourquoi avez-vous besoin d'un ensemble de réplicas ?

Les ensembles de réplicas offrent plusieurs avantages :
- **Haute disponibilité** : Les données restent accessibles même en cas de défaillance d'une instance.
- **Redondance** : Les ensembles de réplicas offrent une copie de secours des données.
- **Équilibrage de charge** : La lecture et l'écriture peuvent être réparties entre plusieurs instances.

## Oplog

Oplog, ou journal des opérations, est une collection spéciale utilisée pour enregistrer les changements apportés aux collections. Elle joue un rôle crucial dans la réplication des données dans un ensemble de réplicas.

## Comment fonctionne la réplication dans MongoDB ?

Un ensemble de réplicas a plusieurs instances qui gèrent les données ensemble. Le rôle principal est attribué à une instance appelée **PRINCIPALE**, tandis que d'autres instances, appelées **SECONDAIRES**, reçoivent et répliquent les données.

## Qu'est-ce qu'un arbitre dans les ensembles de réplicas MongoDB ?

Un arbitre participe uniquement aux élections pour déterminer quelle instance devient PRINCIPALE en cas de défaillance. Cependant, il ne contient pas de copie des données.

## Sécurité

L'ajout d'authentification et de chiffrement est crucial pour protéger les ensembles de réplicas.

## Stratégies de Déploiement

Choisissez une stratégie de déploiement en fonction de vos besoins : tolérance aux pannes, équilibrage de charge, etc.

## Réplication vs Sharding

- La réplication et le sharding répondent à différents besoins.
- Le sharding répartit les données, tandis que la réplication les duplique.

## Mise en Pratique

- Voici un exemple de `docker-compose.yml` pour déployer un ensemble de réplicas :

```yaml
version: '3'
services:
  mongo-primary:
    image: mongo
    command: mongod --replSet rs0
    ports:
      - "27017:27017"
  mongo-secondary:
    image: mongo
    command: mongod --replSet rs0
    ports:
      - "27018:27017"
```

## Conclusion

Les ensembles de réplicas de MongoDB offrent une haute disponibilité et une redondance des données. Ils sont indispensables pour les environnements de production.

## BONUS

- [Documentation Officielle de MongoDB](https://docs.mongodb.com/)
- [Tutoriel sur les Ensembles de Réplicas](https://example.com/tutorial-replica-sets)


# Annexe - Replicaset

Dans le contexte de MongoDB, un **Replica Set** est un ensemble de nœuds MongoDB qui conservent la même copie des données pour assurer la **redondance des données** et la **haute disponibilité**. Un Replica Set typique comporte :

- **Un nœud primaire** : qui reçoit toutes les écritures et coordonne la réplication.
- **Des nœuds secondaires** : qui répliquent les données du nœud primaire. Si le primaire tombe en panne, un des nœuds secondaires est élu pour le remplacer.

Le Replica Set offre des avantages comme la tolérance aux pannes, le basculement automatique et la répartition de la charge en lecture.

---

Dans le contexte de Kubernetes, un **ReplicaSet** est un objet qui garantit un nombre spécifique de pods fonctionnant à un moment donné. Il s'assure que le nombre spécifié de répliques de pods identiques soit maintenu, et gère leur déploiement et leur redémarrage en cas de défaillance. Un ReplicaSet fonctionne en :

- **Spécifiant un nombre de répliques souhaitées** : Kubernetes s'assure que le nombre exact de pods répliqués soit toujours opérationnel.
- **Définissant un sélecteur de pods** : pour identifier les pods gérés par le ReplicaSet.

- L'utilisation d'un ReplicaSet est courante avec un objet plus avancé appelé **Deployment**, qui gère les mises à jour, le déploiement progressif, le rollback, etc.

