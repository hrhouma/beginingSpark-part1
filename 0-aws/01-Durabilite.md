# Partie (02/10) - Durabilité

# 1 -  Introduction

La durabilité dans le contexte des services de stockage en nuage comme Amazon S3 (Simple Storage Service) se réfère à la capacité du service à préserver les données stockées de manière sécurisée et à long terme, sans perte de données. Amazon S3 offre une durabilité extrêmement élevée pour les objets stockés, grâce à une combinaison de technologies redondantes et de mécanismes de réplication.

### Durabilité

La durabilité est généralement mesurée en termes de probabilité annuelle de perte d'un objet. Amazon S3, par exemple, annonce une durabilité de **99.999999999%** (11 nines) pour les objets stockés. Cela signifie que, en théorie, il est extrêmement improbable qu'un objet soit perdu.
Pour calculer la différence entre 100% et 99.999999999% (11 nines), vous pouvez simplement soustraire ces deux pourcentages.

   - 100% = 1
   - 99.999999999% = 0.99999999999
   - 1 - 0.99999999999 = 0.00000000001

Donc, la différence entre 100% et 99.999999999% (11 nines) est 0.000000001% pour perdre un objet

### Probabilité de perdre un objet

La durabilité de **99.999999999%** (11 nines) signifie qu'il y a une probabilité très faible qu'un objet soit perdu au cours d'une année. Pour mettre cela en perspective :

1. **Nombre total de secondes dans une année :**
   
$$
   31 536 000 \text{ secondes}
$$

3. **Probabilité d'indisponibilité ou de perte d'un objet :**

$$
   0.00000000001 \text{ ou } 10^{-11} \text{ (soit 0.000000001% du temps)}
$$

4. **Calcul de la perte annuelle d'un objet :**

$$
   31 536 000 \text{ secondes/année} \times \frac{0.00000000001}{100} \text{ indisponibilité} = 0.0031536 \text{ secondes/année}
$$

Cela signifie que la probabilité de perdre un objet stocké dans Amazon S3 est extrêmement faible, et que sur une année entière, la perte d'un objet peut théoriquement se produire pendant une durée négligeable de **0.0031536 secondes**.

### Explication

- **Durabilité de 11 nines :** Cela indique que les données sont conçues pour être durables, avec une perte d'objets presque inexistante. Amazon S3 atteint cette durabilité en stockant de multiples copies de chaque objet sur plusieurs appareils dans différentes installations.

- **Redondance et réplication :** Amazon S3 utilise des mécanismes de réplication automatique pour copier les données sur plusieurs emplacements physiques distincts, minimisant ainsi le risque de perte due à des défaillances matérielles ou des catastrophes naturelles.

- **Vérifications et corrections automatiques :** Le service effectue régulièrement des vérifications d'intégrité et des corrections automatiques des données corrompues, augmentant encore la durabilité.

En résumé, la durabilité dans Amazon S3 signifie que vos données sont extrêmement sécurisées et résistantes à la perte, grâce à des copies multiples et des mécanismes de vérification continus, avec une probabilité de perte d'objet extraordinairement faible.

Expliquons brièvement la différence entre la disponibilité et la durabilité. Examinons cela avec un exemple basé sur la durabilité.

# 2 -  99.999% (cinq 9)
Supposons qu'une entreprise stocke 1 million d'objets de données dans un service de stockage en cloud offrant une durabilité de 99.999% sur une année. Avec une durabilité de 99.999%, la probabilité de perte de données est de 0.001% (0.00001/100 = 0.001%) par objet par an.

Calculons l'attente statistique de la perte de données pour cette entreprise :

$$
1 000 000 \text{ objets} \times 0.001% \text{ probabilité de perte par objet} = 10 \text{ objets perdus par an} 
$$

### 99.999999999% (11 neuf) - niveau maximal de durabilité
Imaginons un service de stockage de données en cloud qui offre une durabilité de 99.999999999% (11 neuf) sur une année donnée. Cela signifie qu'il y a une probabilité de 0.000000001% de perdre un objet de données au cours d'une année.

Supposons qu'une entreprise utilise ce service de stockage et qu'elle stocke 1 milliard d'objets dans le cloud. Avec une durabilité de 99.999999999%, ou une probabilité de perte de données de 0.000000001% par objet par an, on peut s'attendre, en moyenne, à perdre :

$$
1 000 000 000 \text{ objets} \times 0.000000001% \text{ probabilité de perte par objet} = 0.01 \text{ objet perdu par an} 
$$

Ce qui signifie qu'en moyenne, il faudrait environ 100 ans pour s'attendre à perdre un seul objet, sur la base de cette probabilité.

# 3 -  Disponibilité vs Durabilité
- **Disponibilité** : Elle concerne le temps d'accès aux données. Un système avec une haute disponibilité est celui qui est opérationnel et accessible lorsque vous en avez besoin. Les SLA de disponibilité sont souvent exprimés en termes de pourcentage de temps opérationnel par rapport à une période donnée, comme nous l'avons vu dans le tableau précédent.
- **Durabilité** : Elle se rapporte à la préservation à long terme des données. Un système offrant une haute durabilité assure que, une fois que les données ont été stockées, elles ne seront pas perdues ou endommagées au fil du temps. La durabilité est souvent exprimée en termes de probabilité de perte de données au cours d'une année donnée.

### Tableau de différents niveaux de durabilité et leur équivalent en probabilité de perte de données
| Durabilité (%) | Durabilité (nombre de neuf) | Probabilité de perte de données par an |
|----------------|-----------------------------|---------------------------------------|
| 99%            | 2                           | 1%                                    |
| 99.9%          | 3                           | 0.1%                                  |
| 99.99%         | 4                           | 0.01%                                 |
| 99.999%        | 5                           | 0.001%                                |
| 99.9999%       | 6                           | 0.0001%                               |
| 99.99999%      | 7                           | 0.00001%                              |
| 99.999999%     | 8                           | 0.000001%                             |
| 99.9999999%    | 9                           | 0.0000001%                            |
| 99.99999999%   | 10                          | 0.00000001%                           |
| 99.999999999%  | 11                          | 0.000000001%                          |
| 99.9999999999% | 12                          | 0.0000000001%                         |

# 4 - Conclusion
Même avec une très haute durabilité, il existe toujours une petite probabilité de perte de données. C'est pourquoi les systèmes de sauvegarde et les stratégies de récupération après incident sont cruciaux même dans les systèmes avec une durabilité très élevée. L'équilibre entre disponibilité, durabilité et coût doit être ajusté en fonction des besoins spécifiques et des exigences de votre application ou entreprise. Chaque ajout de "neuf" dans vos objectifs de durabilité ou de disponibilité peut augmenter considérablement la complexité et le coût de la solution de stockage.

[Retour en haut](#-Durabilité)

