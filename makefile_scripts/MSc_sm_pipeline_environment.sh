#!/bin/bash

# Initialization command in the script
# source ~/miniconda3/etc/profile.d/conda.sh
source `conda info --base`/etc/profile.d/conda.sh

mkdir data

## Biogeochemical cycling genes - DiTing
conda config --add channels defaults

conda config --add channels conda-forge

conda config --add channels bioconda

conda config --add channels silentgene

conda create -y -n diting_env

conda activate diting_env

conda install -y -c silentgene diting # version 0.9

conda install -y -c bioconda trimmomatic # version 0.39

conda deactivate 

## BioG-HGT_env creation
conda create -y -n BioG-HGT_env

conda activate BioG-HGT_env

conda config --add channels bioconda

conda install -y -c bioconda bbmap

#conda install -y -c bioconda checkm-genome # version 1.2.0

conda deactivate

# Create SAMtools environment
conda create -y -n samtools_env

conda activate samtools_env 

conda install -y -c bioconda samtools # version 1.15.1

conda install -y -c bioconda metabat2 # version 2.15

conda deactivate


## Mobilome

# Create mobileOG environment
# Build conda environment
conda create -y -n mobileOG-db python=3.6.15

conda activate mobileOG-db # version beatrix-1.5

conda install -y -c conda-forge biopython # version 1.79

conda install -y -c bioconda prodigal # version 2.6.3

conda install -y -c bioconda diamond # version 2.0.15

conda install -y -c anaconda pandas # version 1.1.5

conda install -y -c anaconda wget # version 1.21.3

# Download mobileOG-db (From Website)
#git clone https://github.com/clb21565/mobileOG-db.git

# Change directory
#cd mobileOG-db

# Grant permissions
#chmod +x mobileOG-pl/mobileOGs-pl-kyanite.sh

# Move database files to current working directory
#mv -r ../beatrix-1-5_v1_all .

# Make Diamond Database
#diamond makedb --in beatrix-1-5_v1_all/mobileOG-db-beatrix-1.5.All.faa -d mobileOG-db-beatrix-1.5.dmnd

# Copy python code to working directory
#cp mobileOG-pl/mobileOGs-pl-kyanite.py .

conda deactivate

## Dataframes

# Create dataframes environment
conda create -y -n dataframes

conda activate dataframes

conda install -y -c anaconda python # version 3.10.4

conda install -y -c anaconda pandas # version 1.1.5

conda install -y -c conda-forge biopython # version 1.79

conda deactivate






