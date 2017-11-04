
FROM python:3.5

WORKDIR /usr/src/app

COPY requirements.txt ./
COPY download.sh ./
COPY project_setup.sh ./
COPY env_setup.sh ./

RUN pip install --no-cache-dir -r requirements.txt


CMD [ "source", "env_setup.sh" ]
