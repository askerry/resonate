import os

import numpy as np
import tensorflow as tf

from util import fma_util

# Standard filenames for metadata CSVs in the FMA dataset.
TRACKS_FILENAME = 'tracks.csv'
FEATURES_FILENAME = 'features.csv'
ECHONEST_FILENAME = 'echonest.csv'
GENRES_FILENAME = 'genres.csv'


def read(fma_data_path, split_name='training', subset_size='small'):
    """Reads the FMA dataset and returns an appropriate tf.data.Dataset.

    The structure of the returned dataset is:

    - features: A dictionary of feature tensors containing:
      - 'mfcc': A tf.float32 tensor of "MFCC" features.

    - labels: A dictionary of label tensors containing:
      - 'track_id': A tf.int32 tensor of the track's ID.
      - 'genre_top': A tf.string tensor indicating the "top" genre of the track.
          See the "all_genres" return value of this function to get the full
          list of all genres.

    Usage:
    ```
    dataset = fma.read('/path/to/fma', 'training', 'small')
    dataset = dataset.repeat(num_epochs).batch(32)

    features, labels = dataset.make_one_shot_iterator().get_next()

    # MFCC features, shaped [batch_size, 108] with type tf.float32.
    mfcc = features['mfcc']

    # Genre labels as strings. Shaped [batch_size] with type tf.string.
    genre_top_strings = labels['genre_top']
    ```

    Args:
      fma_data_path: Path to a folder containing an 'fma_metadata' folder of
        FMA metadata CSVs and 'fma_<subset_size>' folder of audio.
      split_name: The data split to return. Must be 'training' or 'eval'.
      subset_size: The subset of the data to use. Must be 'small', 'medium' or
        'large'.

    Returns:
      dataset: A tf.data.Dataset representing the requested data.
      all_genres: A list of Python strings indicating all the available genres.

    Raises:
      ValueError: If split_name or subset_size are invalid.
    """
    if split_name not in ('training', 'eval'):
        raise ValueError('split_name must be "training" or "eval". Got: %s' %
                         split_name)
    if subset_size not in ('small', 'medium', 'large'):
        raise ValueError('subset_size must be either "small", '
                         '"medium", or "large". Got: %s' % subset_size)

    # Read each of the metadata files as a dataframe.
    fma_metadata_path = os.path.join(fma_data_path, 'fma_metadata')
    fma_audio_path = os.path.join(fma_data_path, 'fma_' + subset_size)
    tracks_df, genres_df, features_df, echonest_df = [
        fma_util.load(os.path.join(fma_metadata_path, filename))
        for filename in (TRACKS_FILENAME, GENRES_FILENAME, FEATURES_FILENAME,
                         ECHONEST_FILENAME)]

    # Verify that the indices for tracks and features are identical.
    assert np.all(tracks_df.index == features_df.index)

    # Restrict the track-oriented dataframes to the selected subset and split.
    subset_filter = tracks_df['set', 'subset'] == subset_size
    split_filter = tracks_df['set', 'split'] == split_name
    tracks_df = tracks_df.loc[subset_filter & split_filter]
    features_df = features_df.loc[subset_filter & split_filter]
    echonest_df = echonest_df.loc[subset_filter & split_filter]

    # TODO(rryan): This is kind of hard-coding the task into the data
    # loading. Doing this now for convenience but we'll want to revisit.
    # WARNING: echonest_df requires a join to include here, while features_df
    # and tracks_df have identical index columns.
    features = {
        'mfcc': features_df['mfcc'],
    }
    labels = {
        'track_id': tracks_df.index.tolist(),
        'genre_top': tracks_df['track', 'genre_top'].as_matrix()
    }

    all_genres = genres_df['title'].tolist()
    return tf.data.Dataset.from_tensor_slices((features, labels)), all_genres
