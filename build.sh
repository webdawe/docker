#!/bin/bash

#
# This script is run locally.  Not on Gitlab CI
#

versions=('7.3' '7.2' '7.1' '7.0' '5.6')

for version in "${versions[@]}"; do

  oldstring="7.2" # What is currently in the file
  newstring=$version
  IMAGE_TAG=beyondlimits99/php

  echo ">>> Creating docker image for: $version"

  sed -i.bak -e "s/$oldstring/$newstring/g" "Dockerfile"
  sed -i.bak -e "s/7.2/7.3/g" "Dockerfile"

  echo "The image tag is $IMAGE_TAG"
  docker build --pull -t $IMAGE_TAG:$version .

  # Push to the Docker Repo
  docker push $IMAGE_TAG:$version

done
