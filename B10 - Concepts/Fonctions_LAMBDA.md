# Les fonctions LAMBDA
- Les fonctions lambda, souvent appelées expressions lambda, sont une caractéristique de nombreux langages de programmation, dont Python. 
- Elles permettent de définir des fonctions anonymes, c’est-à-dire des fonctions sans nom, en une seule ligne de code.
- Cette particularité rend les fonctions lambda idéales pour des opérations simples et pour être utilisées là où une fonction de courte durée est nécessaire, surtout comme argument pour des fonctions de haut niveau qui acceptent d'autres fonctions comme paramètres.

### Définition et Syntaxe de base

La syntaxe de base d'une fonction lambda en Python est la suivante :

```python
lambda arguments: expression
```

- `lambda` est le mot-clé qui indique la définition d'une fonction lambda.
- `arguments` fait référence aux variables passées à la fonction. Comme pour une fonction normale, vous pouvez passer plusieurs arguments séparés par des virgules.
- `expression` est une expression qui est évaluée et retournée par la fonction. Les fonctions lambda ne peuvent contenir qu'une seule expression.

### Exemples d'Utilisation

Voici quelques exemples simples d'utilisation des fonctions lambda :

1. **Fonction lambda sans argument :**

```python
f = lambda: "Bonjour, monde !"
print(f())  # Affiche: Bonjour, monde !
```

2. **Fonction lambda avec un argument :**

```python
f = lambda x: x * x
print(f(4))  # Affiche: 16
```

3. **Fonction lambda avec plusieurs arguments :**

```python
f = lambda x, y: x + y
print(f(2, 3))  # Affiche: 5
```

### Utilisation avec les fonctions de haut niveau

Les fonctions lambda sont souvent utilisées en combinaison avec des fonctions de haut niveau qui prennent d'autres fonctions comme arguments, par exemple, `map()`, `filter()`, et `reduce()`.

- **Avec `map()` pour appliquer une opération à chaque élément d'une liste :**

```python
nums = [1, 2, 3, 4]
squared = list(map(lambda x: x ** 2, nums))
print(squared)  # Affiche: [1, 4, 9, 16]
```

- **Avec `filter()` pour filtrer une liste :**

```python
nums = [1, 2, 3, 4, 5, 6]
even_nums = list(filter(lambda x: x % 2 == 0, nums))
print(even_nums)  # Affiche: [2, 4, 6]
```

- **Avec `reduce()` pour réduire une liste à une seule valeur (nécessite `from functools import reduce`) :**

```python
from functools import reduce
nums = [1, 2, 3, 4]
sum = reduce(lambda x, y: x + y, nums)
print(sum)  # Affiche: 10
```

### Avantages et Limites

**Avantages :**

- Les fonctions lambda permettent de créer des fonctions anonymes rapidement.
- Elles rendent le code souvent plus clair et plus concis, surtout lors de l'utilisation de fonctions de haut niveau.

**Limites :**

- Elles sont limitées à une seule expression, ce qui les rend inadaptées pour des opérations complexes.
- L'usage excessif de fonctions lambda peut rendre le code difficile à lire, surtout pour des personnes non familières avec ce concept.

En résumé, les fonctions lambda sont un outil puissant dans la boîte à outils d'un programmeur, offrant une méthode concise pour définir des fonctions anonymes pour des opérations simples et temporaires.
