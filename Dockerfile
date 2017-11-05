
FROM python:3.5

# WORKDIR /usr/src/app

# COPY Prefered to ADD, even though ADD has more capabilities
# https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/#add-or-copy
# COPY . ./

RUN cat /etc/debian_version \

&& if [[ $(sudo apt-cache search ffmpeg) ]]; then \
    echo "ffmpeg package found" \
else \
    echo "ffmpeg package was NOT found" \
fi \
&& apt-get update && apt-get install -y \
    virtualenv \
    p7zip
    # ffmpeg

# CMD [ "source", "env_setup.sh" ]
