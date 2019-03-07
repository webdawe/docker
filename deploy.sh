#!/bin/bash bash

versions=('php7.3' 'php7.2' 'php7.1' 'php7.0' 'php5.6')

for i in `${versions[@]}`; do
  echo $i
done
