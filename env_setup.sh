#!/usr/bin/env bash

echo "Setting up Resonate Environment..."

# Create a virtualenv pointing to your python3.5 installation
virtualenv --python=python3 --no-site-packages ~/.virtualenv/resonate

# Activate the virtualenv so that all dependencies are installed within it
source ~/.virtualenv/resonate/bin/activate

# run project setup scripting
source project_setup.sh
