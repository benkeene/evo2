#!/bin/bash

export CONDA_PKG_DIRS=$PROJECT/.conda/packages/
export PIP_CACHE_DIR=$PROJECT/.pip/cache/
export HF_HOME=$PROJECT/.huggingface/cache

# Load required modules
module load cuda/12.6.1 cudnn/8.0.4 gcc/10.2.0 anaconda3

# Initialize Anaconda
conda init bash

# Reload bash configurations to activate Anaconda
echo "Reloading ~/.bashrc..."
source ~/.bashrc
echo "~/.bashrc reloaded!"

# Create a new environment, python version 3.11, with pip
# in $PROJECT storage
conda create --prefix $PROJECT/envs/evo2 python=3.11 pip -y

# Load the Python environment
conda activate $PROJECT/envs/evo2

# Install evo2's requirements
time pip install -r requirements.txt

echo "========================= INSTALL TORCH ==============="
# Install PyTorch for Vortex setup
time pip install torch

# Set max_workers
export MAX_JOBS=128

# Install evo2
echo "========================= INSTALL EVO ================="
time pip install -v .
