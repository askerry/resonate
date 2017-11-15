#!/usr/bin/env bash

# docker run --rm --name resonate_container3 -it -p 9005:9005 -v $(PWD):/var/app -w /var/app resonate_img /bin/sh env_bootstrap/test-script.sh

# docker run --rm --name resonate_container -d -p 9005:9005 -v $(PWD):/var/app -w /var/app resonate_img /bin/sh env_bootstrap/test-script.sh

docker run --rm --name resonate_container -it -p 9005:9005 -v $(PWD):/var/app -w /var/app resonate_img /bin/sh env_bootstrap/env_setup.sh

# NO QUOTES around command
# -w; explicitly set, full path on GUEST. NOT the host path or 'PWD'
