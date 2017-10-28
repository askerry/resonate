
ROOT=$(pwd)

if [ ! -d raw_data ]
then
    mkdir raw_data
fi
export AUDIO_DIR=$(pwd)/raw_data

cd raw_data
if [ ! -f fma_metadata.zip ]
then
    curl -O https://os.unil.cloud.switch.ch/fma/fma_metadata.zip
    7za x fma_metadata.zip
fi

if [ ! -f fma_small.zip ]
then
    curl -O https://os.unil.cloud.switch.ch/fma/fma_small.zip
    7za x fma_small.zip
fi

echo "Data downloaded to" $AUDIO_DIR
