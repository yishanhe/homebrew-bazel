#!/bin/bash


BAZEL_RELEASE_RSS="https://github.com/bazelbuild/bazel/releases.atom"
TAG_URL_PREFIX="https://github.com/bazelbuild/bazel/releases/tag/"


# get the current path of the script
canonical=$(cd -P -- "$(dirname -- "$0")" && printf '%s\n' "$(pwd -P)/$(basename -- "$0")")
ROOT_PATH="$(dirname $(dirname "$canonical"))"

cd $ROOT_PATH && \
    curl -s "${BAZEL_RELEASE_RSS}" | grep -o  "${TAG_URL_PREFIX}[0-9\.]*" | sed -n 's/https\:\/\/github\.com\/bazelbuild\/bazel\/releases\/tag\/\([0-9\.]*\)/\1/p' > "${ROOT_PATH}/tools/versions" && \
    /bin/bash "${ROOT_PATH}/tools/build.sh" && \
    git add "${ROOT_PATH}/Formula" && \
    git commit -m "auto update $(cat tools/versions | xargs)"
    git push
