#!/bin/bash
set -e

function deploy_docker_image () {
    if [ "$TRAVIS_BRANCH" = "master" ]; then
        echo "deploying docker image veronezi/$1:$2-b$3"
        docker tag $1 veronezi/$1:$2-b$3
        docker push veronezi/$1:$2-b$3
    else
        echo "deploying docker image veronezi/$1:$2-rc$3"
       docker tag $1 veronezi/$1:$2-rc$3
       docker push veronezi/$1:$2-rc$3
    fi
}

deploy_docker_image karaoke $KARAOKE_VERSION $TRAVIS_BUILD_NUMBER
deploy_docker_image karaoke-war $KARAOKE_VERSION $TRAVIS_BUILD_NUMBER
deploy_docker_image karaoke-proxy $KARAOKE_VERSION $TRAVIS_BUILD_NUMBER
deploy_docker_image karaoke-renderer $KARAOKE_VERSION $TRAVIS_BUILD_NUMBER
deploy_docker_image karaoke-static $KARAOKE_VERSION $TRAVIS_BUILD_NUMBER
deploy_docker_image karaoke-static-install $KARAOKE_VERSION $TRAVIS_BUILD_NUMBER
deploy_docker_image karaoke-rendertron $KARAOKE_VERSION $TRAVIS_BUILD_NUMBER
deploy_docker_image karaoke-tomee $KARAOKE_VERSION $TRAVIS_BUILD_NUMBER

echo "binaries uploaded"