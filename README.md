# MT Exercise 4

## Run the code
To run the code follow the same instructions as in the MT_FS21_4_Exercise.pdf. All necessary files have been adapted.

## Changes

### deen_transformer_layerdrop.yaml
- setting active_layers and layerdrop

### evaluate.sh & train.sh
- changing the model to deen_transformer_layerdrop


# mt_fs21_ex4

This repo is just a collection of scripts showing how to install [JoeyNMT](https://github.com/joeynmt/joeynmt), download
data and train & evaluate models.

# Requirements

- This only works on a Unix-like system, with bash.
- Python 3 must be installed on your system, i.e. the command `python3` must be available
- Make sure virtualenv is installed on your system. To install, e.g.

    `pip install virtualenv`

# Steps

Clone this repository in the desired place:

    git clone https://github.com/lucasseiler/mt_fs21_ex4

Create a new virtualenv that uses Python 3. Please make sure to run this command outside of any virtual Python environment:

    ./scripts/make_virtualenv.sh

**Important**: Then activate the env by executing the `source` command that is output by the shell script above.

Download and install required software:

    ./scripts/download_install_packages.sh

Download data:

    ./scripts/download_preprocessed_data.sh

Train a model:

    ./scripts/train.sh

The training process can be interrupted at any time, and the best checkpoint will always be saved.

Evaluate a trained model with

    ./scripts/evaluate.sh
