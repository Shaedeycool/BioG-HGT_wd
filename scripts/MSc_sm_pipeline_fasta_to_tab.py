# open file and iterate through the lines, composing each single line as we go
# Convert fasta file to tab delimited file
import sys
import getopt

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

    out_lines = []
    temp_line = ''
    with open(arg_input,'r') as fp:
     for line in fp:
         if line.startswith('>'):
            out_lines.append(temp_line)
            temp_line = line.strip() + '\t'
         else:
            temp_line += line.strip()

    with open(arg_output, 'w') as fp_out:
        fp_out.write('\n'.join(out_lines))

# Program that opens metachip.txt file, reads it, examining the file line by line
# Removes > from file

    out_lines2 = []
# Removes ">" from file
    with open(arg_output, 'r') as file_object:
        for line in file_object:
            if line.startswith('>'):
                out_lines2.append(line[1:])
        
    with open(arg_output, 'w') as file_object:
        file_object.write('\n'.join(out_lines2))

    out_lines2 = []
#Replaces ' ' with \t from file
    with open(arg_output, 'r') as file_object:
        for line in file_object:
            out_lines2.append(line.replace(' ', '\t'))

    with open(arg_output, 'w') as file_object:
        file_object.write('\n'.join(out_lines2))

if __name__ == "__main__":
    myfunc(sys.argv)