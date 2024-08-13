# Vue d'ensemble des services de stockage Azure

---
# **Point 1 : Services de stockage Azure et points de terminaison privés**
---

Azure Storage propose plusieurs services, chacun ayant son propre point de terminaison privé. Voici une liste de ces services et leurs URL de point de terminaison privé correspondantes :

| Service de stockage       | Sous-ressource cible | Nom de zone                         | URL du point de terminaison privé                   |
|---------------------------|----------------------|-------------------------------------|------------------------------------------------------|
| Service Blob              | blob                 | privatelink.blob.core.windows.net  |
| Data Lake Storage Gen2    | dfs                  | privatelink.dfs.core.windows.net   |
| Service de fichiers       | file                 | privatelink.file.core.windows.net  |
| Service de files d'attente| queue                | privatelink.queue.core.windows.net |
| Service de table          | table                | privatelink.table.core.windows.net |
| Sites Web statiques       | web                  | privatelink.web.core.windows.net   |

## Exemple  : 
- wasbs://mycontainer@mystorageaccount.blob.core.windows.net/myfolder/myfile.txt

---
# **Point 2 : Comprendre les différences entre ABFSS et WASBS dans Azure Storage**
---

### **Aperçu :**
- **ABFS (Azure Blob File System)** : Recommandé par Microsoft pour les charges de travail de Big Data en raison de son optimisation.
- **WASBS (Windows Azure Storage Blob Secure)** : Recommandé par Microsoft pour un accès chiffré TLS.

### **Stockage Blob avec HTTP :**
- Le stockage Blob est un stockage d'objets avec une structure plate (pas de dossiers/hiérarchie).
- Le protocole HTTP peut être utilisé pour lire et écrire des blobs.
- **Point de terminaison** : `https://storageaccount.blob.core.windows.net/container/path/to/blob`

### **Stockage Blob avec WASBS :**
- **Pilote WASBS** : Utilisé par les applications Hadoop pour la compatibilité HDFS.
- **Point de terminaison** : `wasbs://containername@accountname.blob.core.windows.net`
- Des outils comme HDInsight peuvent utiliser ce pilote pour se connecter au stockage Blob sur le même point de terminaison.

### **ADLS avec ABFSS :**
- **ADLS Gen2** : Prend en charge le stockage hiérarchique et les ACL sur les fichiers et dossiers.
- Le compte de stockage avec l'espace de noms hiérarchique activé devient ADLS Gen2.
- **Point de terminaison DFS** : `abfss://filesystemname@accountname.dfs.core.windows.net`
- **Pilote ABFS** : Efficace pour les applications Hadoop sans mappage complexe. Utilisé par des solutions comme Hortonworks, HDInsight, Azure Databricks.
- Certains outils comme PowerBI supportent à la fois WASBS et ABFSS.

### **Quel service utiliser :**
- **ADLS** :
  - Les outils de traitement des données (par ex. : Databricks, HDInsight) utilisent ABFSS sur le point de terminaison DFS.
  - Documentation des points de terminaison HTTP REST pour effectuer des appels HTTP si nécessaire.
- **Stockage Blob** :
  - Les outils de traitement des données peuvent utiliser WASBS sur le point de terminaison Blob. Le pilote ABFS peut également fonctionner.
  - D'autres cas d'utilisation peuvent utiliser les points de terminaison HTTP sans pilotes spéciaux (par ex. : application Python lisant/écrivant des fichiers).

### **Acronymes :**
- **ADLS** : Azure Data Lake Storage
- **WASB** : Windows Azure Storage Blob (non chiffré)
- **WASBS** : Windows Azure Storage Blob Secure (chiffré TLS)
- **ABFS** : Azure Blob File System
- **ABFSS** : Azure Blob File System Secure
- **DFS** : Distributed File System

---
# **Point 3 : Ressources supplémentaires**
---

### **Tutoriel vidéo : Monter Azure Data Lake Storage dans Databricks**
- **Lien YouTube** : [Monter Azure Data Lake Storage dans Databricks](https://www.youtube.com/watch?v=8Sn4SJ7y_5Y&ab_channel=CloudAndDataUniverse)

Cette vidéo de Cloud And Data Universe explique comment monter Azure Data Lake Storage dans Databricks, fournissant des informations pratiques sur le processus de configuration.

---

Pour une compréhension plus approfondie de ces mécanismes, il est fortement recommandé de visionner la vidéo fournie et de consulter la documentation supplémentaire sur le site officiel d'Azure.
