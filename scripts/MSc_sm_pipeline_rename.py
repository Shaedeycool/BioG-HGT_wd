import os

for file in os.listdir("data"):
    if file.endswith("_R1_001.fastq.gz"):
        old_file_1 = os.path.join("data", file)
    elif file.endswith("_1.fastq.gz"):
        old_file_1 = os.path.join("data", file)
    elif file.endswith("_R1.fastq.gz"):
        old_file_1 = os.path.join("data", file)
    elif file.endswith("_R1.fq.gz"):
        old_file_1 = os.path.join("data", file)
    elif file.endswith("_1.fq.gz"):
	    old_file_1 = os.path.join("data", file)
        
print(old_file_1)

for file in os.listdir("data"):
    if file.endswith("_R2_001.fastq.gz"):
        old_file_2 = os.path.join("data", file)
    elif file.endswith("_2.fastq.gz"):
        old_file_2 = os.path.join("data", file)
    elif file.endswith("_R2.fastq.gz"):
        old_file_2 = os.path.join("data", file)
    elif file.endswith("_R2.fq.gz"):
        old_file_2 = os.path.join("data", file)
    elif file.endswith("_2.fq.gz"):
	    old_file_2 = os.path.join("data", file)

print(old_file_2)

new_file_1 = "data/sample_one_1.fq.gz"
new_file_2 = "data/sample_one_2.fq.gz"

os.rename(old_file_1, new_file_1)
print("File renamed!")

os.rename(old_file_2, new_file_2)
print("File renamed!")



