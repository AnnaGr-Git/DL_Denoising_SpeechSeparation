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
The resulting `.json`files should look similar to ours that can be found [here](
