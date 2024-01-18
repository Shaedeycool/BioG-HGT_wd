# 	To run all commands in the same shell
.ONESHELL:

#	Need to specify bash in order for conda activate to work.
SHELL = /bin/bash
# 	Note that the extra activate is needed to ensure that the activate floats env to the front of PATH
CONDA_ACTIVATE = source $$(conda info --base)/etc/profile.d/conda.sh ; conda activate ; conda activate

# Specify variables
################################################################CAN BE EDITED######################################
# CPUs 
cpus="4"														# Can be edited

# Trimmomatic parameters
adapter="NexteraPE-PE.fa"										# Can be edited
parameters=":2:30:10"											# Can be edited
illuminaclip="ILLUMINACLIP:adapters/${adapter}${parameters}"	# Can be edited
leading="LEADING:3"												# Can be edited
trailing="TRAILING:3"											# Can be edited
slidingwindow="SLIDINGWINDOW:4:15"								# Can be edited
minlen="MINLEN:36"												# Can be edited
###################################################################################################################

# Read names
read_1="data/sample_one_1.fq.gz"
read_2="data/sample_one_2.fq.gz"
sample="sample_one"

# Trimmomatic output
unpaired_reads="results/data/sample_one"
paired_reads="trim_pe/sample_one"

# Megahit Output
assembly="assembly/${sample}.fa"

# Run bbmaps
interleaved_reads="results/interleaved_reads/${sample}.fq.gz"	
##################################################################################################################


# Make all
biog-hgt:
	make rename_pefiles trim megahit diting bbmap samtools metabat2 mobileOG dataframe_prep mge_bcg_profile 

# Rename paired-end reads files - formating
rename_pefiles:
	python scripts/MSc_sm_pipeline_rename.py

# Trimmomatic
trim:
# 	Start time
	date +%c

# 	Create multiple directories and subdirectories with single command
	mkdir -p trim_pe assembly results/data results/interleaved_reads results/bbmap

# 	Conda environment 1
	$(CONDA_ACTIVATE) diting_env

# 	Run trimmomatic
	trimmomatic PE -phred33 -threads ${cpus} ${read_1} ${read_2}  ${paired_reads}_1.fq.gz ${unpaired_reads}_forward_unpaired.fq.gz ${paired_reads}_2.fq.gz ${unpaired_reads}_reversed_unpaired.fq.gz ${illuminaclip} ${leading} ${trailing} ${slidingwindow} ${minlen}

#	End time
	date +%c

megahit:
# 	Start time
	date +%c

# 	Conda environment 1
	$(CONDA_ACTIVATE) diting_env

#	Run megahit	assembler
	megahit -1 trim_pe/sample_one_1.fq.gz -2 trim_pe/sample_one_1.fq.gz -o megahit_output

#	Rename assembled contig
	mv megahit_output/final.contigs.fa assembly/sample_one.fa

#	End time
	date +%c

diting:
# 	Start time
	date +%c

# 	Conda environment 1
	$(CONDA_ACTIVATE) diting_env

#	Run diting
	diting.py -r trim_pe -a assembly/ -o diting_output -n ${cpus}

#	End time
	date +%c	

bbmap:
# 	Start time
	date +%c

# 	Conda environment 1
	$(CONDA_ACTIVATE) diting_env

# 	Run bbmap, create interleaved reads and sam file
	reformat.sh in1=${paired_reads}_1.fq.gz in2=${paired_reads}_2.fq.gz out=results/interleaved_reads/${sample}.fq.gz

	bbmap.sh in=results/interleaved_reads/${sample}.fq.gz out=results/bbmap/mapped.sam ref=${assembly}

#	End time
	date +%c	

samtools:
# 	Start time
	date +%c

# 	Conda environment 2
	$(CONDA_ACTIVATE) samtools_env

# 	Run samtools
	samtools sort results/bbmap/mapped.sam -o results/bbmap/mapped.bam	

#	End time
	date +%c	

metabat2:
# 	Start time
	date +%c

# 	Conda environment 2
	$(CONDA_ACTIVATE) samtools_env

#	Run MetaBAT2	
	runMetaBat.sh ${assembly}  results/bbmap/mapped.bam

#	End time
	date +%c

mobileOG:
# 	Start time
	date +%c

#	Conda environment 3
	$(CONDA_ACTIVATE) mobileOG-db 

	cat sample_one.fa.metabat-bins-*/bin.*.fa > results/bins_all.fa 

#	Change directory (Have to change into directory or the correct output file will not be formed)
	cd mobileOG-db

# 	Run mobileOG pipeline
	bash mobileOG-pl/mobileOGs-pl-kyanite.sh -i ../results/bins_all.fa -d mobileOG-db-beatrix-1.5.dmnd -m beatrix-1-5_v1_all/mobileOG-db-beatrix-1.5.All.csv -k 15 -e 1e-20 -p 90 -q 90

#	Change directory to BioG-HGT working directory
	cd ..

#	End time
	date +%c

dataframe_prep:
# 	Start time
	date +%c

#	Conda environment 4
	$(CONDA_ACTIVATE) dataframes

#	Make directories for files for dataframes
	mkdir -p dataframe_files/results

#	Move files for dataframe creation (6 files in total)
	cp ${assembly} diting_output/ORFs/${sample}.faa diting_output/KEGG_annotation/ko_abun.txt diting_output/pathways_relative_abundance_gene_level.tab results/bins_all.fa.faa dataframe_files
	cp results/bins_all.fa.mobileOG.Alignment.Out.csv results/bins_all.fa.faa dataframe_files

#	Convert fasta files to tab delimited files
	python scripts/MSc_sm_pipeline_fasta_to_tab.py -i dataframe_files/${sample}.faa -o dataframe_files/${sample}_faa.txt
	python scripts/MSc_sm_pipeline_fasta_to_tab.py -i dataframe_files/${sample}.fa -o dataframe_files/${sample}_fa.txt

#	Converting every bin file to tab delimited files
	for filename in sample_one.fa.metabat-bins-*/*.fa; do python scripts/MSc_sm_pipeline_fasta_to_tab.py -i $$filename -o $$filename.txt; awk NF $$filename.txt > $$filename.tsv; rm -rf $$filename.txt; done
#	Have to change directory to get the right bin with corresponding contig	
	cd sample_one.fa.metabat-bins-*
#	Adding bin number to corresponding contig sequence in fasta files
	python ../scripts/adding_filenames.py
#	Change directory back to BioG-HGT working directory
	cd ..

#	Move resultant file to dataframe_files directory
	mv sample_one.fa.metabat-bins-*/bins_contig.txt dataframe_files
# 	End time
	date +%c	

mge_bcg_profile:
# 	Start time
	date +%c

#	Conda environment 4
	$(CONDA_ACTIVATE) dataframes

#	Run dataframes creation
	python scripts/bcg_mge_profile.py

# 	End time
	date +%c
#########################################################################################
	
# Cleanup
cleanup:
	rm -rf assembly diting_output megahit_output ref results sample_one.fa.depth.txt sample_one.fa.metabat-bins-20240112_174514

	mv dataframe_files/results bcg_mge_results 
