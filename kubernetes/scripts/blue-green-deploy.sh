#!/bin/bash

# Blue-Green Deployment Script
# Usage: ./blue-green-deploy.sh <service-name> <new-image-tag> <environment>

SERVICE_NAME=$1
NEW_IMAGE_TAG=$2
ENVIRONMENT=${3:-dev}

if [ -z "$SERVICE_NAME" ] || [ -z "$NEW_IMAGE_TAG" ]; then
    echo "Usage: ./blue-green-deploy.sh <service-name> <new-image-tag> <environment>"
    echo "Example: ./blue-green-deploy.sh frontend v1.2.0 dev"
    exit 1
fi

# Get current version (blue or green)
CURRENT_VERSION=$(kubectl get deployment ${SERVICE_NAME} -n ${ENVIRONMENT} -o jsonpath='{.spec.selector.matchLabels.version}' 2>/dev/null || echo "blue")

# Determine new version
if [ "$CURRENT_VERSION" = "blue" ]; then
    NEW_VERSION="green"
else
    NEW_VERSION="blue"
fi

echo "Current version: $CURRENT_VERSION"
echo "Deploying new version: $NEW_VERSION"
echo "Service: $SERVICE_NAME"
echo "Image tag: $NEW_IMAGE_TAG"
echo "Environment: $ENVIRONMENT"

# Create new deployment with new version
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ${SERVICE_NAME}-${NEW_VERSION}
  namespace: ${ENVIRONMENT}
  labels:
    app: ${SERVICE_NAME}
    version: ${NEW_VERSION}
spec:
  replicas: 1
  selector:
    matchLabels:
      app: ${SERVICE_NAME}
      version: ${NEW_VERSION}
  template:
    metadata:
      labels:
        app: ${SERVICE_NAME}
        version: ${NEW_VERSION}
    spec:
      containers:
      - name: ${SERVICE_NAME}
        image: carharms/${SERVICE_NAME}:${NEW_IMAGE_TAG}
        ports:
        - containerPort: 80
        envFrom:
        - configMapRef:
            name: ${SERVICE_NAME}-config
EOF

# Wait for new deployment to be ready
echo "Waiting for new deployment to be ready..."
kubectl rollout status deployment/${SERVICE_NAME}-${NEW_VERSION} -n ${ENVIRONMENT}

# Switch service to new version
echo "Switching service to new version: $NEW_VERSION"
kubectl patch service ${SERVICE_NAME}-service -n ${ENVIRONMENT} -p '{"spec":{"selector":{"version":"'${NEW_VERSION}'"}}}'

echo "Service switched to version: $NEW_VERSION"

# Wait for confirmation
echo "Test the new version. Press 'y' to complete deployment or 'r' to rollback:"
read -r response

if [ "$response" = "y" ]; then
    # Delete the old deployment
    echo "Deleting old deployment..."
    kubectl delete deployment ${SERVICE_NAME}-${CURRENT_VERSION} -n ${ENVIRONMENT}

    echo "Deployment completed successfully! The old deployment has been removed."
else
    # Rollback - switch service back to old version
    echo "Rolling back to version: $CURRENT_VERSION"
    kubectl patch service ${SERVICE_NAME}-service -n ${ENVIRONMENT} -p '{"spec":{"selector":{"version":"'${CURRENT_VERSION}'"}}}'
    
    # Delete the failed new deployment
    echo "Deleting new deployment..."
    kubectl delete deployment ${SERVICE_NAME}-${NEW_VERSION} -n ${ENVIRONMENT}
    
    echo "Rollback completed!"
fi