#!/bin/bash
# Script to clean and restart the TAN project environment

echo "=== Cleaning and restarting TAN project environment ==="

# Stop all containers
echo "Stopping all running containers..."
docker-compose down

# Remove containers that might conflict
echo "Removing any conflicting containers..."
docker rm -f minio zookeeper1 kafka1 jupyter kafka-ui 2>/dev/null

# Remove any related volumes (optional - uncomment if needed)
# echo "Removing related volumes..."
# docker volume prune -f

# Rebuild container images with new requirements
echo "Rebuilding container images..."
docker-compose build --no-cache

# Start fresh environment
echo "Starting fresh environment..."
docker-compose up -d

# Wait for services to start
echo "Waiting for services to initialize (30 seconds)..."
sleep 30

# Initialize Kafka topics
echo "Initializing Kafka topics..."
docker exec kafka1 kafka-topics.sh \
    --create \
    --if-not-exists \
    --bootstrap-server kafka1:9092 \
    --replication-factor 1 \
    --partitions 3 \
    --topic tan_stops

docker exec kafka1 kafka-topics.sh \
    --create \
    --if-not-exists \
    --bootstrap-server kafka1:9092 \
    --replication-factor 1 \
    --partitions 3 \
    --topic tan_wait_times

docker exec kafka1 kafka-topics.sh \
    --create \
    --if-not-exists \
    --bootstrap-server kafka1:9092 \
    --replication-factor 1 \
    --partitions 3 \
    --topic tan_schedules

# List created topics
echo "Created topics:"
docker exec kafka1 kafka-topics.sh --bootstrap-server kafka1:9092 --list

# Show running containers
echo "Running containers:"
docker-compose ps

echo "=== Environment setup complete ==="
echo "Jupyter: http://localhost:8888"
echo "Spark UI: http://localhost:8080"
echo "Kafka UI: http://localhost:8082"
echo "Minio UI: http://localhost:19001 (user: root, password: password)"