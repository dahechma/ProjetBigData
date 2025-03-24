# Projet Big Data - Analyse en temps réel des transports TAN de Nantes

Ce projet exploite l'API temps réel Naolib de Nantes Métropole pour collecter, traiter et analyser les données des transports en commun de Nantes. Nous utilisons Kafka pour l'ingestion de données en temps réel et Apache Spark pour l'analyse batch et streaming.

## Aperçu du projet

Notre projet met en place un pipeline complet de données pour:

1. Collecter les données en temps réel des arrêts et temps d'attente des transports de Nantes
2. Stocker ces données dans Kafka comme source de vérité
3. Réaliser des analyses batch pour comprendre les tendances générales
4. Mettre en œuvre des analyses streaming avec fenêtres temporelles pour la surveillance en temps réel

## Structure du projet

```
projet-tan-api/
│
├── docker-compose.yml      # Configuration Docker
├── Dockerfile              # Image Docker pour le notebook
├── requirements.txt        # Dépendances Python
│
├── notebooks/
│   ├── tan-init-kafka.ipynb        # Initialisation et collecte des données Kafka
│   ├── tan-batch-analysis.ipynb    # Analyse batch des données collectées
│   └── tan-streaming-analysis.ipynb # Analyse streaming temps réel
│
└── README.md               # Ce fichier
```

## Prérequis

- Docker et Docker Compose
- Un minimum de 8 Go de RAM disponible pour exécuter tous les services
- Une connexion Internet pour accéder à l'API TAN

## Installation et démarrage

1. **Clonez le dépôt**

   ```bash
   git clone <url-du-dépôt>
   cd projet-tan-api
   ```

2. **Démarrez les services avec Docker Compose**

   ```bash
   docker-compose up -d
   ```

3. **Accédez à Jupyter Notebook**

   - Ouvrez votre navigateur à l'adresse: http://localhost:8888
   - Vous aurez accès aux notebooks dans le dossier `/work/notebooks`

4. **Interfaces additionnelles**
   - Spark UI: http://localhost:8080
   - Kafka UI: http://localhost:8082
   - Minio UI: http://localhost:19001 (utilisateur: root, mot de passe: password)

## Utilisation des notebooks

Pour reproduire notre analyse, exécutez les notebooks dans l'ordre suivant:

1. **tan-init-kafka.ipynb**

   - Ce notebook initialise la collecte de données depuis l'API TAN vers Kafka
   - Il récupère les informations sur les arrêts à proximité et les temps d'attente
   - Exécutez la collecte continue pour au moins 5-10 minutes afin d'obtenir suffisamment de données

2. **tan-batch-analysis.ipynb**

   - Analyse les données collectées en mode batch
   - Génère des visualisations sur la distribution des arrêts et les temps d'attente
   - Identifie les tendances dans les données de transport

3. **tan-streaming-analysis.ipynb**
   - Met en place des analyses en streaming avec des fenêtres temporelles
   - Surveille les arrêts et les temps d'attente en temps réel
   - Détecte les anomalies potentielles dans le service

## Analyses réalisées

### Analyses Batch

1. **Distribution des arrêts de transport**

   - Répartition spatiale des arrêts
   - Nombre d'arrêts par ligne
   - Distances moyennes entre les points d'intérêt et les arrêts

2. **Analyse des temps d'attente**
   - Temps d'attente moyen par ligne
   - Distribution des temps d'attente
   - Identification des arrêts avec les temps d'attente les plus longs

### Analyses Streaming

1. **Surveillance des arrêts en temps réel**

   - Statistiques sur les arrêts par fenêtres de 5 minutes
   - Évolution de la distance moyenne des arrêts

2. **Tendances des temps d'attente**
   - Temps d'attente moyen par ligne sur des fenêtres de 10 minutes glissant toutes les 5 minutes
   - Détection d'anomalies pour identifier les perturbations potentielles

## Architecture technique

Notre architecture utilise les technologies suivantes:

- **Kafka**: Système de messagerie distribué pour l'ingestion de données en temps réel
- **Apache Spark**: Framework de traitement de données pour les analyses batch et streaming
- **Jupyter Notebook**: Interface interactive pour l'exécution du code et la visualisation
- **Pandas & Seaborn**: Bibliothèques Python pour l'analyse et la visualisation de données
- **Docker & Docker Compose**: Pour la conteneurisation et l'orchestration des services

## Membres du groupe

- [Membre 1] - Responsable de [Tâche]
- [Membre 2] - Responsable de [Tâche]
- [Membre 3] - Responsable de [Tâche]
- [Membre 4] - Responsable de [Tâche]

## Perspectives et améliorations futures

- Intégration avec d'autres API de mobilité pour une vision plus complète
- Mise en place d'un tableau de bord en temps réel
- Développement d'algorithmes de prédiction des temps d'attente
- Stockage des données historiques dans une base de données NoSQL
