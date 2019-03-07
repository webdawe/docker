#!/usr/bin/env bash

versions=('php7.3' 'php7.2' 'php7.1' 'php7.0' 'php5.6')

for version in "${versions[@]}"; do

  oldstring="php7.2" # What is currently in the file
  newstring=$version

  echo ">>> Creating docker image for: $version"

  sed 's/$oldstring/$newstring/g' 'docker-compose.yaml'

  echo ""

done
