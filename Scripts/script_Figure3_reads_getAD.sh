#!/bin/bash
##USAGE:  # ./script_Figure3_reads_getAD.sh <REF>
# EXAMPLE # ./script_Figure3_reads_getAD.sh ACCase_001213F.fa 

# Parse parameteres
REF=$1

# Declare other variables
WORKTMP=$PWD

ref=$(echo "${REF}" | rev | cut -d'/' -f1 | cut -c 4- | rev)

outputTMP=$WORKTMP/output_classical_mapping_"$ref"

# Required software
GATK4=<PATH_TO_GATK-V4.1.3.0>
bcftools=<PATH_TO_BCFTOOLS_BIN>
TABIX=<PATH_TO_TABIX>

## Split each multiallelic position into multiple lines to make it biallelic
echo "Split each multiallelic position into multiple lines"

$bcftools norm -m -any -Oz $outputTMP/All_ACC_Agris42.vcf.gz > $outputTMP/All_ACC_split_multiallelic.vcf.gz

## Remove GL field to prevent and error reported by GATK
echo "Remove GL field"

$bcftools annotate -x 'FORMAT/GL' -Oz $outputTMP/All_ACC_split_multiallelic.vcf.gz > $outputTMP/All_ACC_removedGLfield.vcf.gz

## Index it
echo "Indexing"

$TABIX/tabix -p vcf $outputTMP/All_ACC_removedGLfield.vcf.gz

## Producing text file to load into R
echo "Producing text file"

$GATK4 --java-options -Xmx4G VariantsToTable \
	-V $outputTMP/All_ACC_removedGLfield.vcf.gz \
	-F CHROM -F POS -F REF -F ALT -GF DP -GF AD \
	-O $outputTMP/All_ACC_AGRIS42_variants.txt

echo "DONE!"
date
echo ""
