# PacBio TSR amplicon pools


ACCase_bait.fa is the pseudo reference required for cluster generation of the [pbaa](https://github.com/PacificBiosciences/pbAA) software.


script_cluster2fasta.sh extracts the consensus sequences generated in the clustering step, including meta information of each haplotype, and re-orients them –when necessary– in the forward orientation.


The simulation runs were performed with the software [SLiM](https://messerlab.org/slim).
The following scripts for the two different dominant coefficients were used:
- TSR_lasting_0.25.slim 
- TSR_lasting_0.5.slim
- with the param_file.txt containing all input parameter combination used.


These are the concatenated output files (Folder: SLiM_output_files.zip) of all 400 runs per parameter combination:
- All_runs_42000_0.5.txt
- All_runs_42000_0.25.txt


The R markdown file Slim_simulations_TSR_lasting_0.5.Rmd contains the downstream dataframe processing and plotting functions (identical for both output files).
