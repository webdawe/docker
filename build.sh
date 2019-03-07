#!/usr/bin/env bash

versions=('php7.3' 'php7.2' 'php7.1' 'php7.0' 'php5.6')

for version in "${versions[@]}"; do

  oldstring="php7.2"
  newstring=$version

  echo ">>> Creating docker image for: $version"

  find . -type f \( ! -path '*/.git/*' -and ! -path 'build.sh' \) \
    -exec sed -i 's/$oldstring/$newstring/g' {} \;

  exit

  echo "\n"

done
