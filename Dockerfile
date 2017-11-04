
FROM python:3.5

WORKDIR /usr/src/app

COPY requirements.txt ./
COPY download.sh ./
COPY project_setup.sh ./
COPY env_setup.sh ./

RUN sudo apt-get update && sudo apt-get install -y \
    virtualenv \
    p7zip \
    ffmpeg \
&& pip install --no-cache-dir -r requirements.txt

CMD [ "source", "env_setup.sh" ]
