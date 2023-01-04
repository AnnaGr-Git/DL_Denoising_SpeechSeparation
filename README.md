# Denoising in Dual-Path-RNN-based Speech Separation
This repository contains the hand-in files of the DTU Deep Learning course Fall 2022 of group 91.

We present two new training approaches for the state-of-the art models in speech separation for usage in noisy environments. Additionally, the models are tested on different noise categories and intensities. The new methods of using an additional output channel for noise data, and employing a cascade approach, both outperform the current method for known noise data. For unknown noise, the performance depends heavily on the noise category and the noise intensity.

Audio samples of the proposed 2+1ch model can be found here: [Samples](https://github.com/AnnaGr-Git/DL_hand-in/tree/main/data/samples)

## Setting up and using SVoice

To setup the environment for training the mentioned 2ch and 2+1ch SVoice models, follow the steps described [here](https://github.com/facebookresearch/svoice).

### Setting up a our training dataset

If you want to train the model using our dataset, first follow the instruction for creating the subset from LibriMix, and save the files in the following structure: tr/s1, tr/s2, tr/s3, val/s1, val/s2, val/s3. Then:
1. Create a separate config file for it, which refers to the data folders, similar to the ones we used: [config](https://github.com/AnnaGr-Git/DL_hand-in/tree/main/data/conf). To train the 2+1ch model, the s3 folder should contain the noise data. To train the 2ch model, only the s1 and s2 folders are needed.
2. Place the new config files under the `dset` folder. 
3. Point to it either in the general config file or via the command line, e.g. `./train.py dset=name_of_dset`.

You also need to generate the relevant `.json`files in the `egs/`folder.
For that purpose you can use the `python -m svoice.data.audio` command that will
scan the given folders and output the required metadata as json.
For example, if your mixture files are located in `$mix` and the separated files are in `$spk1`, `$spk2`, and the noise is saved in `$spk3`, you can do

```bash
out=egs/dataset_2+1ch/tr
mkdir -p $out
python -m svoice.data.audio $mix > $out/mix.json
python -m svoice.data.audio $spk1 > $out/s1.json
python -m svoice.data.audio $spk2 > $out/s2.json
python -m svoice.data.audio $spk3 > $out/s3.json
```
The resulting `.json`files should look similar to ours that can be found [here](https://github.com/AnnaGr-Git/DL_hand-in/tree/main/data/egs/dataset_2%2B1ch). 

### Usage

#### Training
Training is simply done by launching the `train.py` script:

```
python train.py
```

This will automaticlly read all the configurations from the `conf/config.yaml` file in the SVoice repository. We used the same hyperparameters as provided in the file. To overwrite the default dataset to the desired LibriMix dataset configured before, do:
```
python train.py dset=dataset_2+1ch 
```

#### Logs

Logs are stored by default in the `outputs` folder. Look for the matching experiment name.
In the experiment folder you will find the training checkpoint `checkpoint.th` (containing the last state as well as the best state)
as well as the log with the metrics `trainer.log`. All metrics are also extracted to the `history.json`
file for easier parsing. Enhancements samples are stored in the `samples` folder (if `mix_dir` or `mix_json`
is set in the dataset config yaml file).

Our output files can be found [here](https://github.com/AnnaGr-Git/DL_hand-in/tree/main/outputs). The checkpoint files could not be added to this repository, since the files are >100 MB. They can be provided on request. The checkpoint files could also be used to continue the training for better results.


### Separation

Separating files can be done by launching the following:

```
python -m svoice.separate <path to the model> <path to store the separated files> --mix_dir=<path to the dir with the mixture files>
```

### Evaluating

Evaluating the models can be done by launching the following:

```
python -m svoice.evaluate <path to the model> <path to folder containing mix.json and all target separated channels json files s<ID>.json>
```

For more details regarding possible arguments, please see:

```

positional arguments:
  model_path            Path to model file created by training
  data_dir              directory including the .json files for the test data. This should include mix.json, s1.json, s2.json and s3.json for the 2+1ch model and mix.json, s1.json, s2.json for the 2ch model. 
