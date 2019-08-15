#!/usr/bin/env bash

# Test Docker has been configured locally
docker login

# Build CI Images Locally | -f Dockerfile
docker build -t robmellett/base:latest .
docker push robmellett/base:latest

# docker build -f Dockerfile.web --pull robmellett/lemp:7.2 .
