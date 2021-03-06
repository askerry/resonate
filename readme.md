# Resonate: Audio-based music analysis

Data and initial analysis strategies obtained from [FMA: A Dataset For Music Analysis](https://github.com/mdeff/fma)

## OSX Setup

### Prerequisites

* [Homebrew](https://brew.sh/)
* python3.5 (`brew install python3`)
* p7zip (`brew install p7zip`)
* ffmpeg (`brew install ffmpeg`)
* virtualenv (`brew install pyenv-virtualenv`)

### Create a virtualenv for the project
Create a virtualenv pointing to your python3.5 installation
`virtualenv --python=python3 --no-site-packages ~/.virtualenv/resonate`

Activate the virtualenv so that all dependencies are installed within it
`source ~/.virtualenv/resonate/bin/activate`

### Run initial setup script
`source osx_setup/setup.sh`


## Docker Setup

### Prerequisites
* Docker

### Docker Build
`./docker-env_bootstrap/docker-build.sh`

### Docker Run
`./docker-env_bootstrap/docker-run.sh`
