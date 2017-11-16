#!/usr/bin/env bash

# here=$PWD
# parentdir=$(dirname "$here")
# echo "mounted volume: $parentdir"

# if calling from docker-env_bootstrap
# docker run --rm --name resonate_container -it -p 9005:9005 -v $parentdir:/var/app -w /var/app resonate_img /bin/sh env_setup.sh

echo $(pwd)
docker run --rm --name resonate_container -it -p 9005:9005 -v $(pwd):/var/app -w /var/app resonate_img /bin/sh docker-env_bootstrap/env_setup.sh

# NO QUOTES around command
# -w; explicitly set, full path on GUEST. NOT the host path or 'PWD'
