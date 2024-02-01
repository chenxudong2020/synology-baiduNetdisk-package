#!/bin/bash

pkg_version=$(cat VERSION)
cp INFO .INFO
echo -e "\nversion=\"${pkg_version}\"" >> INFO
cd ./package
tar cvfz package.tgz --owner=0 --group=0 *
mv package.tgz ../
cd ../
rm -rf build/
mkdir -p build/
tar -cvf "build/chislash-${pkg_version}.spk" --owner=0 --group=0 scripts/* INFO PACKAGE_ICON.PNG PACKAGE_ICON_256.PNG package.tgz conf/ WIZARD_UIFILES/
rm -f package.tgz
mv .INFO INFO
