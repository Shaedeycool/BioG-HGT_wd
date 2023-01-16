#!/bin/bash

# Initialization command in the script
source ~/miniconda3/etc/profile.d/conda.sh

# Date and time
date +%c

# Clean-up 
mkdir bcg_mge_dir

if [ -d "dataframe_files" ] && [ -d "mge_bcg_results" ]; then
  # move files from working directory to sub-folder
  mv dataframe_files mge_bcg_results bcg_mge_dir
fi

mv trim_pe diting_output sample_one.fa.* bcg_mge_dir

cp -r data bcg_mge_dir

rm -rf results ref data/*.gz

# Date and time
date +%c
