
FROM python:3.5

WORKDIR /usr/src/app

# COPY Prefered to ADD, even though ADD has more capabilities
# https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/#add-or-copy
# COPY checkpkg.sh ./
# COPY installs.sh ./
COPY . ./

RUN echo "DEBIAN VERSION: " && cat /etc/debian_version \
    && bash checkpkg.sh \
    && bash installs.sh

# CMD [ "source", "env_setup.sh" ]
