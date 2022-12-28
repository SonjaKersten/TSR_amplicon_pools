#!/bin/bash
##USAGE:  # ./script_Figure3_reads_mergeVCFs.sh <REF> <acc> <GENE> <accuracy>
# EXAMPLE # ./script_Figure3_reads_mergeVCFs.sh ACCase_001213F.fa ACCase_pool 0.999 

# Parse parameteres
REF=$1
GENE=$2
accuracy=$3

# Declare other variables
WORKDIR=$PWD

ref=$(echo "${REF}" | rev | cut -d'/' -f1 | cut -c 4- | rev)
Q=q"$(printf "%.0f\n" $(echo "-10*(l(1-$accuracy)/l(10))" | bc -l))"

output=$WORKDIR/output_classical_mapping_"$ref"

mkdir $output

# Required software
GATK4=<PATH_TO_GATK_v4.1.3.0>
TABIX=<PATH_TO_TABIX>
bcftools=<PATH_TO_BCFTOOLS>

## Generate input list for merging
echo "Generate .vcf input list"

# Remove sample list if already exists
rm $output/samplelist_vcf.txt

#LOOP to generate sample list
while IFS= read -r line; do
	acc=$(echo "${line}" | cut -f1)
	ls $outputTMP/$acc.$Q."$ref"_variants.vcf.gz >> $outputTMP/samplelist_vcf.txt
done < $WORKDIR/Accessions_names_ACC_Agris42.txt

## Merge all bamfiles from bam file list
echo "Merge .vcf files"

$bcftools merge --file-list $outputTMP/samplelist_vcf.txt -o $output/All_ACC_Agris42.vcf

# Index VCF
echo "Index VCF"

$TABIX/bgzip -c $output/All_ACC_Agris42.vcf > $output/All_ACC_Agris42.vcf.gz
$TABIX/tabix -p vcf $output/All_ACC_Agris42.vcf.gz


echo "DONE!"
date
echo ""


