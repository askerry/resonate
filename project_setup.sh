#!/usr/bin/env bash

echo "Setting up Resonate Project..."

# Add matplotlibrc to use appropriate backend
export MATPLOTLIBRC=.matplotlib

# Make sure we have python 3 kernel for jupyter notebook
ipython3 kernelspec install-self

# Download the raw data
source download.sh
