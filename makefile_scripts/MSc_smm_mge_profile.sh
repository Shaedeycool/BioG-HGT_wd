#!/bin/bash

if [ -z "$(ls -A sample_one.fa.metabat-bins*)" ]; then
   echo "No bins detected"
else
   bash makefile_scripts/mge_profile.sh
fi