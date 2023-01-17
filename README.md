# BioG-HGT_wd
Identification of mobile genetic elements and biogeochemical cycling genes found on the same contig in metagenomic sequencing, paired-end reads. 

# Installation
Recommended configuration:

CPU threads ≥ 8

RAM ≥ 8 Gb


Pre-requisites:

Anaconda/Miniconda package management system (https://www.anaconda.com/products/distribution)

Docker (https://www.docker.com)


Step 1: Download working directory from Github Repository

git clone https://github.com/Shaedeycool/BioG-HGT_wd.git or click the green button Clone or download and select download ZIP to download the repo and unzip manually.


Step 2: Run Docker

# Running BioG-HGT profile 

Copy metagenomic paired-end FASTQ reads to data subdirectory:

cp <reads> path/BioG-HGT_wd/data

Change to the BioG-HGT working directory:

$ cd path/BioG-HGT_wd

Environment setup: only needs to be done once.

$ make environment

Run BioG-HGT pipeline:

$ make biog-hgt

# Contact us

email: 

# Citation
Please include the following citations 
