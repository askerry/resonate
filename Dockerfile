
#######
## WIP
#######
FROM python:3.5-alpine

# COPY . /var/app
# WORKDIR /var/app

RUN apk update \
  && apk add bash \
  && apk add curl \
  && apk add pkgconfig \
  && apk add build-base \
  && apk add freetype-dev \
  && apk add freetype \
  && apk add p7zip ffmpeg \
  && pip install virtualenv

# CMD [ "bash", "env_setup.sh" ]

#######
## WIP
#######
# FROM python:3.5-alpine
#
# COPY . /var/app
# WORKDIR /var/app
#
# RUN apk update \
#   && apk add bash \
#   && apk add curl \
#   && apk add pkgconfig \
#   && apk add p7zip ffmpeg \
#   && pip install virtualenv
#
# CMD [ "bash", "env_setup.sh" ]

# docker build -t resonate_img .
# docker run -it -p 9005:9005 --name resonate_container resonate_img
# docker run -it -p 9005:9005 --rm --name resonate_container resonate_img
# docker run -d -p 9005:9005 --rm --name resonate_container resonate_img


# docker run --name hello-world_container hello-world

# docker run -it --rm alpine:3.4
