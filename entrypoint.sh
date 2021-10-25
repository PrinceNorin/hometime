#!/bin/bash

set -e

# waiting for postgresql to be ready
until echo 0 > /dev/tcp/postgres/5432; do
  echo 'waiting for postgres';
  sleep 1;
done;

bundle check || bundle install
bundle exec rails s -b 0.0.0.0
