#!/bin/bash
# Get an updated config.sub and config.guess
cp $BUILD_PREFIX/share/gnuconfig/config.* .

set -ex

mkdir -pv _build
pushd _build

EXTRA_FLAGS=""
if [[ $(arch) == "aarch64" ]]; then
	EXTRA_FLAGS="--build=aarch64-unknown-linux-gnu --host=aarch64-unknown-linux-gnu"
fi

# configure
${SRC_DIR}/configure \
	--prefix=${PREFIX} \
	$EXTRA_FLAGS \
;

# build
make -j ${CPU_COUNT}

# test
make -j ${CPU_COUNT} check

# install
make -j ${CPU_COUNT} install
