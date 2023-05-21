# BioG-HGT_wd
Identification of mobile genetic elements and biogeochemical cycling genes found on the same contig in metagenomic sequencing, paired-end reads. 

# STEP 1: Installation (Only needs to be done once)
Recommended configuration:

Linux OS

CPU threads ≥ 8

RAM ≥ 8 Gb

Pre-requisites:

Anaconda/Miniconda package management system (https://www.anaconda.com/products/distribution)

make (https://anaconda.org/anaconda/make)

wget (https://anaconda.org/anaconda/wget)

1. Download working directory from Github Repository

```
git clone https://github.com/Shaedeycool/BioG-HGT_wd.git 
```

Or click the green button Clone or download and select download ZIP to download the repo and unzip manually.

2. Download database and database files

```
wget https://figshare.com/ndownloader/files/38864850 -O BioG-HGT_wd/mobileOG-db/mobileOG-db-beatrix-1.5.dmnd

wget https://figshare.com/ndownloader/files/38861292 -O BioG-HGT_wd/mobileOG-db/beatrix-1-5_v1_all/mobileOG-db-beatrix-1.5.All.csv

wget https://figshare.com/ndownloader/files/38861988 -O BioG-HGT_wd/mobileOG-db/beatrix-1-5_v1_all/mobileOG-db-beatrix-1.5.All.faa
```

3. Change to the BioG-HGT working directory:

```
cd BioG-HGT_wd
```

4. Environment setup: Only needs to be done once!

```
make environment
```

# STEP 2: Running BioG-HGT profile 

1a. Running example: Download paired-end reads from figshare

```
wget https://figshare.com/ndownloader/files/38865606 -O data/example_R1.fastq.gz

wget https://figshare.com/ndownloader/files/38865615 -O data/example_R2.fastq.gz

make biog-hgt
```

1b. CAMI marine dataset sample downloaded from https://data.cami-challenge.org/participate used for the implementation of BioG-HGT.  
```
wget https://figshare.com/ndownloader/files/40696919
```

2. Run BioG-HGT pipeline on own paired-reads: copy paired-end reads to data folder

```
cp (path to paired-end reads) data

make biog-hgt
```

# STEP 3: Results

1. The tab delimited output file 'mge_bcg_bins_df.txt' can be found within 'bcg_mge_dir/mge_bcg_results' directory.

# STEP 4: Saving 'bcg_mge_dir'

1. Move bcg_mge_dir out of BioG-HGT_wd

```
mv bcg_mge_dir ../
```

# Contact us

email: rudylu.monica@gmail.com

# Citation
Please include the following citations:

Brown, C. L., Mullet, J., Hindi, F., Stoll, J. E., Gupta, S., Choi, M., Keenum, I., Vikesland, P., Pruden, A., & Zhang, L. (2021). mobileOG-db: a manually curated database of protein families mediating the life cycle of bacterial mobile genetic elements. bioRxiv, 2021.2008.2027.457951. https://doi.org/10.1101/2021.08.27.457951

Xue, C. X., Lin, H., Zhu, X. Y., Liu, J., Zhang, Y., Rowley, G., Todd, J. D., Li, M., & Zhang, X. H. (2021). DiTing: A Pipeline to Infer and Compare Biogeochemical Pathways From Metagenomic and Metatranscriptomic Data. Front Microbiol, 12, 698286. https://doi.org/10.3389/fmicb.2021.698286

Meyer, F., Fritz, A., Deng, Z.-L., Koslicki, D., Lesker, T. R., Gurevich, A., Robertson, G., Alser, M., Antipov, D., Beghini, F., Bertrand, D., Brito, J. J., Brown, C. T., Buchmann, J., Buluç, A., Chen, B., Chikhi, R., Clausen, P. T. L. C., Cristian, A., . . . McHardy, A. C. (2022). Critical Assessment of Metagenome Interpretation: the second round of challenges. Nature Methods, 19(4), 429-440. https://doi.org/10.1038/s41592-022-01431-4

Kang, D. W. D., Li, F., Kirton, E., Thomas, A., Egan, R., An, H., & Wang, Z. (2019). MetaBAT 2: an adaptive binning algorithm for robust and efficient genome reconstruction from metagenome assemblies. Peerj, 7. https://doi.org/ARTN e7359

Anaconda Software Distribution. (2020). Anaconda Documentation. Anaconda Inc. Retrieved from https://docs.anaconda.com/
