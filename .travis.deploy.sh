#!/bin/bash
set -e

function deploy_java_bin () {
    mvn deploy:deploy-file -DpomFile=$1/pom.xml -Dfile=$1/target/$2-$3.$4 -Dpackaging=$4 -DrepositoryId=bintray-tveronezi-pretests -Durl=https://api.bintray.com/maven/tveronezi/pretests/$2/;publish=1
}

deploy_java_bin karaoke/api karaoke-api $KARAOKE_VERSION-b$TRAVIS_BUILD_NUMBER jar
deploy_java_bin karaoke/cache karaoke-cache $KARAOKE_VERSION-b$TRAVIS_BUILD_NUMBER jar
deploy_java_bin karaoke/functional karaoke-functional $KARAOKE_VERSION-b$TRAVIS_BUILD_NUMBER jar
deploy_java_bin karaoke/lyrics karaoke-lyrics $KARAOKE_VERSION-b$TRAVIS_BUILD_NUMBER jar
deploy_java_bin karaoke/musixmatch karaoke-musixmatch $KARAOKE_VERSION-b$TRAVIS_BUILD_NUMBER jar
deploy_java_bin karaoke/webapp karaoke-webapp $KARAOKE_VERSION-b$TRAVIS_BUILD_NUMBER war

function deploy_docker_image () {
    echo "[RUNNING] docker tag $1 veronezi/todo-auth:$2-b$3"
    docker tag $1 veronezi/$1:$2-b$3
    echo "[RUNNING] docker push veronezi/$1:$2-b$3"
    docker push veronezi/$1:$2-b$3
}

deploy_docker_image karaoke $KARAOKE_VERSION $TRAVIS_BUILD_NUMBER
deploy_docker_image karaoke-war $KARAOKE_VERSION $TRAVIS_BUILD_NUMBER
deploy_docker_image karaoke-proxy $KARAOKE_VERSION $TRAVIS_BUILD_NUMBER
deploy_docker_image karaoke-renderer $KARAOKE_VERSION $TRAVIS_BUILD_NUMBER
deploy_docker_image karaoke-static $KARAOKE_VERSION $TRAVIS_BUILD_NUMBER
deploy_docker_image karaoke-static-install $KARAOKE_VERSION $TRAVIS_BUILD_NUMBER
deploy_docker_image karaoke-rendertron $KARAOKE_VERSION $TRAVIS_BUILD_NUMBER
deploy_docker_image karaoke-tomee $KARAOKE_VERSION $TRAVIS_BUILD_NUMBER
