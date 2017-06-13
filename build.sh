#!/bin/bash -ex

git submodule update

mkdir -p dist

cd lv
for file in $(cat debian/patches/series); do
  patch -p1 < debian/patches/$file
done
cd src
./configure
make all
cp lv ../../dist
cd ..
git clean -f
git checkout -- .
cd ..
./dist/lv -V

cd dist
tar zcvf lv.tar.gz lv
