#!/bin/sh
docker-compose down
docker pull quay.io/openraven/magpie-cspm:latest
docker pull quay.io/openraven/dmap-predictions:latest
docker-compose build
docker-compose up --exit-code-from magpie