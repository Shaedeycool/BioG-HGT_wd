# BioG-HGT_wd
Identification of mobile genetic elements and biogeochemical cycling genes found on the same contig in metagenomic sequencing, paired-end reads. 

# Installation
Recommended configuration:

CPU threads ≥ 8

RAM ≥ 8 Gb

Pre-requisites:

Anaconda/Miniconda package management system (https://www.anaconda.com/products/distribution)

Docker (https://www.docker.com)

wget (https://anaconda.org/anaconda/wget)

1. Download working directory from Github Repository

git clone https://github.com/Shaedeycool/BioG-HGT_wd.git or click the green button Clone or download and select download ZIP to download the repo and unzip manually.

2. Download database and database files

$ wget https://figshare.com/ndownloader/files/38864850 -O BioG-HGT_wd/mobileOG-db/mobileOG-db-beatrix-1.5.dmnd

$ wget https://figshare.com/ndownloader/files/38861292 -O BioG-HGT_wd/mobileOG-db/beatrix-1-5_v1_all/mobileOG-db-beatrix-1.5.All.csv

$ wget https://figshare.com/ndownloader/files/38861988 -O BioG-HGT_wd/mobileOG-db/beatrix-1-5_v1_all/mobileOG-db-beatrix-1.5.All.faa

3. Run Docker

# Running BioG-HGT profile 

1. Copy metagenomic paired-end FASTQ reads to data subdirectory:

$ mkdir data

$ cp (path to paired-end reads) data

$ mv data BioG-HGT_wd

2. Change to the BioG-HGT working directory:

$ cd BioG-HGT_wd

3. Environment setup: only needs to be done once.

$ make environment

4. Run BioG-HGT pipeline:

$ make biog-hgt

# Contact us

email: rudylu.monica@gmail.com

# Citation
Please include the following citations 
