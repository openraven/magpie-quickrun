#!/bin/sh
docker pull quay.io/openraven/magpie-cspm:latest
docker-compose down
docker-compose build
docker-compose up --exit-code-from magpie