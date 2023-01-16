import sys
import getopt
import pandas as pd

def myfunc(argv):
    arg_input = " "
    arg_output = " "
    arg_help = "{0} -i <input> -o <output>".format(argv[0])

    try:
        opts, args = getopt.getopt(argv[1:], "i:o:", ["input=", "output="])
    except:
        print(arg_help)
        sys.exit(2)

    for opt, arg in opts:
        if opt in ("-h", "--help"):
            print(arg_help)
            sys.exit(2)
        if opt in ("-i", "--input"):
            arg_input = arg
        elif opt in ("-o", "--output"):
            arg_output = arg

    df_1 = pd.read_csv(arg_input, sep='\t')

    df_2 = df_1.loc[df_1['e-value'] == 0.0]

    df_3 = df_2.drop_duplicates()

    df_4 = df_3[['Specific_Contig', 'gene_id_x', 'e-value', 'Gene Name', 'Major mobileOG Category', 'Minor mobileOG Category', 'Evidence Type', 'k_number', 'gene_id_y', 'relative_abundance', 'Detail', 'bin']].copy()

    df_4.to_csv(arg_output, sep='\t', index=False)

if __name__ == "__main__":
    myfunc(sys.argv)