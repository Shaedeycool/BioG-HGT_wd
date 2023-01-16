import pandas as pd
import ast

# Create dataframe for bin_stats_ext.tsv
checkm_df = pd.read_csv('checkm_output/storage/bin_stats_ext.tsv', sep='\t', header=None)

# Adding names to columns of checkm_df 
checkm_df.columns = ['user_genome', 'Details']

# Selecting for user_genome column
checkm_bins_df = checkm_df['user_genome'].copy()

# Selecting for Details column
checkm_details = checkm_df['Details']

# Converting details column to dataframe
checkm_details_df = checkm_details.to_frame()

# Saving checkm_details_df
checkm_details_df.to_csv('dataframe_files/checkm_details_df.txt', sep='\t', index=False, header=False)

# Removing quotation marks from checkm_details_df.txt
checkm_details_list = []

with open('dataframe_files/checkm_details_df.txt', "r") as fp:
    for line in fp:
        checkm_details_list.append(line.replace('"', ''))

filename = 'dataframe_files/checkm_details_list.txt'
with open(filename, 'w') as fp:
    for item in checkm_details_list:
        fp.write("%s" % item)

# Creating dataframe from checkm_details_list.txt
checkm_details_list_df = pd.DataFrame(pd.read_csv('dataframe_files/checkm_details_list.txt', sep="|", header=None).iloc[:,0].apply(ast.literal_eval).tolist())

# Join checkm_bins_df and checkm_details_list_df by columns
checkm_df = pd.concat([checkm_bins_df, checkm_details_list_df], axis = 1)

# Create dataframe with selected columns
checkm_selcol_df = checkm_df[["user_genome", "marker lineage", "Completeness", "Contamination"]]

# Save dataframe
checkm_selcol_df.to_csv('dataframe_files/results/checkm_df.txt', sep='\t', index=False)