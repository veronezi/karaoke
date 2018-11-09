#!/bin/bash
set -e

cp .travis.settings.xml /tmp/.travis.settings.xml
sed -i 's/my_password/'"$BINTRAY_PASSWORD"'/g' /tmp/.travis.settings.xml

mvn --settings /tmp/.travis.settings.xml clean -q
mvn --settings /tmp/.travis.settings.xml -q versions:set -DnewVersion=$KARAOKE_VERSION-b$TRAVIS_BUILD_NUMBER
git diff

docker logout
echo "$DOCKER_PASSWORD" | docker login --username $DOCKER_USERNAME --password-stdin

if [ ! -d $HOME/google-cloud-sdk/bin ]; then
    rm -rf $HOME/google-cloud-sdk;
    curl https://sdk.cloud.google.com | bash
fi
source $HOME/google-cloud-sdk/path.bash.inc
gcloud --quiet version
gcloud --quiet components update
gcloud --quiet components update kubectl

echo $GCLOUD_SERVICE_KEY | base64 --decode -i > ${HOME}/gcloud-service-key.json
gcloud auth activate-service-account --key-file ${HOME}/gcloud-service-key.json
