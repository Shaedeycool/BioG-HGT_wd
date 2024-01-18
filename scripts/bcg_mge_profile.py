import pandas as pd
import ast
from bcg_mge_functions import *

## DataFrame Creation

# Create dataframe from sample_one_fa.txt from MegaHit assembly
sample_one_fa_df = readcsv_2('dataframe_files/sample_one_fa.txt')

# Create dataframe for sample_one_faa.txt from diting_output/ORF and ko_abun.txt from DiTing 
sample_one_faa_df = readcsv_2('dataframe_files/sample_one_faa.txt')

ko_abun_df = readcsv('dataframe_files/ko_abun.txt')

# Create dataframe from bins_all.fa.mobileOG.Alignment.Out.csv from mobileOG
mobile_df = pd.read_csv('dataframe_files/bins_all.fa.mobileOG.Alignment.Out.csv')

# Create dataframe from pathways_relative_abundance_gene_level.tab
pathways_df = readcsv('dataframe_files/pathways_relative_abundance_gene_level.tab')


# Adding names to columns
sample_one_faa_df.columns = ['gene_id', '#_1', 'num_1', '#2', 'num_2', '#3', 'num_3', '#4', 'details', 'sequence']

sample_one_fa_df.columns = ['Specific_Contig', 'flag', 'multi', 'contig_length', 'sequence']

# Rename 'Contig/ORF Name' column to gene_id
renamecol(mobile_df, 'Contig/ORF Name', 'gene_id')

# Rename Specific Contig
renamecol(mobile_df, 'Specific Contig', 'Specific_Contig')


# Select columns
sample_one_faa_selcol_df = sample_one_faa_df[["gene_id", "sequence"]]

sample_one_fa_selcol_df = sample_one_fa_df[['Specific_Contig', 'contig_length']]

ko_abun_selcol_df = ko_abun_df[["k_number", "gene_id", "relative_abundance"]]

pathways_selcol_df = selcol(pathways_df, 'k_number', 'Detail')

mobile_selcol_df = mobile_df[['Specific_Contig', 'gene_id', 'e-value', 'Gene Name', 'Major mobileOG Category', 'Minor mobileOG Category', 'Evidence Type']].copy()


# Strip characters from a column
sample_one_fa_selcol_df['contig_length'] = sample_one_fa_selcol_df['contig_length'].str.replace('len=', '')


# Merge DataFrames
# Merge ko_abun_selcol_df and sample_one_faa_selcol_df on gene_id
ko_sample_genes_df = mergedf(ko_abun_selcol_df, sample_one_faa_selcol_df, 'gene_id')

# Merge sample_one_faa_selcol_df and sample_fa_selcol_df on Specific_Contig
mobile_selcol_df2 = mergedf(sample_one_fa_selcol_df, mobile_selcol_df, 'Specific_Contig')

# Merge sample_one_faa_selcol_df and mobile_selcol_df by columns on gene_id
sample_mobile_gene_df = mergedf(mobile_selcol_df2, sample_one_faa_selcol_df, 'gene_id')

# Merge pathways_df with ko_sample_genes_df on k_number
pathways_genes_df = mergedf(ko_sample_genes_df, pathways_selcol_df, 'k_number')


# Copy gene_id column and name column
pathways_genes_df['Specific_Contig'] = pathways_genes_df['gene_id']

# Remove gene_id from contig_id
pathways_genes_df['Specific_Contig'] = pathways_genes_df['Specific_Contig'].str.split('_').str[:-1].str.join('_')

# Rearrange columns
bcg_df = pathways_genes_df[['Specific_Contig', 'k_number', 'gene_id', 'relative_abundance', 'sequence', 'Detail']]

###################################################################################################################################################################

mge_df = sample_mobile_gene_df

bgc_df = pathways_genes_df

# function readcsv_2
bins_df = readcsv_2('dataframe_files/bins_contig.txt')

# Add names to bins_df columns 
bins_df.columns = ['Specific_Contig', 'sequence', 'bin']

# Strip characters from a column
bins_df['bin'] = bins_df['bin'].str.replace('.fa.tsv', '')

# Select columns
# Select columns from bins_df
bins_selcol_df = selcol(bins_df, 'Specific_Contig', 'bin')

# Merge DataFrames
# Merging dataframes for same contigs 
# function mergedf
mge_bins_df = mergedf(mge_df, bins_selcol_df, 'Specific_Contig')

#bcg_bins_df = pd.merge(bgc_df, bins_selcol_df, how='inner', on = 'Specific_Contig')
bcg_bins_df = mergedf(bgc_df, bins_selcol_df, 'Specific_Contig')

#mge_bgc_df = pd.merge(mge_df, bgc_df, how='inner', on = 'Specific_Contig')
mge_bgc_df = mergedf(mge_df, bgc_df, 'Specific_Contig')

#mge_bcg_bins_df = pd.merge(mge_bgc_df, bins_selcol_df, how='inner', on = 'Specific_Contig')
mge_bcg_bins_df = mergedf(mge_bgc_df, bins_selcol_df, 'Specific_Contig')

# Save merged DataFrame
# function savedf
savedf(mge_bgc_df, 'dataframe_files/results/mge_bgc_df.txt')

#mge_bins_df.to_csv('dataframe_files/results/mge_bins_df.txt', sep='\t', index=False)
savedf(mge_bins_df, 'dataframe_files/results/mge_bins_df.txt')

#bcg_bins_df.to_csv('dataframe_files/results/bcg_bins_df.txt', sep='\t', index=False)
savedf(bcg_bins_df, 'dataframe_files/results/bcg_bins_df.txt')

#mge_bcg_bins_df.to_csv('dataframe_files/results/mge_bcg_bins_df.txt', sep='\t', index=False)
savedf(mge_bcg_bins_df, 'dataframe_files/results/mge_bcg_bins_df.txt')

# Create and save Summary dataframe
summary_df = mge_bcg_bins_df[['Specific_Contig', 'contig_length', 'gene_id_x', 'Gene Name', 'Major mobileOG Category', 'gene_id_y', 'Detail', 'bin']] 
# Drop rows with the same values on all columns
summary = summary_df.drop_duplicates()
# Save summary dataframe
savedf(summary, 'dataframe_files/results/summary_mge_bcg_bins_df.txt')

