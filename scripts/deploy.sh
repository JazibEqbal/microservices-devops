#!/bin/bash

set -e

IMAGE_TAG=$1

if [ -z "$IMAGE_TAG" ]; then
    echo "Usage: ./deploy.sh <image-tag>"
    exit 1
fi

echo "=================Applying Kubernetes manifests================="

kubectl apply -f k8s/namespace.yml -n devops

kubectl apply -f k8s/ -n devops

echo "=================Kubernetes manifests applied successfully================="

echo "Deploying image tag: $IMAGE_TAG"
REGISTRY="ghcr.io/jazibeqbal/microservices-devops"

kubectl set image deployment/api-deployment \
    api-container=$REGISTRY/devops-app:$IMAGE_TAG -n devops

kubectl set image deployment/message-service-deployment \
    message-service-container=$REGISTRY/message-service:$IMAGE_TAG -n devops

kubectl set image deployment/food-service-deployment \
    food-service-container=$REGISTRY/food-service:$IMAGE_TAG -n devops

echo "Waiting for API deployment..."

if ! kubectl rollout status deployment/api-deployment \
    -n devops \
    --timeout=120s; then

    echo "API deployment failed."
    echo "Rolling back API..."

    kubectl rollout undo deployment/api-deployment \
        -n devops

    kubectl rollout status deployment/api-deployment \
        -n devops \
        --timeout=120s

    echo "API rollback completed."

    exit 1
fi


echo "Waiting for Message Service deployment..."

if ! kubectl rollout status deployment/message-service-deployment \
    -n devops \
    --timeout=120s; then

    echo "Message Service deployment failed."
    echo "Rolling back Message Service..."

    kubectl rollout undo deployment/message-service-deployment \
        -n devops

    kubectl rollout status deployment/message-service-deployment \
        -n devops \
        --timeout=120s

    echo "Message Service rollback completed."

    exit 1
fi


echo "Waiting for Food Service deployment..."

if ! kubectl rollout status deployment/food-service-deployment \
    -n devops \
    --timeout=120s; then

    echo "Food Service deployment failed."
    echo "Rolling back Food Service..."

    kubectl rollout undo deployment/food-service-deployment \
        -n devops

    kubectl rollout status deployment/food-service-deployment \
        -n devops \
        --timeout=120s

    echo "Food Service rollback completed."

    exit 1
fi

#bash ./scripts/smoke-test.sh

echo "Rollout completed successfully."
