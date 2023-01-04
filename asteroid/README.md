# Setting up and using Asteroid to train DPRNN model

To setup the environment for training the mentioned 2ch and 2+1ch DPRNN models, follow the steps described [here](https://github.com/asteroid-team/asteroid). Or if you want to use DTU HPC,you can follow the steps described in [wiki](https://github.com/AnnaGr-Git/DL_Denoising_SpeechSeparation/wiki)

## Setting up LibriMix dataset and training your model

If you have downloaded Asteriod locally or in Colab, please replace `librimix_dataset.py` with our file. We have modified the code to add noise as source audio when needed. Then:

* add and run `get_LiriMixdata.py` (all the data will be stored in the `MiniLibriMix` folder)

## Usage

An examplary usage of training and using DPRNN for a small dataset can be found [here](https://github.com/AnnaGr-Git/DL_Denoising_SpeechSeparation/blob/main/Train_SVoice_Example.ipynb).

For bigger datasets, the models need to be trained on DTU HPC. The required steps are decribed in the following. Please add our scripts in your asteroid folder: `run_model.py`, `job.sh`, `reload_DPRNN_model.py`, 

### Training
Training is simply done by launching the `run_model.py` script:

```
python run_model.py
```

 We used the default hyperparameters as provided in the file. To overwrite the default dataset to the desired LibriMix dataset configured before, change the `run_model.py`:

``` python
# An example about use LibriMix dataset
# To train 2+1 ch model 
# train_loader, val_loader = LibriMix.loaders_from_mini(task="sep_noisy", batch_size=16, n_src=3)

# To train 2 ch model
train_loader, val_loader = LibriMix.loaders_from_mini(task="sep_noisy", batch_size=16, n_src=2)

# Tell DPRNN that we want to separate to 3 sources.
# model = DPRNNTasNet(n_src=3)

# Tell DPRNN that we want to separate to 2 sources.
model = DPRNNTasNet(n_src=2)

```
then run `run_model.py`


## Reload model from checkpoint and separation

After training, you can launch the `reload_Dprnnmodel` to reload trained model from checkpoints. Then you can continue training it for better results or test the trained model.

An examplary usage of reloading DPRNN model and separating can be found in `reload_DPRNN_Example.ipynb`

## Evaluating is the same as for SVoice in the main [README](https://github.com/AnnaGr-Git/DL_Denoising_SpeechSeparation/blob/main/README.md)



# Note
`dprnn_model_3.pth` and `dprnn_model_22.pth` are our trained models for 2+1 ch and 2 ch, respectively. 
