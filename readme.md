# Resonate: Audio-based music analysis

Data and initial analysis strategies obtained from [FMA: A Dataset For Music Analysis](https://github.com/mdeff/fma)

## Prerequisites

* [Homebrew](https://brew.sh/)
* python3.5 (`brew install python3`)
* p7zip (`brew install p7zip`)
* virtualenv (`pip install virtualenv`)

## Create a virtualenv for the project

Create a virtualenv pointing to your python3.5 installation

`virtualenv --python=/usr/local/Cellar/python3/3.5.0/bin/python3.5 --no-site-packages ~/.virtualenv/resonate`

Activate the virtualenv so that all dependencies are installed within it

`source ~/.virtualenv/resonate/bin/activate`

## Run initial setup script
`source setup.sh`


