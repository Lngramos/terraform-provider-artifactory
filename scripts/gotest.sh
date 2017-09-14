#!/usr/bin/env bash -e

export ARTIFACTORY_USERNAME=admin
export ARTIFACTORY_PASSWORD=password
export ARTIFACTORY_URL=http://localhost:8080/

ROOT_DIR=$(pwd)/
COVERAGE_PATH=${ROOT_DIR}/coverage.txt

echo "" > ${COVERAGE_PATH}

for d in $(go list ./... | grep -v vendor | grep -v gocd-response-links); do
    go test -v -race -coverprofile=profile.out -covermode=atomic $d
    r=$?
    if [ $r -ne 0 ]; then
        exit $r
    elif [ -f profile.out ]; then
        cat profile.out >> ${COVERAGE_PATH}
        rm profile.out
    fi
done