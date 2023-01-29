#!/bin/bash

# Initialization command in the script
source ~/miniconda3/etc/profile.d/conda.sh

# Start time
date +%c

# Create multiple directories and subdirectories with single command
mkdir -p trim_pe results/data

# Import variables 
# This executes it in the context of the current shell, not as a sub shell
. ./MSc_smm_variables.sh

# Conda environment 1
conda activate diting_env

# Run trimmomatic
trimmomatic PE -phred33 -threads ${cpus} ${read_1} ${read_2}  ${paired_reads}_1.fq.gz ${unpaired_reads}_forward_unpaired.fq.gz ${paired_reads}_2.fq.gz ${unpaired_reads}_reversed_unpaired.fq.gz ${illuminaclip} ${leading} ${trailing} ${slidingwindow} ${minlen}

# Run DiTing pipeline
diting.py -r trim_pe/ -o diting_output -n ${cpus}

# Conda environment 2
conda activate BioG-HGT_env

# Run bbmaps
reformat.sh in1=${paired_reads}_1.fq.gz in2=${paired_reads}_2.fq.gz out=results/interleaved_reads/${sample}.fq.gz

bbmap.sh in=results/interleaved_reads/sample_one.fq.gz out=results/bbmap/mapped.sam ref=${assembly}

# Conda environment 3
conda activate samtools_env

# Run samtools
samtools sort results/bbmap/mapped.sam -o results/bbmap/mapped.bam

# Run MetaBAT2
#docker run --workdir $(pwd) --volume $(pwd):$(pwd) metabat/metabat:latest runMetaBat.sh diting_output/Assembly/sample_one.fa  results/bbmap/mapped.bam

runMetaBat.sh diting_output/Assembly/sample_one.fa  results/bbmap/mapped.bam

# Check if there are bins in the bins directory
if [ -z "$(ls -A sample_one.fa.metabat-bins*)" ]; then
   echo "No bins detected"
else
   # Conda environment 4
    conda activate mobileOG-db

    cd ${bins}

    cat bin.*.fa > bins_all.fa

    cd ..

    # Run mobileOG pipeline
    cd ${mobileOG_output}
    bash mobileOG-pl/mobileOGs-pl-kyanite.sh -i ../${bins}bins_all.fa -d mobileOG-db-beatrix-1.5.dmnd -m ${mobileOG_db}/mobileOG-db-beatrix-1.5.All.csv -k 15 -e 1e-20 -p 90 -q 90
    cd ..
fi

# Date and time
date +%c
