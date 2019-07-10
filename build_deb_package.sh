#!/bin/bash

if [ -z "$MAJOR" ] ; then
    echo 'Please provide a major version number'
    exit
fi

if [ -z "$MINOR" ] ; then
    echo 'Please provide a minor version number'
    exit
fi

if [ -z "$REVISION" ] ; then
    echo 'Please provide a revision version number'
    exit
fi

if [ -z "$EMAIL" ] ; then
    echo 'Please provide an Email'
    exit
fi

if [ -z "$1" ] ; then
    echo 'Please provide a path to the source as first argument'
    exit
fi


mkdir -p build

complete_name=reversed-companion_$MAJOR.$MINOR-$REVISION
root_folder=build/$complete_name

cp -r reversed-companion $root_folder

cp -r $1/backend/app $root_folder/usr/local/reversed/backend/app
cp $1/backend/requirements.txt $root_folder/usr/local/reversed/backend/requirements.txt

cp -r $1/serial-reader/app $root_folder/usr/local/reversed/serial-reader/app
cp $1/serial-reader/requirements.txt $root_folder/usr/local/reversed/serial-reader/requirements.txt

cp -r $1/frontend/build $root_folder/var/www/html

dpkg-deb --build $root_folder

cp $root_folder.deb $complete_name.deb

# Packages & Packages.gz
dpkg-scanpackages --multiversion . > Packages
gzip -k -f Packages

# Release, Release.gpg & InRelease
apt-ftparchive release . > Release
gpg --default-key "${EMAIL}" -abs -o - Release > Release.gpg
gpg --default-key "${EMAIL}" --clearsign -o - Release > InRelease

# Commit & push
git add -A
git commit -m "Upload $complete_name"

echo 'now push'
