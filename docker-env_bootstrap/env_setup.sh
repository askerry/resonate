#!/bin/sh

# echo "pwd: " $PWD
export bootstrap_DIR="$PWD/docker-env_bootstrap"
# echo "dir: " $bootstrap_DIR

# echo "PATH: $PATH"

echo "____________"
echo "Setting up Resonate Environment..."

# Create a virtualenv pointing to your python3.5 installation
virtualenv --python=python3 --no-site-packages ~/.virtualenv/resonate
echo "pip -V: " $(pip3 -V)
echo "python -V: " $(python -V)

# Activate the virtualenv so that all dependencies are installed within it
source ~/.virtualenv/resonate/bin/activate
echo "pip -V: " $(pip3 -V)
echo "python -V: " $(python -V)
echo "VIRTUAL_ENV: $VIRTUAL_ENV"

# run project setup scripting
source "$bootstrap_DIR/project_setup.sh"
