echo "Setting up dev environment for resonate..."

# Add matplotlibrc to use appropriate backend
export MATPLOTLIBRC=.matplotlib

# Install python requirements
pip install -r requirements.txt

# Download the raw data
bash download.sh

