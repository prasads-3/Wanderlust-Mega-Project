#!/bin/bash

set -e

echo "====================================="
echo "Updating GitOps Repository..."
echo "====================================="

rm -rf /tmp/wanderlust-gitops

git clone https://${GITHUB_USER}:${GITHUB_TOKEN}@github.com/prasads-3/wanderlust-gitops.git /tmp/wanderlust-gitops

cd /tmp/wanderlust-gitops

echo "GitOps Repository cloned successfully."

echo "Updating Backend Image..."

sed -i "s|image:.*wanderlust-backend-beta.*|image: prasad3737/wanderlust-backend-beta:${BACKEND_DOCKER_TAG}|g" kubernetes/backend.yaml

echo "Updating Frontend Image..."

sed -i "s|image:.*wanderlust-frontend-beta.*|image: prasad3737/wanderlust-frontend-beta:${FRONTEND_DOCKER_TAG}|g" kubernetes/frontend.yaml

echo "Committing changes..."

git config user.email "pj344504@gmail.com"
git config user.name "Prasad"

git add .

git commit -m "Updated images to Backend:${BACKEND_DOCKER_TAG} Frontend:${FRONTEND_DOCKER_TAG}" || echo "No changes to commit"

git push origin main

echo "GitOps Repository updated successfully."
