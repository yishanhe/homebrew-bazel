#!/bin/bash

ROOT_DIR="$(git rev-parse --show-toplevel)"

BAZEL_VERSION=$1
BAZEL_COMPACT_VERSION=$(echo $BAZEL_VERSION | sed -e 's/\.//g')
echo $BAZEL_COMPACT_VERSION

BAZEL_INSTALLER_URL="https://releases.bazel.build/$BAZEL_VERSION/release/bazel-$BAZEL_VERSION-installer-darwin-x86_64.sh"
TMP_FOLDER="/tmp/homebrew_bazel_tmp"
TMP_INSTALLER_FILE="$TMP_FOLDER/bazel-$BAZEL_VERSION-installer-darwin-x86_64.sh"

mkdir -p $TMP_FOLDER

if [[ -x "$(command -v wget)" ]]; then
    wget -q ${BAZEL_INSTALLER_URL} --output-document ${TMP_INSTALLER_FILE}
elif [[ -x "$(command -v curl)" ]]; then
    curl -s ${BAZEL_INSTALLER_URL} --output ${TMP_INSTALLER_FILE}
else
    echo "Please install wget or curl."
    exit 1
fi

if [[ -x "$(command -v openssl)" ]]; then
    SHA256=$(openssl dgst -sha256 < $TMP_INSTALLER_FILE)
    echo $SHA256
elif [[ -x "$(command -v shasum)" ]]; then
    SHA256=$(shasum -a 256 $TMP_INSTALLER_FILE | cut -d' ' -f1)
    echo $SHA256
else
    echo "No shasum and openssl installed."
    exit 1
fi

# echo $SHA256


sed -e 's/REPLACE_ME_WITH_BAZEL_COMPACTVERSION/'"${BAZEL_COMPACT_VERSION}"'/g' \
    -e 's/REPLACE_ME_WITH_BAZEL_VERSION/'"${BAZEL_VERSION}"'/g' \
    -e 's/REPLACE_ME_WITH_SHA256/'"${SHA256}"'/g' \
    "$ROOT_DIR/tools/bazel_formula_template.rb" | tee "$ROOT_DIR/Formula/bazel@$BAZEL_VERSION.rb"

