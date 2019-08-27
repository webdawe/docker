#!/usr/bin/env bash

# Test Docker has been configured locally
docker login

# Build CI Images Locally | -f Dockerfile
# docker build -t robmellett/base:latest .
# docker push docker.io/robmellett/base:latest

# Build Node Image
docker build -f Dockerfile.node -t robmellett/node:latest .

# Build LEMP Image
# docker build -f Dockerfile.web -t robmellett/lemp:7.2 .
# docker push docker.io/robmellett/lemp:7.2 .

# Test Images Locally
# docker run robmellett/base
# docker container ls --latest
# docker exec -it <container_id> bash

# Clear all Images
# docker rmi $(docker images -q) --force