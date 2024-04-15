# filescsv-serde-projethive-scripts
Le code original est ici : https://github.com/PRkudupu/movie_recomendations . Malheureusement, il y avait beaucoup d'erreurs dans le code du développeur (son code ne fonctionne pas). Moi et mes étudiants avons retravaillé tout le code. Vous trouverez ci-joint notre version qui est fonctionnelle. Il suffit d'exécuter les fichiers sur Cloudera dans cet ordre:
script1.sh
script2.sql
Exécuter individuellement les commandes de script3.txt
J'ai ajouté .txt à la fin des deux fichiers pour que ça puisse passer par courriel.
Pour rouler le projet, il suffit d'éxécuter
1. sh (glisser le script1)
2. hive -f (glisser le script 2)
3. hive
4. show tables
5. les requêtes dans script3.sql 
par exemple,
select year(from_unixtime(rating_time)) rating_year,
       count(*) as cnt
from latest_ratings
group by year(from_unixtime(rating_time))
order by rating_year DESC;
 
 
Différence entre tables internes et tables externes dans HIVE


Hive supporte deux types de stockage HIVE (INTERNE, EXTERNE). 
Les TABLES EXTERNES présentent les avantages suivants : 
(1) Stockage des données sur HDFS, 
(2) Si la table externe est supprimée, les données sont toujours sur HDFS mais les métadonnées sont supprimées. 
(3) Pour l'aspect sécurité, tout est géré via HDFS 
 
Pour les TABLES INTERNES : 
(1) Le stockage des données se fait sur le Warehouse de HIVE 
(2) Si la table interne est supprimée, les données sont supprimées + les métadonnées 
(3) Pour l'aspect sécurité, tout est géré via HIVE 
 
En travaillant avec les tables externes, par contre, il faut un mécanisme pour HIVE pour qu’il soit capable de bien lire (parser) le format des données qui sont stockées sur HDFS.  J'ai utilisé SerDe (SerDe -abréviation de SerializerDeserializer) pour Hive afin de lui permettre de lire et écrire les données à partir des tables qui sont stockées sur HDFS. En effet, le format utilisé par HDFS pour stocker les données n’est pas la propriété de HIVE.  SerDe est un mécanisme très puissant qui permet donc à Hive d’analyser (et parser) les données qui sont stockées sur HDFS mais qui seront utilisées effectivement par HIVE pour l'analyse.  
Pour conclure, SerDE est une librairie qui permet à HIVE de lire les données d’une table et de l'écrire (write it back) sur HDFS dans n’importe format personnalisé. Tout le monde peut utiliser leurs propres formats de données en utilisant SerDe.   




