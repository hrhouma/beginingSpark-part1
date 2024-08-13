# Commandes Magiques Essentielles dans Databricks

Les commandes magiques sont des extensions du code Python normal, fournies par le noyau IPython. Elles sont préfixées par le caractère `%` ou `%%`, permettant ainsi d'améliorer la productivité en ajoutant des fonctionnalités avancées au code.

## 1. Exécution d'un fichier externe

La commande `%run` permet d'exécuter un fichier Python externe depuis un notebook. Cette commande est particulièrement utile pour réutiliser du code déjà existant ou pour exécuter des scripts complexes.

```python
%run "/chemin/vers/monScript.py"
```

## 2. Temps d'exécution du code

La commande `%%time` permet de mesurer le temps d'exécution d'une cellule entière. Cela peut être utile pour optimiser le code ou comprendre les performances de certaines opérations.

```python
%%time
for i in range(1000000):
    pass
```

## 3. Copier le contenu dans un fichier externe

Avec la commande `%%writefile`, vous pouvez écrire directement le contenu d'une cellule dans un fichier, ce qui est pratique pour sauvegarder du code ou des résultats.

```python
%%writefile monCode.py
print("Hello, Databricks!")
```

## 4. Afficher le contenu d'un fichier externe

La commande `%pycat` affiche le contenu d'un fichier Python dans le notebook, permettant de visualiser rapidement un script sans avoir à l'ouvrir dans un autre éditeur.

```python
%pycat "/chemin/vers/monScript.py"
```

## 5. Lister toutes les variables

La commande `%who` affiche toutes les variables actuellement définies dans le notebook. Cela peut être utile pour garder une trace des objets en mémoire.

```python
a = "Bonjour"
b = 42
%who
```

## 6. Partager la variable entre les notebooks

Pour partager des variables entre différents notebooks, utilisez les commandes `%store` et `%store -r`.

```python
# Dans le premier notebook
a = "Ceci est partagé"
%store a

# Dans un autre notebook
%store -r a
print(a)
```

## 7. Exécuter le script HTML

La commande `%%html` permet d'écrire et d'exécuter du code HTML dans une cellule, transformant la sortie en rendu HTML directement dans le notebook.

```python
%%html
<h1>Bienvenue sur Databricks</h1>
```

## 8. Afficher les graphiques Matplotlib

La commande `%matplotlib inline` est utilisée pour afficher les graphiques directement dans le notebook. Cela active le support graphique interactif de Matplotlib.

```python
import matplotlib.pyplot as plt
%matplotlib inline

plt.plot([1, 2, 3, 4], [1, 4, 9, 16])
plt.show()
```

## 9. Définir les variables d'environnement

La commande `%env` permet de lister, récupérer ou définir des variables d'environnement directement dans le notebook.

```python
%env MY_VAR=42
```

## 10. Informations détaillées sur l'objet

La commande `%pinfo` fournit des informations détaillées sur un objet, comme sa documentation ou ses attributs.

```python
a = "Explorons Databricks"
%pinfo a
```

## Liste complète des commandes magiques

Vous pouvez obtenir la liste complète des commandes magiques disponibles en utilisant `%lsmagic`.

```python
%lsmagic
```
