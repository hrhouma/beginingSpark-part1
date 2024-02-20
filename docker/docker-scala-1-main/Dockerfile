# Utiliser l'image de base avec Jupyter et Spark préinstallés
FROM jupyter/pyspark-notebook

# Copier les fichiers de données dans l'image, ajustez les chemins selon vos fichiers
COPY test.txt /home/jovyan/test.txt
COPY 4300-0.txt /home/jovyan/4300-0.txt
COPY etudiants.txt /home/jovyan/etudiants.txt

# Exposer le port de Jupyter Notebook (optionnel, si vous souhaitez utiliser Jupyter)
EXPOSE 8888

# Commande pour démarrer le conteneur, ici on lance simplement le shell pour rester dans l'exemple interactif
CMD ["/bin/bash"]
