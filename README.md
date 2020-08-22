# duckweed_MA

Code and files associated with Sandler et al. publication on mutation rates in two species of duckweed (L.minor and S. polyrhiza).
preprint link: https://www.biorxiv.org/content/10.1101/2020.06.26.173039v1

Three duckweed genotypes analysed in the project were GP23 (S. polyrhiza), CC (S. polyrhiza), GPL7 (L. minor).
Replicate file outputs are labelled with relevant genotypes codes

Description of files:

Genome_window_filtering.R in the filtering folder
R script for conducting sliding window analysis on file containing genomic coordinates of heterozygous sites
Outputs from this analysis used in the publication are included in files GPL7_Targets_passed_5hets1kb.txt etc.

MA_power_estimate.R in the power folder
R script for estimating power to detect mutations. Takes in as input a file containing a sample of sites (500k) where we knew we had non-zero power to detect mutations.
Input files used in the analyses are included (need to be unzipped), as GPL7_Hom_Random_sample_500k_1altorless.zip etc. 
Output of script returns the fraction of sites, of the original 500k, where mutation passed our filtering criteria and were detected

plotting.R in the plotting folder
R script for plotting figures in the mansuscript with the necessary data in the same folder

alignment_and_piccard_processing.sh
Bash script showing basic pipeline for alignment and processing of bam files with piccard (adding read group names and marking duplicate reads)
