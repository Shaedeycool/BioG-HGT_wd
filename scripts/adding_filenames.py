import pandas as pd
import glob, os

files = glob.glob('*.tsv')
for fp in files:
    # Creating dataframes for every bin
    df = pd.read_csv(fp, sep='\t')
    # Add names to columns in dataframe
    df.columns = ["contig", "sequence"]
    # Saving every dataframe as a tab separated file
    df.to_csv(fp, sep='\t', index=False)

# Concatenating every bin into a single dataframe and adding the bin names as a column
df = pd.concat([pd.read_csv(fp, sep='\t').assign(bin=os.path.basename(fp))for fp in files])

# Save dataframe as tab delimited file
df.to_csv('bins_contig.txt', sep='\t', index=False)
