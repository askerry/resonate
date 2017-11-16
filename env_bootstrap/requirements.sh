#!/bin/sh

echo "__________"
echo "hit requirements.sh"
echo "Installing Packages..."
echo "PATH: $PATH"
echo "VIRTUAL_ENV: $VIRTUAL_ENV"
echo "python -V: " $(python -V)
echo "pip -V: " $(pip3 -V)

pip install --no-cache-dir ipython
pip install --no-cache-dir jupyter
pip install --no-cache-dir librosa
pip install --no-cache-dir matplotlib
pip install --no-cache-dir numpy
pip install --no-cache-dir pandas
pip install --no-cache-dir scikit-learn
pip install --no-cache-dir scipy
pip install --no-cache-dir seaborn
pip install --no-cache-dir tensorflow
    # "Could not find a version that satisfies the requirement tensorflow"
    # "No matching distribution found for tensorflow"

# Included for fma_util.py
pip install --no-cache-dir pydot
pip install --no-cache-dir requests
