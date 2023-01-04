#!/bin/sh
#BSUB -q gpua100
#BSUB -J nnew_asteroid_22
#BSUB -n 16
#BSUB -R "span[hosts=1]"
#BSUB -gpu "num=1:mode=exclusive_process"
#BSUB -W 20:00
#BSUB -R "rusage[mem=8GB]"
##BSUB -R "select[gpu40gb]" #options gpu40gb or gpu80gb
#BSUB -o outputs/gpu_%J.out
#BSUB -e outputs/gpu_%J.err
# -- end of LSF options --

nvidia-smi

source asteroids/bin/activate

# Options
# Run main.py --help to get options


python3 run_model.py  >| lightning_log 

