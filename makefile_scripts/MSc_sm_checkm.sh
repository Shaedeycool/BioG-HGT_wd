#!/bin/bash

# Initialization command in the script
source ~/miniconda3/etc/profile.d/conda.sh

# Date and time
date +%c

# Import variables 
# This executes it in the context of the current shell, not as a sub shell
. ./MSc_smm_variables.sh

# Run CheckM docker
docker run --rm -i -t --volume ${PWD}:/home --platform linux/amd64 quay.io/biocontainers/checkm-genome:1.2.1--pyhdfd78af_0 bash home/makefile_scripts/checkm.sh

# Conda environment 8
conda activate dataframes

python scripts/checkm_test_df.py

# Date and time
date +%c