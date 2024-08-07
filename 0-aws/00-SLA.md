# Partie (01/10) - SLA

# 1 - SLA : Qu'est-ce que c'est ? (Disponibilité)
SLA signifie "Service Level Agreement" ou "Accord de Niveau de Service" en français. C'est fondamentalement une promesse entre un fournisseur de service et un client, indiquant le niveau de service que le client peut attendre.

# 2 -  Explication de 99.99999999999% (11 Neuf) SLA
Lorsqu'un fournisseur de services promet un SLA de 99.99999999999%, cela signifie qu'il assure que ses services seront disponibles et opérationnels 99.99999999999% du temps sur une période déterminée (par exemple, une année).

Pour mettre cela en perspective, si nous prenons une année entière (soit 31 536 000 secondes) et si le service n'est pas disponible seulement 0.00000000001% du temps, cela se traduit mathématiquement par :

$$
31 536 000 \text{ secondes} \times \frac{0.00000000001}{100} = 0.0031536 \text{ secondes}
$$

Cela signifie qu'avec un SLA de 99.99999999999%, le service promet d'être indisponible au maximum pendant environ 0.003 secondes par an.

# 3 - Pourquoi est-ce important ?
Pour les entreprises et les individus qui dépendent fortement des services numériques (par exemple, une boutique en ligne, un service bancaire en ligne, etc.), même une petite indisponibilité peut avoir des conséquences graves, telles que la perte de ventes, la perte de données, ou l'insatisfaction des clients.

Plus le pourcentage est élevé, plus le service est fiable, mais aussi plus le coût pour maintenir un tel niveau de service est élevé.

# 4 - Un Petit Exemple
Imaginons un service de stockage de données dans le cloud, un peu comme Amazon S3.

- **Sans un SLA fort** : Si le service est down (hors ligne ou inaccessible) même pour une courte durée, les entreprises qui dépendent de ce service pour stocker des données (comme les bases de données de clients, des fichiers importants, etc.) pourraient faire face à des problèmes tels que l'impossibilité d'accéder à des informations cruciales ou de réaliser des ventes.
- **Avec un SLA de 99.99999999999%** : Le service garantit qu'il sera quasiment toujours disponible, avec une très, très courte période d'indisponibilité possible (0.003 secondes par an). Cela rassure les entreprises clientes qu'elles pourront accéder à leurs données presque tout le temps sans interruption.

### Tableau de différents niveaux de SLA et leur équivalent en temps d'indisponibilité
| SLA (%)         | SLA (nombre de neuf) | Indisponibilité annuelle | Indisponibilité mensuelle | Indisponibilité hebdomadaire | Indisponibilité quotidienne |
|-----------------|----------------------|--------------------------|---------------------------|------------------------------|-----------------------------|
| 90%             | 1                    | 36.5 jours               | 3 jours                   | 16.8 heures                  | 2.4 heures                  |
| 99%             | 2                    | 3.65 jours               | 7.2 heures                | 1.68 heures                  | 14.4 minutes                |
| 99.9%           | 3                    | 8.76 heures              | 43.2 minutes              | 10.1 minutes                 | 1.44 minutes                |
| 99.99%          | 4                    | 52.6 minutes             | 4.32 minutes              | 1.01 minutes                 | 8.64 secondes               |
| 99.999%         | 5                    | 5.26 minutes             | 25.9 secondes             | 6.05 secondes                | 0.864 secondes              |
| 99.9999%        | 6                    | 31.5 secondes            | 2.59 secondes             | 0.605 secondes               | 0.0864 secondes             |
| 99.99999%       | 7                    | 3.15 secondes            | 0.259 secondes            | 0.0605 secondes              | 0.00864 secondes            |
| 99.9999999%     | 9                    | 0.315 secondes           | 0.0259 secondes           | 0.00605 secondes             | 0.000864 secondes           |
| 99.999999999%   | 10                   | 0.0315 secondes          | 0.00259 secondes          | 0.000605 secondes            | 0.0000864 secondes          |
| 99.9999999999%  | 11                   | 0.00315 secondes         | 0.000259 secondes         | 0.0000605 secondes           | 0.00000864 secondes         |
| 99.99999999999% | 12                   | 0.000315 secondes        | 0.0000259 secondes        | 0.00000605 secondes          | 0.000000864 secondes        |


# 5 - CONCLUSION
- Un SLA (Service Level Agreement), ou Accord de Niveau de Service en français, est une promesse entre un fournisseur de service et un client, définissant le niveau de service attendu. Un SLA de 99.99999999999% (11 neuf) indique que le service promet d'être opérationnel et disponible 99.99999999999% du temps, ce qui équivaut à une potentielle indisponibilité d'environ 0.003 secondes par an.
- Bien que ce niveau de disponibilité exceptionnellement élevé minimise les risques d'interruptions et garantit une fiabilité presque totale, il est également associé à des coûts et une complexité technique importants pour le fournisseur du service. Les entreprises s'appuient sur des SLA robustes pour assurer la continuité de leurs opérations numériques, tout en veillant à équilibrer les coûts et les bénéfices.
- Garantir un SLA avec un aussi haut niveau de disponibilité est complexe et coûteux, et il faut toujours peser le coût par rapport au bénéfice. En général, les exigences du SLA devraient être alignées avec les besoins réels de l'entreprise et le niveau de tolérance au risque.
