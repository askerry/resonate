#!/usr/bin/env bash

# refresh ubuntu packages
sudo apt-get -y update

# install Prerequisites
sudo apt-get install -y virtualenv
sudo apt-get install -y p7zip
sudo apt-get install -y ffmpeg

# Create a virtualenv pointing to your python3.5 installation
virtualenv --python=python3 --no-site-packages ~/.virtualenv/resonate

# Activate the virtualenv so that all dependencies are installed within it
source ~/.virtualenv/resonate/bin/activate

# run project setup scripting
source project_setup.sh
