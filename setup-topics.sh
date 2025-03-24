#!/bin/bash

# Script pour initialiser les topics Kafka nécessaires au projet TAN
# À exécuter après le démarrage des conteneurs Docker

echo "Initialisation des topics Kafka pour le projet TAN..."

# Attendre que Kafka soit prêt
echo "Attente du démarrage complet de Kafka..."
sleep 10

# Définir le service Kafka
KAFKA_CONTAINER=kafka1
KAFKA_BOOTSTRAP_SERVERS=kafka1:9092

# Création des topics avec les configurations appropriées
echo "Création des topics..."

# Topic pour les arrêts de transport
docker exec $KAFKA_CONTAINER kafka-topics.sh \
    --create \
    --if-not-exists \
    --bootstrap-server $KAFKA_BOOTSTRAP_SERVERS \
    --replication-factor 1 \
    --partitions 3 \
    --topic tan_stops \
    --config retention.ms=86400000

# Topic pour les temps d'attente
docker exec $KAFKA_CONTAINER kafka-topics.sh \
    --create \
    --if-not-exists \
    --bootstrap-server $KAFKA_BOOTSTRAP_SERVERS \
    --replication-factor 1 \
    --partitions 3 \
    --topic tan_wait_times \
    --config retention.ms=86400000

# Topic pour les horaires
docker exec $KAFKA_CONTAINER kafka-topics.sh \
    --create \
    --if-not-exists \
    --bootstrap-server $KAFKA_BOOTSTRAP_SERVERS \
    --replication-factor 1 \
    --partitions 3 \
    --topic tan_schedules \
    --config retention.ms=86400000

echo "Liste des topics créés:"
docker exec $KAFKA_CONTAINER kafka-topics.sh --bootstrap-server $KAFKA_BOOTSTRAP_SERVERS --list

echo "Initialisation terminée!"