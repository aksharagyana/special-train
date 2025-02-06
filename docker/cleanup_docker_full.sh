#!/bin/bash

# Stop all running containers
echo "Stopping all running containers..."
docker stop $(docker ps -q)

# Remove all stopped containers
echo "Removing all stopped containers..."
docker rm $(docker ps -a -q)

# Remove all Docker images
echo "Removing all Docker images..."
docker rmi $(docker images -q) --force

# Remove all Docker volumes
echo "Removing all Docker volumes..."
docker volume rm $(docker volume ls -q) --force

# Remove all Docker networks (excluding the default networks)
echo "Removing all Docker networks..."
docker network rm $(docker network ls --filter "type=custom" -q)

# Remove any unused or dangling resources (volumes, networks, etc.)
echo "Pruning unused Docker resources..."
docker system prune -af

echo "Cleanup complete: All containers, images, volumes, and networks have been removed."
