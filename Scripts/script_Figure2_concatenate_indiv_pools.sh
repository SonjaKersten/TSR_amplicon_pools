# USAGE:  # ./script_concatenate_indiv_pools.sh
# example # ./script_concatenate_indiv_pools.sh


## Directories
pools_dir=output_pbaa_ACCase_001213F_BASF
indiv_dir=output_pbaa_ACCase_bait_q20
output=output_multiple_alignment_BASF_pool_indv

# start
echo ""
echo "start script"
date

##1
POP=UK06481
cat $pools_dir/$POP.q30.passed_clusters.fasta $indiv_dir/UK06481_08.ACCase.h1.fasta $indiv_dir/UK06481_04.ACCase.h1.fasta $indiv_dir/UK06481_18.ACCase.h1.fasta $indiv_dir/UK06481_03.ACCase.h2.fasta $indiv_dir/UK06481_02.ACCase.h1.fasta $indiv_dir/UK06481_01.ACCase.h1.fasta $indiv_dir/UK06481_21.ACCase.h1.fasta $indiv_dir/UK06481_08.ACCase.h2.fasta $indiv_dir/UK06481_07.ACCase.h2.fasta $indiv_dir/UK06481_06.ACCase.h2.fasta $indiv_dir/UK06481_12.ACCase.h2.fasta $indiv_dir/UK06481_10.ACCase.h2.fasta $indiv_dir/UK06481_16.ACCase.h2.fasta $indiv_dir/UK06481_03.ACCase.h1.fasta $indiv_dir/UK06481_01.ACCase.h2.fasta $indiv_dir/UK06481_13.ACCase.h1.fasta $indiv_dir/UK06481_15.ACCase.h2.fasta $indiv_dir/UK06481_20.ACCase.h1.fasta $indiv_dir/UK06481_05.ACCase.h2.fasta > $output/"$POP"_pool_indv_v2_combined.fasta

##2
POP=DE01580
cat $pools_dir/$POP.q30.passed_clusters.fasta $indiv_dir/DE01580_03.ACCase.h2.fasta $indiv_dir/DE01580_09.ACCase.h2.fasta $indiv_dir/DE01580_20.ACCase.h1.fasta $indiv_dir/DE01580_07.ACCase.h2.fasta $indiv_dir/DE01580_08.ACCase.h1.fasta $indiv_dir/DE01580_15.ACCase.h1.fasta $indiv_dir/DE01580_06.ACCase.h1.fasta $indiv_dir/DE01580_01.ACCase.h1.fasta $indiv_dir/DE01580_05.ACCase.h1.fasta $indiv_dir/DE01580_16.ACCase.h2.fasta $indiv_dir/DE01580_13.ACCase.h2.fasta $indiv_dir/DE01580_11.ACCase.h1.fasta $indiv_dir/DE01580_02.ACCase.h1.fasta $indiv_dir/DE01580_03.ACCase.h1.fasta $indiv_dir/DE01580_02.ACCase.h2.fasta $indiv_dir/DE01580_10.ACCase.h2.fasta $indiv_dir/DE01580_24.ACCase.h1.fasta $indiv_dir/DE01580_06.ACCase.h2.fasta > $output/"$POP"_pool_indv_v2_combined.fasta

##3
POP=DE01467
cat $pools_dir/$POP.q30.passed_clusters.fasta $indiv_dir/DE01467_03.ACCase.h2.fasta $indiv_dir/DE01467_07.ACCase.h1.fasta $indiv_dir/DE01467_05.ACCase.h2.fasta $indiv_dir/DE01467_01.ACCase.h1.fasta $indiv_dir/DE01467_24.ACCase.h2.fasta $indiv_dir/DE01467_06.ACCase.h2.fasta $indiv_dir/DE01467_15.ACCase.h1.fasta $indiv_dir/DE01467_04.ACCase.h2.fasta $indiv_dir/DE01467_01.ACCase.h2.fasta $indiv_dir/DE01467_06.ACCase.h1.fasta $indiv_dir/DE01467_16.ACCase.h1.fasta $indiv_dir/DE01467_03.ACCase.h1.fasta $indiv_dir/DE01467_02.ACCase.h1.fasta $indiv_dir/DE01467_02.ACCase.h2.fasta $indiv_dir/DE01467_05.ACCase.h1.fasta $indiv_dir/DE01467_08.ACCase.h1.fasta > $output/"$POP"_pool_indv_v2_combined.fasta

##4
POP=FR01434
cat $pools_dir/$POP.q30.passed_clusters.fasta $indiv_dir/FR01434_12.ACCase.h2.fasta $indiv_dir/FR01434_02.ACCase.h2.fasta $indiv_dir/FR01434_21.ACCase.h2.fasta $indiv_dir/FR01434_10.ACCase.h1.fasta $indiv_dir/FR01434_24.ACCase.h1.fasta $indiv_dir/FR01434_05.ACCase.h2.fasta $indiv_dir/FR01434_06.ACCase.h1.fasta $indiv_dir/FR01434_19.ACCase.h1.fasta $indiv_dir/FR01434_03.ACCase.h2.fasta $indiv_dir/FR01434_16.ACCase.h2.fasta $indiv_dir/FR01434_11.ACCase.h2.fasta $indiv_dir/FR01434_19.ACCase.h2.fasta $indiv_dir/FR01434_13.ACCase.h1.fasta $indiv_dir/FR01434_07.ACCase.h2.fasta $indiv_dir/FR01434_12.ACCase.h1.fasta $indiv_dir/FR01434_01.ACCase.h1.fasta $indiv_dir/FR01434_03.ACCase.h1.fasta $indiv_dir/FR01434_02.ACCase.h1.fasta $indiv_dir/FR01434_22.ACCase.h2.fasta $indiv_dir/FR01434_14.ACCase.h1.fasta $indiv_dir/FR01434_01.ACCase.h2.fasta > $output/"$POP"_pool_indv_v2_combined.fasta

##5
POP=FR01729
cat $pools_dir/$POP.q30.passed_clusters.fasta $indiv_dir/FR01729_08.ACCase.h1.fasta $indiv_dir/FR01729_17.ACCase.h2.fasta $indiv_dir/FR01729_04.ACCase.h2.fasta $indiv_dir/FR01729_20.ACCase.h1.fasta $indiv_dir/FR01729_05.ACCase.h2.fasta $indiv_dir/FR01729_07.ACCase.h1.fasta $indiv_dir/FR01729_06.ACCase.h2.fasta $indiv_dir/FR01729_14.ACCase.h2.fasta $indiv_dir/FR01729_05.ACCase.h1.fasta $indiv_dir/FR01729_04.ACCase.h1.fasta $indiv_dir/FR01729_12.ACCase.h1.fasta $indiv_dir/FR01729_13.ACCase.h1.fasta $indiv_dir/FR01729_07.ACCase.h2.fasta $indiv_dir/FR01729_15.ACCase.h2.fasta $indiv_dir/FR01729_01.ACCase.h2.fasta $indiv_dir/FR01729_16.ACCase.h1.fasta $indiv_dir/FR01729_11.ACCase.h2.fasta $indiv_dir/FR01729_02.ACCase.h1.fasta $indiv_dir/FR01729_15.ACCase.h1.fasta $indiv_dir/FR01729_23.ACCase.h1.fasta $indiv_dir/FR01729_19.ACCase.h1.fasta $indiv_dir/FR01729_11.ACCase.h1.fasta $indiv_dir/FR01729_09.ACCase.h1.fasta $indiv_dir/FR01729_01.ACCase.h1.fasta > $output/"$POP"_pool_indv_v2_combined.fasta

##6
POP=BE01585
cat $pools_dir/$POP.q30.passed_clusters.fasta $indiv_dir/BE01585_01.ACCase.h1.fasta $indiv_dir/BE01585_10.ACCase.h1.fasta $indiv_dir/BE01585_24.ACCase.h2.fasta $indiv_dir/BE01585_06.ACCase.h1.fasta $indiv_dir/BE01585_08.ACCase.h1.fasta $indiv_dir/BE01585_24.ACCase.h1.fasta $indiv_dir/BE01585_20.ACCase.h1.fasta $indiv_dir/BE01585_02.ACCase.h1.fasta $indiv_dir/BE01585_10.ACCase.h2.fasta $indiv_dir/BE01585_19.ACCase.h1.fasta $indiv_dir/BE01585_02.ACCase.h2.fasta $indiv_dir/BE01585_12.ACCase.h1.fasta $indiv_dir/BE01585_23.ACCase.h2.fasta $indiv_dir/BE01585_18.ACCase.h2.fasta $indiv_dir/BE01585_03.ACCase.h1.fasta > $output/"$POP"_pool_indv_v2_combined.fasta

##7
POP=FR03200
cat $pools_dir/$POP.q30.passed_clusters.fasta $indiv_dir/FR03200_03.ACCase.h1.fasta $indiv_dir/FR03200_11.ACCase.h1.fasta $indiv_dir/FR03200_01.ACCase.h1.fasta $indiv_dir/FR03200_09.ACCase.h1.fasta $indiv_dir/FR03200_01.ACCase.h2.fasta $indiv_dir/FR03200_16.ACCase.h1.fasta $indiv_dir/FR03200_17.ACCase.h2.fasta $indiv_dir/FR03200_02.ACCase.h2.fasta $indiv_dir/FR03200_12.ACCase.h2.fasta $indiv_dir/FR03200_16.ACCase.h2.fasta $indiv_dir/FR03200_15.ACCase.h1.fasta > $output/"$POP"_pool_indv_v2_combined.fasta

##8
POP=FR07250
cat $pools_dir/$POP.q30.passed_clusters.fasta $indiv_dir/FR07250_12.ACCase.h1.fasta $indiv_dir/FR07250_23.ACCase.h2.fasta $indiv_dir/FR07250_20.ACCase.h2.fasta $indiv_dir/FR07250_07.ACCase.h2.fasta $indiv_dir/FR07250_04.ACCase.h2.fasta $indiv_dir/FR07250_16.ACCase.h2.fasta $indiv_dir/FR07250_01.ACCase.h2.fasta $indiv_dir/FR07250_22.ACCase.h2.fasta $indiv_dir/FR07250_05.ACCase.h2.fasta $indiv_dir/FR07250_05.ACCase.h1.fasta $indiv_dir/FR07250_09.ACCase.h2.fasta $indiv_dir/FR07250_11.ACCase.h2.fasta $indiv_dir/FR07250_21.ACCase.h1.fasta $indiv_dir/FR07250_01.ACCase.h1.fasta $indiv_dir/FR07250_15.ACCase.h2.fasta $indiv_dir/FR07250_16.ACCase.h1.fasta $indiv_dir/FR07250_08.ACCase.h1.fasta $indiv_dir/FR07250_15.ACCase.h1.fasta > $output/"$POP"_pool_indv_v2_combined.fasta


##9
POP=NL01505
cat $pools_dir/$POP.q30.passed_clusters.fasta $indiv_dir/NL01505_22.ACCase.h1.fasta $indiv_dir/NL01505_17.ACCase.h1.fasta $indiv_dir/NL01505_11.ACCase.h1.fasta $indiv_dir/NL01505_19.ACCase.h1.fasta $indiv_dir/NL01505_22.ACCase.h2.fasta $indiv_dir/NL01505_04.ACCase.h2.fasta $indiv_dir/NL01505_21.ACCase.h2.fasta $indiv_dir/NL01505_07.ACCase.h1.fasta $indiv_dir/NL01505_10.ACCase.h1.fasta $indiv_dir/NL01505_03.ACCase.h1.fasta $indiv_dir/NL01505_06.ACCase.h1.fasta $indiv_dir/NL01505_12.ACCase.h1.fasta $indiv_dir/NL01505_13.ACCase.h1.fasta $indiv_dir/NL01505_01.ACCase.h2.fasta $indiv_dir/NL01505_09.ACCase.h1.fasta $indiv_dir/NL01505_02.ACCase.h1.fasta $indiv_dir/NL01505_08.ACCase.h1.fasta $indiv_dir/NL01505_05.ACCase.h1.fasta $indiv_dir/NL01505_03.ACCase.h2.fasta $indiv_dir/NL01505_01.ACCase.h1.fasta $indiv_dir/NL01505_04.ACCase.h1.fasta $indiv_dir/NL01505_07.ACCase.h2.fasta > $output/"$POP"_pool_indv_v2_combined.fasta



# End
date
echo "End script"
echo ""



