#!/usr/bin/env bash

echo "Setting up Resonate..."

# Add matplotlibrc to use appropriate backend
export MATPLOTLIBRC=.matplotlib

# Install python requirements
pip install -r requirements.txt

# Download the raw data
bash download.sh
