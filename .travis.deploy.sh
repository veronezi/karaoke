#!/bin/bash
set -e

function deploy_docker_image () {
    if [ "$TRAVIS_BRANCH" = "master" ]; then
        echo "deploying docker image veronezi/$1:$2-b$3"
        docker tag $1 veronezi/$1:$2-b$3
        docker tag $1 veronezi/$1
        docker push veronezi/$1:$2-b$3
        docker push veronezi/$1
    else
        echo "deploying docker image veronezi/$1:$2-rc$3"
       docker tag $1 veronezi/$1:$2-rc$3
       docker push veronezi/$1:$2-rc$3
    fi
}

echo "event type -> $TRAVIS_EVENT_TYPE"
if [ "$TRAVIS_EVENT_TYPE" = "push" ]; then
    deploy_docker_image karaoke $KARAOKE_VERSION $TRAVIS_BUILD_NUMBER
    deploy_docker_image karaoke-proxy $KARAOKE_VERSION $TRAVIS_BUILD_NUMBER
    deploy_docker_image karaoke-renderer $KARAOKE_VERSION $TRAVIS_BUILD_NUMBER
    echo "binaries uploaded"
else
    echo "binaries NOT uploaded"
fi

