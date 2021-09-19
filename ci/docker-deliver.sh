#!/bin/bash

set -e
BASE_DIR="$(dirname $0)"
REPO_PATH="${BASE_DIR}/.."
ARCH="${1}"
IMAGE="${2}"
VERSION="${3}"
INTERNAL_VERSION="${4}"

[[ $ARCH ]] || ARCH="x86"

tag_and_push() {
  docker tag "sralloza/${2}:latest" "sralloza/${2}:${1}"
  docker push "sralloza/${2}:${1}"
}

cd "${REPO_PATH}" && git pull origin master || :

COMPOSE_DOCKER_CLI_BUILD=1 DOCKER_BUILDKIT=1 docker-compose build "${IMAGE}"

tag_and_push "latest-${ARCH}" "${IMAGE}"
tag_and_push "${VERSION}-${ARCH}" "${IMAGE}"
