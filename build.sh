#!/bin/bash

versions=('7.3' '7.2' '7.1' '7.0' '5.6')

for version in "${versions[@]}"; do

  oldstring="7.2" # What is currently in the file
  newstring=$version
  IMAGE_TAG=beyondlimits99/php

  echo ">>> Creating docker image for: $version"

  # Search and replace PHP Versions in all files
  grep -rli "$oldstring" * | xargs -i@ sed -i "s/$oldstring/$newstring/g" @

  echo "The image tag is $IMAGE_TAG"
  docker build --pull -t $IMAGE_TAG:$version .

  # Push to the Docker Repo
  docker push $IMAGE_TAG:$version

done
