#!/bin/bash

set -ue

readonly VERSION="0.5.0"
readonly ARCHIVE="${VERSION}.tar.gz"
readonly DIR="elvis-${VERSION}"
readonly URL="https://github.com/inaka/elvis/archive/${ARCHIVE}"
readonly INSTALL_PATH="/usr/bin"

echo "--- Installing Elvis"

echo "Downloading Elvis ${VERSION} from ${URL}"
curl -sSLO $URL

echo "Extracting ${ARCHIVE}"
tar xfz $ARCHIVE
cd ${DIR}

echo "Compiling Elvis"
rebar3 compile

echo "Building Elvis escript"
rebar3 escriptize

echo "Install escript"
cp _build/default/bin/elvis ${INSTALL_PATH}
