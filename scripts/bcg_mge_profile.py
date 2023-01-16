import pandas as pd
import ast

## DataFrame Creation

# Create dataframe for sample_one_faa.txt from diting_output/ORF
sample_one_faa_df = pd.read_csv('sample_one_faa.txt', sep='\t', header=None)

# Adding names to columns
sample_one_faa_df.columns = ['gene_id', '#_1', 'num_1', '#2', 'num_2', '#3', 'num_3', '#4', 'details', 'sequence']

# Create dataframe with selected columns
sample_one_faa_selcol_df = sample_one_faa_df[["gene_id", "sequence"]]

# Create dataframe for ko_abun.txt from DiTing
ko_abun_df = pd.read_csv('ko_abun.txt', sep='\t')

# Create dataframe with selected columns
ko_abun_selcol_df = ko_abun_df[["k_number", "gene_id", "relative_abundance"]]

# Merge ko_abun_selcol_df and sample_one_faa_selcol_df on gene_id
ko_sample_genes_df = pd.merge(ko_abun_selcol_df, sample_one_faa_selcol_df, how='inner', on = 'gene_id')

# Create dataframe from pathways_relative_abundance_gene_level.tab
pathways_df = pd.read_csv('pathways_relative_abundance_gene_level.tab', sep='\t')

# Select columns
pathways_selcol_df = pathways_df[['k_number', 'Detail']].copy()

# Merge pathways_df with ko_sample_genes_df on k_number
pathways_genes_df = pd.merge(ko_sample_genes_df, pathways_selcol_df, how='inner', on = 'k_number')

# Save pathways_genes_df 
pathways_genes_df.to_csv('results/pathways_genes_df.txt', sep='\t', index=False)

# Create mobile_df dataframe from sample_one.fa.mobileOG.Alignment.Out.csv from mobileOG
mobile_df = pd.read_csv('bins_all.fa.mobileOG.Alignment.Out.csv')

# Rename 'Contig/ORF Name' column to gene_id
mobile_df.rename(columns = {'Contig/ORF Name' : 'gene_id'}, inplace = True)

# Rename Specific Contig
mobile_df.rename(columns = {'Specific Contig' : 'Specific_Contig'}, inplace = True)

# Select columns
mobile_selcol_df = mobile_df[['Specific_Contig', 'gene_id', 'e-value', 'Gene Name', 'Major mobileOG Category', 'Minor mobileOG Category', 'Evidence Type']].copy()

# Merge sample_one_faa_selcol_df and mobile_selcol_df by columns on gene_id
sample_mobile_gene_df = pd.merge(mobile_selcol_df, sample_one_faa_selcol_df, how='inner', on = 'gene_id')

# Save sample_mobile_df
sample_mobile_gene_df.to_csv('results/mobile_gene_df.txt', sep='\t', index=False)

###################################################################################################################################################################

