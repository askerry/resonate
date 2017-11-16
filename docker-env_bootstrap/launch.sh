#!/bin/sh

echo "------"
echo "hit launch.sh"
echo "LAUNCHING..."
echo "PATH: $PATH"
echo "VIRTUAL_ENV: $VIRTUAL_ENV"
echo "pip -V: " $(pip3 -V)
echo "python -V: " $(python -V)

jupyter notebook --ip=0.0.0.0 --port 9005 --allow-root
# top
