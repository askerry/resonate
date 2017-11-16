#!/usr/bin/env bash

echo "Setting up Resonate..."

# Add matplotlibrc to use appropriate backend
export MATPLOTLIBRC=.matplotlib

# Install python requirements
pip install -r requirements.txt

# Make sure we have python 3 kernel for jupyter notebook
ipython3 kernelspec install-self

# Download the raw data
bash download.sh
