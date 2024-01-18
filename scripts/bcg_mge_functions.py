import pandas as pd

# Create a read_csv function
def readcsv(filename):
    df = pd.read_csv(filename, sep='\t')
    return df

def readcsv_2(filename):
    df = pd.read_csv(filename, sep='\t', header=None)
    return df

# Create select columns function
def selcol(df, col_1, col_2):
    df_selcol = df[[col_1, col_2]].copy()
    return df_selcol

# Create rename columns function
def renamecol(df, old_name, new_name):
    rename_col = df.rename(columns = {old_name : new_name}, inplace = True)
    return rename_col

# Create mergedf function
def mergedf(df1, df2, column):
    merged_df = pd.merge(df1, df2, how='inner', on = column)
    return merged_df

# Create savedf function
def savedf(df, filename):
    save_df = df.to_csv(filename, sep='\t', index=False)
    return save_df


