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

## Git Flow Model ##
Branch Logic
Below is an overview of the 5 branches associated with each of the 5 repositories of this project. Each workflow adheres to the logic laid out in the below:
Main branch: used for Production code. The code that has undergone all relevant tests (e.g. security, E2E, Jenkins pipelines) should be deployed here. The code will be merged into main from either RELEASE OR DEVELOP (which one?) branches (new features) or hotfix branches (for bug fixes).
Hotfix branch: used as a branch to patch bugs into the main branch without having to use other branches. The necessary changes can be then be pushed to GitHub to expedite the solving of Prod issues across the application.
Release branch: used to prepare for a new prod release to the main branch. Testing for issues, efficiency, and bugs, in addition to other components are conducted here. Before merging to main, new documentation should also be added. This branch will also not influence ongoing feature development across the develop and features branches.
Develop branch: used as the branch for the next release where all new feature branches are merged into develop. 
Feature branches: used for independent features where regular commits do not influence the develop branch. When a feature is done it is merged into the develop branch.
The structure below has been highlighted by external parties (link) as a strong method for Gitflow and version control. This was the methodology behind the project. 
