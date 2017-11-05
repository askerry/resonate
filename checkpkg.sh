#!/usr/bin/env bash

echo "apt-get -qq update..."
apt-get -qq update

if [[ $(apt-cache search --names-only ^ffmpeg$) ]]; then
    echo "ffmpeg package found"
else
    echo "ffmpeg package was NOT found"
    echo "install pkg add capability..."
    apt-get -qq install -y apt-utils > /dev/null
    apt-get -qq install -y software-properties-common > /dev/null
    echo "add ffmpeg ppa..."
    apt-add-repository ppa:jonathonf/ffmpeg-3”
    echo "apt-get -qq update..."
    apt-get -qq update
fi
