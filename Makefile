# Environment setup
environment:
	bash makefile_scripts/MSc_sm_pipeline_environment.sh
	
# Rename paired-end reads files - formating
rename_pefiles:
	python scripts/MSc_sm_pipeline_rename.py

# Trimmomatic, DiTing, BBMaps, SAMtools, MetaBAT2
bcg_bins:
	bash makefile_scripts/MSc_smm_bcg_bins.sh

# MGE BCG Profile
mge_bcg_profile:
	bash makefile_scripts/MSc_smm_mge_profile.sh

# Run CheckM
checkm:
	bash makefile_scripts/MSc_sm_checkm.sh
	
# Cleanup
cleanup:
	bash makefile_scripts/MSc_smm_cleanup.sh