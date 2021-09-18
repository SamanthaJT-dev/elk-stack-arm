#!/bin/bash
# docker buildx build --platform linux/arm,linux/amd64 -t sralloza/elasticsearch-arm:latest --push .
docker buildx build --platform=linux/arm/v7 -t sralloza/elasticsearch-arm:latest --push .
