#!/bin/bash

versions=('7.3' '7.2' '7.1' '7.0' '5.6')

currentversion="7.2" # What is currently in the Dockerfile

for version in "${versions[@]}"; do

  IMAGE_TAG=beyondlimits99/php

  echo ">>> Creating docker image for: $version"

  # Search and replace PHP Versions in all files
  grep -rli "$currentversion" * | xargs -i@ sed -i "s/$currentversion/$version/g" @

  echo "The image tag is $IMAGE_TAG"
  docker build --pull -t $IMAGE_TAG:$version .

  # Push to the Docker Repo
  docker push $IMAGE_TAG:$version

  # Switch to next version
  currentversion=$version

done
