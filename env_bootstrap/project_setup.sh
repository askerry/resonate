#!/bin/sh

echo "hit project-setup.sh"
echo "Setting up Resonate Project..."
echo "PATH: $PATH"
echo "VIRTUAL_ENV: $VIRTUAL_ENV"
echo "pip -V: " $(pip3 -V)
echo "python -V: " $(python -V)

# Add matplotlibrc to use appropriate backend
export MATPLOTLIBRC=.matplotlib

# Install python requirements
# pip install -r "$bootstrap_DIR/requirements.txt"
source "$bootstrap_DIR/requirements.sh"

# workaround for odd pip install failure... (not finding tf 1.4.0)
source "$bootstrap_DIR/tflow-install.sh"

# Download the raw data
source "$bootstrap_DIR/download.sh"
