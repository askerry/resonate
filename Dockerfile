
FROM python:3.5

WORKDIR /usr/src/app

COPY . ./

RUN export DEBIAN_FRONTEND=noninteractive \
    && echo "DEBIAN VERSION: " && cat /etc/debian_version \
    && bash checkpkg.sh \
    && bash installs.sh

CMD [ "source", "env_setup.sh" ]
