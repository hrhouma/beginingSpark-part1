---------------

# QUESTION 1

-------------------

1. **Création de la liste :**
   ```scala
   val list = List(1, 2, 3, 4, 5)
   ```
   **Résultat :** `List(1, 2, 3, 4, 5)`

2. **Application du filtre :**
   ```scala
   list.filter(_ % 2 == 0)
   ```
   **Résultat :** `List(2, 4)`

3. **Application de la transformation :**
   ```scala
   .map(_ * 2)
   ```
   **Résultat :** `List(4, 8)`



   # Explication de _

   En Scala, le symbole `_` est utilisé comme un **paramètre anonyme** dans les fonctions anonymes (ou lambdas). Il représente un ou plusieurs arguments passés à une fonction. Lorsque vous voyez `_` dans une expression, cela signifie "prenez l'argument qui est passé ici".

### Exemple dans votre code :
```scala
list.filter(_ % 2 == 0)
```
- Ici, `_` représente chaque élément de la liste sur laquelle `filter` est appliqué. Chaque élément est testé pour voir s'il est divisible par 2 (`_ % 2 == 0`).

```scala
.map(_ * 2)
```
- De même, dans cette expression, `_` représente chaque élément de la liste qui a été filtrée, et cet élément est multiplié par 2.

L'utilisation de `_` simplifie l'écriture de fonctions anonymes en évitant de devoir nommer explicitement les paramètres.


---------------

# QUESTION 2

-------------------
