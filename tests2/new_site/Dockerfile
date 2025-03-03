# Utiliser une image Python légère
FROM python:3.10-slim

# Définir le répertoire de travail
WORKDIR /app

# Copier les fichiers nécessaires
COPY main.py .
COPY templates/ templates/
COPY static/ static/

# Installer Flask
RUN pip install flask

# Exposer le port 5000
EXPOSE 5000

# Lancer l'application
CMD ["python", "main.py"]

