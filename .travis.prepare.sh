#!/bin/bash
set -e

cp .travis.settings.xml /tmp/.travis.settings.xml
sed -i 's/my_password/'"$BINTRAY_PASSWORD"'/g' /tmp/.travis.settings.xml

mvn --settings /tmp/.travis.settings.xml clean -q
mvn --settings /tmp/.travis.settings.xml -q versions:set -DnewVersion=$KARAOKE_VERSION-b$TRAVIS_BUILD_NUMBER
git diff

docker logout
echo "$DOCKER_PASSWORD" | docker login --username $DOCKER_USERNAME --password-stdin
echo $GCLOUD_SERVICE_KEY | base64 --decode -i > $HOME/.gcloud/gcloud-service-key.json

docker volume create gcloud_conf

# log in
docker run --rm -ti \
    -v gcloud_conf:/home/jdoe/.config \
    -v $HOME/.gcloud/:/home/jdoe/data \
    veronezi/gcloud:0.0.1-b3 \
    auth activate-service-account --key-file /home/jdoe/data/gcloud-service-key.json
# info
docker run --rm -ti \
    -v gcloud_conf:/home/jdoe/.config \
    veronezi/gcloud:0.0.1-b3 \
    auth list
