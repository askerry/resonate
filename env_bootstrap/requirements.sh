#!/bin/sh

echo "__________"
echo "hit requirements.sh"
echo "Installing Packages..."
echo "PATH: $PATH"
echo "VIRTUAL_ENV: $VIRTUAL_ENV"
echo "python -V: " $(python -V)
echo "pip -V: " $(pip3 -V)

pip install ipython
pip install jupyter
pip install librosa
pip install matplotlib
pip install numpy
pip install pandas
pip install scikit-learn
pip install scipy
pip install seaborn
pip install tensorflow
    # "Could not find a version that satisfies the requirement tensorflow"
    # "No matching distribution found for tensorflow"

# Included for fma_util.py
pip install pydot
pip install requests
