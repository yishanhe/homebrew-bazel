#!/bin/bash


ROOT_DIR="$(git rev-parse --show-toplevel)"


cat "${ROOT_DIR}/tools/versions" | xargs -I {} "${ROOT_DIR}/tools/formula_gen.sh" {}