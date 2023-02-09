#!/bin/bash

# Initialization command in the script
#source ~/miniconda3/etc/profile.d/conda.sh
source `conda info --base`/etc/profile.d/conda.sh

# Dtae and time
date +%c

# Import variables 
# This executes it in the context of the current shell, not as a sub shell
. ./MSc_smm_variables.sh

# Conda environment 8
conda activate dataframes

# Make directories for files for dataframes
mkdir -p dataframe_files/results

# Move files needed for dataframes
cp ${assembly} ${diting}/ORFs/sample_one.faa ${bins}bins_all.fa.faa ${bins}bins_all.fa.mobileOG.Alignment.Out.csv ${diting}/KEGG_annotation/ko_abun.txt ${diting}/pathways_relative_abundance_gene_level.tab dataframe_files

python scripts/MSc_sm_pipeline_fasta_to_tab.py -i dataframe_files/sample_one.faa -o dataframe_files/sample_one_faa.txt

python scripts/MSc_sm_pipeline_fasta_to_tab.py -i dataframe_files/bins_all.fa.faa -o dataframe_files/bins_all.fa.faa.txt

cd dataframe_files

python ../scripts/bcg_mge_profile.py

# Copy gene_id column
awk -v OFS="\t" '$3=$2' results/pathways_genes_df.txt > results/pathways_genes_out.txt

# Print copied column to a new file
awk '{print $3}' results/pathways_genes_out.txt > results/pathways_genes_1.txt

# Rename column and save to a new file
awk -v OFS="\t" '{gsub("gene_id", "Specific_Contig", $1)}1' results/pathways_genes_1.txt > results/pathways_genes_2.txt

# Remove gene_id from contig_id and save to a new file
awk -v OFS="\t" '{gsub(/\_[0-9]+$/, " ", $1)}1' results/pathways_genes_2.txt > results/pathways_genes.txt

# Remove white space from each line
cat results/pathways_genes.txt | awk '{ gsub(/ /,""); print }' > results/pathway_genes_3.txt

# Add a column from one file to another
paste -d'\t' results/pathways_genes_df.txt results/pathway_genes_3.txt > results/pathway_genes_comb.txt

# Remove intermediary files
rm -f results/pathways_genes_out.txt results/pathways_genes_out_1.txt results/pathways_genes_2.txt results/pathways_genes_1.txt results/pathway_genes_3.txt results/pathways_genes.txt

cd ..
##########################################################################################
mkdir -p intermediate_1 intermediate_2

# Convert fasta files to tab delimited files
for filename in ${bins}/*.fa; do 
    python scripts/MSc_sm_pipeline_fasta_to_tab.py -i $filename -o $filename.txt
done

mv ${bins}/*.txt intermediate_1
rm -f intermediate_1/bins_all.*

# Remove all blank lines from files
for filename in intermediate_1/*.txt; do
    awk NF $filename > $filename.tsv
done

# Renaming bin files
for f in intermediate_1/*.tsv; do
    mv -- "$f" "${f/%.fa.txt.tsv/.tsv}"
done

cd intermediate_1
# Add filename to the end of each line in the file
for filename in *.tsv; do
    awk '{print$0 "\t" FILENAME}' $filename > $filename.txt
done

mv *.tsv.txt ../intermediate_2
cd ..

# Renaming bin files
for f in intermediate_2/*.txt; do
    mv -- "$f" "${f/%.tsv.txt/.tsv}"
done

# Remove pattern .txt from file
for filename in intermediate_2/*.tsv; do
    awk '{gsub(/.tsv/, "");print}' $filename > $filename.txt
done

cat intermediate_2/*.txt > bins_contigs.txt

mv bins_contigs.txt dataframe_files

rm -rf intermediate_1 intermediate_2

python scripts/bcg_mge_profile_2.py

mkdir mge_bcg_results

mv dataframe_files/results/  mge_bcg_results

cp mge_bcg_results/results/mge_bcg_bins_df.txt mge_bcg_results 

# Date and time
date +%c
