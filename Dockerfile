
FROM python:3.5

WORKDIR /usr/src/app

# COPY Prefered to ADD, even though ADD has more capabilities
# https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/#add-or-copy
COPY . ./

RUN sudo apt-get update && sudo apt-get install -y \
    virtualenv \
    p7zip \
    ffmpeg \

CMD [ "source", "env_setup.sh" ]
