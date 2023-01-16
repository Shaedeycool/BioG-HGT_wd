#!/bin/bash

# Variables

# CPUs
cpus="8"

# Read names
read_1="data/sample_one_1.fq.gz"
read_2="data/sample_one_2.fq.gz"
sample="sample_one"

# Trimmomatic parameters
illuminaclip="ILLUMINACLIP:adapters/NexteraPE-PE.fa:2:30:10"
leading="LEADING:3"
trailing="TRAILING:3"
slidingwindow="SLIDINGWINDOW:4:15"
minlen="MINLEN:36"

# Trimmomatic output
unpaired_reads="results/data/sample_one"
paired_reads="trim_pe/sample_one"

# DiTing output
diting="diting_output"
assembly="${diting}/Assembly/${sample}.fa"

# Run bbmaps
interleaved_reads="results/interleaved_reads/${sample}.fq.gz"

# MetaBAT2 output
bins="sample_one.fa.metabat-bins-*/"

# Checkm-genome output
checkm_stats="checkm_output/storage/bin_stats_ext.tsv"

# GTDBTk path
GTDBTK_DATA_PATH=/

# GTDBTk output
gtdbtk_bac="gtdbtk_output/classify/gtdbtk.bac120.summary.tsv"
gtdbtk_arc="gtdbtk_output/classify/gtdbtk.ar122.summary.tsv"

# MetaCHIP output
metachip="metachip_output_MetaCHIP_wd"
metachip_prodigal="metachip_output_pcofg_prodigal_output"

# mobileOG-db
mobileOG_output="mobileOG-db"
mobileOG_db="beatrix-1-5_v1_all"

