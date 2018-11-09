#!/bin/bash
set -e

# Use this file to emulate travis from your local machine.
export MY_VERSION=0.0.99
export TRAVIS_BUILD_NUMBER=9999

export DOCKER_USERNAME="${DOCKER_USERNAME:-tveronezi}"
export DOCKER_PASSWORD="${DOCKER_PASSWORD:-aaaaaaaaa}"
export BINTRAY_PASSWORD="${BINTRAY_PASSWORD:-aaaaaaaaa}"
export GCLOUD_SERVICE_KEY="${GCLOUD_SERVICE_KEY:-aaaaaaaaa}"

export TRAVIS_BRANCH="master"

bash .travis.prepare.sh
bash .travis.build.sh
bash .travis.deploy.sh
bash .travis.cleanup.sh
