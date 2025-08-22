## Overview ##
This repo manages the overall project composed of 4 microservices tied to:
Frontend Service - React-based web UI
Product Service - REST API for product catalog
Order Service - REST API for order management
Database - PostgreSQL for data persistence

## General Development ##
Each service can be developed independently using its own docker-compose.yml
Testing: Main repo contains docker-compose with all services for integration testing
Production: Kubernetes manifests in main repo reference Docker Hub images
CI/CD: Each service builds/deploys independently, main repo orchestrates full deployments

## Local Development ##
Local Development: Use docker-compose networks for service discovery
Production: Use Kubernetes services and ingress
Configuration: Environment variables for service URLs (already implemented)

## Operation ##
Development: Each service has its own PostgreSQL in docker-compose for isolation
Integration: Main repo coordinates shared database
Production: Single PostgreSQL instance with proper schema management

