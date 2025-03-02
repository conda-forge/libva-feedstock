#!/bin/bash
set -e -x

mkdir -pm755 build
pushd build

export XDG_DATA_DIRS="${XDG_DATA_DIRS:+${XDG_DATA_DIRS}:}:${PREFIX}/share:${BUILD_PREFIX}/share"
export PKG_CONFIG_PATH="${PKG_CONFIG_PATH:+${PKG_CONFIG_PATH}:}${PREFIX}/lib/pkgconfig:${BUILD_PREFIX}/lib/pkgconfig"

export PKG_CONFIG="$(which pkg-config)"

if [[ "${target_platform}" == linux-* ]]; then
    # Set correct multiarch for Linux
    MULTIARCH="$(gcc -print-multiarch | sed -e 's/i.*86/i386/')"
    sed -i "s/@MULTIARCH_PLACEHOLDER@/${MULTIARCH}/g" meson.build
fi

meson setup ${MESON_ARGS} ..

ninja
ninja install

popd
