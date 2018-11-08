#!/bin/bash

mkdir build && cd build

export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$PREFIX/lib/pkgconfig
export LDFLAGS="$LDFLAGS -fuse-ld=gold"

cmake -G "Ninja" \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=$PREFIX \
  -DCMAKE_PREFIX_PATH=$PREFIX \
  -DBUILD_PLUGIN_GREYHOUND=ON \
  -DBUILD_PLUGIN_PCL=ON \
  -DBUILD_PLUGIN_PYTHON=ON \
  -DBUILD_PLUGIN_PGPOINTCLOUD=ON \
  -DBUILD_PLUGIN_SQLITE=ON \
  -DBUILD_PLUGIN_ICEBRIDGE=ON \
  -DBUILD_PLUGIN_HEXBIN=ON \
  -DBUILD_PLUGIN_NITF=ON \
  -DENABLE_CTEST=OFF \
  -DWITH_TESTS=OFF \
  -DWITH_ZLIB=ON \
  -DWITH_LASZIP=ON \
  -DWITH_VTK:BOOL=ON \
  ..

ninja install

# This will not be needed once we fix upstream.
chmod 755 $PREFIX/bin/pdal-config

ACTIVATE_DIR=$PREFIX/etc/conda/activate.d
DEACTIVATE_DIR=$PREFIX/etc/conda/deactivate.d
mkdir -p $ACTIVATE_DIR
mkdir -p $DEACTIVATE_DIR

cp $RECIPE_DIR/scripts/activate.sh $ACTIVATE_DIR/pdal-activate.sh
cp $RECIPE_DIR/scripts/deactivate.sh $DEACTIVATE_DIR/pdal-deactivate.sh
