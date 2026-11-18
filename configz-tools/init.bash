#! /usr/bin/env bash

# Locate the source folder
CONFIGZ_TOOLS_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)

# Source files
. "$CONFIGZ_TOOLS_DIR/dependency.bash"
. "$CONFIGZ_TOOLS_DIR/file.bash"
