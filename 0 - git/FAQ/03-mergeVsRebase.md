# Différences entre `git merge` et `git rebase`  :

![image](https://github.com/user-attachments/assets/2cd31f13-b077-4b93-935c-5f4bb193825e)

### Git Merge
- **Opération :** `git merge develop`
- **Objectif :** Intégrer les modifications d'une branche (`develop`) dans une autre (`feature/login`).
- **Processus :** Git crée un nouveau "commit de fusion" qui a deux parents, un pour le dernier commit de chaque branche. Cela préserve l'historique tel qu'il s'est produit.
- **Résultat :** L'historique de la branche `feature/login` montre une structure avec une bifurcation, où le commit de fusion combine les historiques des deux branches.

### Git Rebase
- **Opération :** `git rebase develop`
- **Objectif :** Appliquer de nouveau les commits sur le sommet d'une autre branche de base.
- **Processus :** Rebaser prend les modifications faites dans la branche `feature/login` et les réapplique sur le sommet de la branche `develop`.
- **Résultat :** Cela rend l'historique linéaire, comme si les modifications avaient été faites juste après les dernières modifications dans `develop`.

### Différences Clés
- **Préservation de l'historique :** Merge ne modifie pas l'historique existant, tandis que rebase réécrit l'historique des commits pour le rendre linéaire.
- **Résolution de conflits :** Avec merge, les conflits sont résolus à la fin du processus de fusion, tandis que rebase peut nécessiter de résoudre des conflits tout au long du processus à mesure que chaque commit est réappliqué.

En bref, `merge` est utilisé pour conserver un historique précis des changements, tandis que `rebase` est préféré pour simplifier l'historique avant l'intégration d'une branche de fonctionnalités.
