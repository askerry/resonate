#!/bin/sh

echo "Setting up Resonate Project..."

# Add matplotlibrc to use appropriate backend
# export MATPLOTLIBRC=.matplotlib

# Install python requirements
pip install -r "$bootstrap_DIR/requirements.txt"

# workaround for odd pip install failure... (not finding tf 1.4.0)
# source "$bootstrap_DIR/tflow-install.sh"

# Make sure we have python 3 kernel for jupyter notebook
# ipython kernelspec install-self

# Download the raw data
# source "$bootstrap_DIR/download.sh"
