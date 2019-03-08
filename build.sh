#!/bin/bash

#
# This script is run locally.  Not on Gitlab CI
#

versions=('php7.3' 'php7.2' 'php7.1' 'php7.0' 'php5.6')

for version in "${versions[@]}"; do

  oldstring="php7.2" # What is currently in the file
  newstring=$version
  IMAGE_TAG=beyondlimits99

  echo ">>> Creating docker image for: $version"

  sed "s/$oldstring/$newstring/g" "Dockerfile"

  echo "The image tag is $IMAGE_TAG"
  docker build --pull -t $IMAGE_TAG:$version .
  docker push $IMAGE_TAG:$version

done
