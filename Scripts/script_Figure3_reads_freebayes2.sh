# USAGE:  # ./script_Figure3_reads_freebayes2.sh <REF> <acc> <accuracy>
# EXAMPLE # ./script_Figure3_reads_freebayes2.sh ACCase_001213F.fa 16471_F999 0.999

# Parse parameteres
WORKDIR=$1
REF=$2
acc=$3
accuracy=$4

# Declare other variables
WORKTMP=$PWD

ref=$(echo "${REF}" | rev | cut -d'/' -f1 | cut -c 4- | rev)
Q=q"$(printf "%.0f\n" $(echo "-10*(l(1-$accuracy)/l(10))" | bc -l))"

outputTMP=$WORKTMP/output_pbaa_"$ref"

# Make directories

mkdir $outputTMP

# Required software
TABIX=<PATH_TO_TABIX>

# Start pipeline
echo ""
date

## Variant calling
echo "Variant calling with freebayes"

source activate freebayes_v1.3.2 

freebayes -f $REF -r 001213F:362801-376000 --min-mapping-quality 20 --min-alternate-fraction 0.005 --pooled-continuous $outputTMP/$acc.$Q.$ref.bam > $outputTMP/$acc.$Q."$ref"_variants.vcf

conda deactivate

## Index vcf
echo "Index VCF"

$TABIX/bgzip -c $outputTMP/$acc.$Q."$ref"_variants.vcf > $outputTMP/$acc.$Q."$ref"_variants.vcf.gz
$TABIX/tabix -p vcf $outputTMP/$acc.$Q."$ref"_variants.vcf.gz


echo "DONE!"
date
echo ""

