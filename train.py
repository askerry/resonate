#!/usr/bin/env python3
"""Script for training a TensorFlow model on audio datasets.

Usage:
    python train.py --dataset=fma
"""

import argparse
import logging

import tensorflow as tf

from datasets import fma

logging.getLogger().setLevel(logging.INFO)
DEFAULT_MINI_BATCH_SIZE = 32
DEFAULT_LEARNING_RATE = .5


def load_data(dataset, split, dataset_size, batch_size, num_epochs):
    """Load data into trainable iterator."""
    logging.info("Loading dataset %s" % dataset)
    # TODO(amy): Build support for cross validation rather than
    # relying on static train/test split.
    if dataset == 'fma':
        path_to_data = 'raw_data'
        dataset, all_labels = fma.read(path_to_data, split, dataset_size)

        batched_dataset = (
            dataset
            # Shuffle with shuffle buffer 10x the batch size.
            .shuffle(batch_size * 10)
            # Repeat for num_epochs.
            .repeat(num_epochs)
            # Collect examples into mini-batches of batch_size.
            .batch(batch_size))

        # Create iterator that will make one pass through the dataset.
        iterator = batched_dataset.make_one_shot_iterator()

        # Returns features and labels dictionaries containing tensors from
        # this mini-batch. See fma.read for details on the tensors in
        # these dictionaries.
        x, y = iterator.get_next()

        # Extract mfcc features and genre as labels.
        features = x['mfcc']
        labels = y['genre_top']
    else:
        raise ValueError('Unknown dataset %s' % dataset)
    return features, labels, all_labels


# TODO(amy): Figure out how we want to handle flexibly specifying the
# network structure.
def predict(features, num_labels):
    """Construct actual network to predict labels from features.

    Args:
        features: A [batch_size, input_feature_dimension] tf.float32
            tensor of features to predict from.
        num_labels: A Python integer indicating the total number of labels.

    Returns:
        A [batch_size, num_labels] tf.float32 of unnormalized predictions.
    """
    # Create a single layer network returning the unnormalized probability
    # of each class.
    logits = tf.contrib.layers.fully_connected(
        features, num_labels, activation_fn=tf.nn.relu)
    return logits


def specify_model(
        features, labels, all_labels, learning_rate, num_oov_buckets=1):
    """Specify the loss and structure of the model.

    Args:
        features: A [batch_size, input_feature_dimension] tf.float32 tensor of
            features to predict from.
        labels: A [batch_size] tf.string tensor of labels.
        all_labels: A Python list of strings with all labels in the dataset.
        num_oov_buckets: The number of out-of-vocabulary buckets to create
            for handling labels that are not in all_labels.

    Returns:
        train_step: A tf.Operation that minimizes the loss.
        loss: A scalar tf.float32 tensor that is the total loss for the
        current mini-batch.
    """

    # Convert tensor of genre strings to numeric ids.
    table = tf.contrib.lookup.index_table_from_tensor(
        mapping=all_labels, num_oov_buckets=num_oov_buckets)
    y_ids = table.lookup(labels)

    # Construct one-hot encoding of the categorical labels.
    num_labels = len(all_labels) + num_oov_buckets
    y_one_hot = tf.one_hot(y_ids, num_labels)
    logits = predict(features, num_labels)
    cross_entropy = tf.losses.softmax_cross_entropy(y_one_hot, logits)

    # Compute the gradients and creates a tf op minimize the loss.
    train_step = tf.train.GradientDescentOptimizer(
        learning_rate).minimize(cross_entropy)
    return train_step, cross_entropy


def train_loop(train_op, loss):
    """Core training loop."""
    # TODO(amy): Use MonitoredTrainingSession instead of raw session.
    try:
        step = 0
        with tf.Session() as session:
            # Initialize all variables in the graph.
            session.run(tf.global_variables_initializer())
            session.run(tf.tables_initializer())
            # Train until our dataset iterator raises an OutOfRangeError. This
            # will happen after we've finished --num_epochs epochs.
            while True:
                _, loss_val = session.run([train_op, loss])
                step += 1
                logging.info('Step %d: loss=%f' % (step, loss_val))
    except tf.errors.OutOfRangeError:
        logging.info('Successfully trained to loss of %f' % loss_val)


def main(
        dataset,
        split,
        dataset_size,
        batch_size,
        learning_rate,
        num_epochs):
    features, labels, all_labels = load_data(
        dataset, split, dataset_size, batch_size, num_epochs)
    train_op, loss = specify_model(features, labels, all_labels, learning_rate)
    train_loop(train_op, loss)


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--dataset', default='fma')
    parser.add_argument('--split', default='training')
    parser.add_argument('--size', default='small')
    parser.add_argument('--num_epochs', default=10)
    parser.add_argument('--mini_batch_size', default=DEFAULT_MINI_BATCH_SIZE)
    parser.add_argument('--learning_rate', default=DEFAULT_LEARNING_RATE)
    args = parser.parse_args()

    main(
        args.dataset, args.split, args.size, args.mini_batch_size,
        args.learning_rate, args.num_epochs)
