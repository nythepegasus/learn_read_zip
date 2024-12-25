#!/usr/bin/env bash

set -xe

# Ensure dependency is cloned
git submodule init
git submodule update

# Build dependency and copy required files
PROJECT=$(pwd)
pushd deps/zip
cmake .
make
cp src/*h $PROJECT/include/
cp libzip.a $PROJECT/libs/
popd

