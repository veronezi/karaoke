#!/bin/bash
set -e

cp .travis.settings.xml $HOME/.m2/settings.xml
sed -i 's/my_password/'"$BINTRAY_PASSWORD"'/g' $HOME/.m2/settings.xml

mvn clean -q
mvn -q versions:set -DnewVersion=$KARAOKE_VERSION-b$TRAVIS_BUILD_NUMBER
git diff

docker logout
echo "$DOCKER_PASSWORD" | docker login --username $DOCKER_USERNAME --password-stdin
