#!/usr/bin/env bash

if [[ $(apt-cache search ffmpeg) ]]; then
    echo "ffmpeg package found"
else
    echo "ffmpeg package was NOT found"
    add-apt-repository ppa:jonathonf/ffmpeg-3
    sudo apt-get update
fi
