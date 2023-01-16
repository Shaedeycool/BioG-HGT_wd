import pandas as pd

## DataFrame Creation

# Create dataframe for mobile genes and pathways on contigs
mge_df = pd.read_csv('dataframe_files/results/mobile_gene_df.txt', sep='\t')

bgc_df = pd.read_csv('dataframe_files/results/pathway_genes_comb.txt', sep='\t')

bins_df = pd.read_csv('dataframe_files/bins_contigs.txt', sep='\t', header=None)

# Add names to bins_df columns 
bins_df.columns = ['Specific_Contig', 'sequence', 'bin']

# Select columns from bins_df
bins_selcol_df = bins_df[['Specific_Contig', 'bin']].copy()

# Convert Specific_Contig column to a list
specific_contig_list = bgc_df['Specific_Contig'].tolist()

mge_scontigscol_list = mge_df['Specific_Contig'].tolist()

# Merging dataframes for same contigs 
mge_bins_df = pd.merge(mge_df, bins_selcol_df, how='inner', on = 'Specific_Contig')

bcg_bins_df =pd.merge(bgc_df, bins_selcol_df, how='inner', on = 'Specific_Contig')

mge_bgc_df = pd.merge(mge_df, bgc_df, how='inner', on = 'Specific_Contig')

mge_bcg_bins_df = pd.merge(mge_bgc_df, bins_selcol_df, how='inner', on = 'Specific_Contig')

# Save merged dataframe
mge_bgc_df.to_csv('dataframe_files/results/mge_bgc_df.txt', sep='\t', index=False)

mge_bins_df.to_csv('dataframe_files/results/mge_bins_df.txt', sep='\t', index=False)

bcg_bins_df.to_csv('dataframe_files/results/bcg_bins_df.txt', sep='\t', index=False)

mge_bcg_bins_df.to_csv('dataframe_files/results/mge_bcg_bins_df.txt', sep='\t', index=False)
