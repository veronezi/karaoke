#!/bin/bash
set -e

echo "running the maven tests"
mvn --settings /tmp/.travis.settings.xml test -Ddocker.skip=true
