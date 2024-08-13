### 1. **Exécution d'un fichier externe**
Nous avons déjà vu l'utilisation de `%run` pour exécuter un script Python externe. Cela peut aussi s'appliquer pour des notebooks Jupyter complets.
```python
%run /Shared/MovieRecommendation/Authorization.py 
```
**Exemple supplémentaire** : Exécuter un autre notebook Jupyter dans le même environnement.
```python
%run /Shared/AnotherNotebook
```

### 2. **Mesurer le temps d'exécution**
Vous pouvez mesurer le temps d'exécution de cellules de code complètes pour analyser les performances.
```python
%%time
df_movies = spark.read.format(file_type) \
      .option("inferSchema", infer_schema) \
      .option("header", first_row_is_header) \
      .option("sep", delimiter) \
      .load(file_location)
display(df_movies)
```
- **Description** : Cette commande mesurera le temps total pris par la cellule pour s'exécuter, vous permettant de comprendre l'efficacité de votre code.

### 3. **Exporter du contenu dans un fichier externe**
Vous pouvez exporter le contenu de votre cellule directement dans un fichier, ce qui est utile pour générer des scripts Python ou des fichiers texte à partir du notebook.
```python
%%writefile output_script.py
import datetime
print("Ce script a été généré depuis un notebook Jupyter.")
```
- **Description** : Le contenu de la cellule sera écrit dans le fichier `output_script.py`.

### 4. **Afficher le contenu d'un fichier externe**
Pour vérifier rapidement le contenu d'un fichier externe sans l'ouvrir manuellement.
```python
%pycat /Shared/MovieRecommendation/Authorization.py
```
- **Description** : Cette commande affiche le contenu d’un fichier dans le notebook sans avoir à l’ouvrir dans un éditeur externe.

### 5. **Lister toutes les variables dans le notebook**
Vous pouvez lister toutes les variables définies dans le notebook, ce qui est utile pour suivre ce qui est utilisé.
```python
%who
```
- **Description** : Liste toutes les variables présentes dans le notebook. Pour filtrer par type de données, vous pouvez utiliser `%who str` pour lister uniquement les chaînes.

### 6. **Partager une variable entre notebooks**
Partagez une variable entre différents notebooks pour permettre une collaboration efficace.
```python
# Dans le premier notebook
foo = "This is a shared variable"
%store foo

# Dans un autre notebook
%store -r foo
print(foo)
```
- **Description** : Cela permet de stocker une variable dans un notebook et de la récupérer dans un autre.

### 7. **Exécuter du code HTML**
Vous pouvez insérer du code HTML directement dans une cellule et voir le rendu.
```python
%%html
<h1>Table des films</h1>
<table>
    <tr><th>Nom</th><th>Pays</th><th>Âge</th></tr>
    <tr><td>Sid</td><td>India</td><td>22</td></tr>
</table>
```
- **Description** : Cette commande permet de générer du HTML directement dans votre notebook.

### 8. **Afficher des graphiques Matplotlib en ligne**
Activez le rendu des graphiques Matplotlib directement dans le notebook.
```python
%matplotlib inline
import matplotlib.pyplot as plt
plt.scatter([1, 2, 3], [4, 5, 6])
plt.show()
```
- **Description** : Permet de visualiser directement les graphiques créés avec Matplotlib dans le notebook.

### 9. **Définir des variables d'environnement**
Manipulez les variables d'environnement depuis votre notebook.
```python
%env MY_ENV_VAR=Production
```
- **Description** : Définit une variable d'environnement qui peut être utilisée dans tout le notebook.

### 10. **Obtenir des informations détaillées sur un objet**
Obtenez des informations complètes sur une variable ou un objet en Python.
```python
foo = "Hello, World!"
%pinfo foo
```
- **Description** : Affiche des détails sur la variable `foo`, comme son type, sa documentation, etc.

### 11. **Lister toutes les commandes magiques disponibles**
Enfin, pour explorer toutes les commandes magiques disponibles dans votre environnement, utilisez :
```python
%lsmagic
```
- **Description** : Cette commande affiche une liste complète des commandes magiques disponibles dans IPython.


