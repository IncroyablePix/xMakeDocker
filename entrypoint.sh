#!/bin/sh

## define variable PLATFORM if BUILD_PLATFORM environment variable is defined or default to Linux
PLATFORM=${BUILD_PLATFORM:-Linux}
ARCH=${BUILD_ARCH:-x86_64}

prepare_xmake() {
    export XMAKE_ROOT=y
    export XMAKE_GLOBALDIR=/var/xmake/global
    export XMAKE_PKG_INSTALLDIR=/var/xmake/packages
    export XMAKE_PROGRAM_DIR=/var/xmake/program
}

set_toolchain () {
    if [ "$1" = "WIN" ]; then
        if [ "$2" = "x86_64" ]; then
            xmake f -p mingw -a x86_64
        elif [ "$2" = "x86" ]; then
            xmake f -p mingw -a i386
        else
            echo "Unsupported architecture $2"
            exit 1
        fi
    elif [ "$1" = "LINUX" ]; then
        if [ "$2" = "x86" ]; then
            xmake f -p linux -a i386
        elif [ "$2" = "x86_64" ]; then
            xmake f -p linux -a x86_64
        elif [ "$2" = "arm" ]; then
            xmake f -p linux -a armv7
        elif [ "$2" = "arm64" ]; then
            xmake f -p linux -a arm64-v8a
        else
            echo "Unsupported architecture $2"
            exit 1
        fi
    else 
        echo "Unsupported platform $1"
        exit 1
    fi
}

# Prepare the build environment
cd /var/src
prepare_xmake
set_toolchain $PLATFORM $ARCH

# Build the project
xmake -w --root
