#!/usr/bin/env bash

# here=$PWD
# parentdir=$(dirname "$here")
#
# echo "Here: $here"
# echo "Build dir: $parentdir"

# *call from root dir*
docker build -t resonate_img .

# if calling from docker-env_bootstrap
# docker build -f $parentdir/Dockerfile -t resonate_img .
