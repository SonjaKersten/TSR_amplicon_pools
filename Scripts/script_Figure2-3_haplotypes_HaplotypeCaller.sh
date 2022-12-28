# USAGE:          # ./script_Figure2-3_haplotypes_HaplotypeCaller.sh <REF> <SAMPLE>
# EXAMPLE Figure2 # ./script_Figure2-3_haplotypes_HaplotypeCaller.sh ACCase_001213F.fa BE01585.cluster-26_76_0.00475238
# EXAMPLE Figure3 # ./script_Figure2-3_haplotypes_HaplotypeCaller.sh ACCase_001213F.fa 16471_F999_c0_0.217252_11513

# Parse parameteres
REF=$1
SAMPLE=$2

# Declare other variables
ref=$(echo "${REF}" | rev | cut -d'/' -f1 | cut -c 4- | rev)

WORKDIR=$PWD
input=$WORKDIR/output_mapping
output=$WORKDIR/output_mapping

# Required software
GATK4=<PATH_TO_GATK_v4.1.3.0>

# Create necessary directories
cd $WORKDIR

# Start
echo ""
echo "START script"
date

### Variant calling with GATK ###
echo "Variant calling – GATK..."

##HaplotypeCaller - Phase 1
$GATK4 --java-options -Xmx8G HaplotypeCaller \
	-R $REF \
	--min-pruning 0 \
	-I $input/$SAMPLE.ACCase_001213F.minimap2.bam \
	-O $output/$SAMPLE.ACCase_001213F.gatk.g.vcf.gz \
	-ERC GVCF
 
# End
date
echo "END script"
echo ""
