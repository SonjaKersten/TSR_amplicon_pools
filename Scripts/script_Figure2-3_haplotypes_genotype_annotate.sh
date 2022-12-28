# USAGE:  # ./script_Figure2-3_haplotypes_genotype_annotate.sh <REF> <PREFIX>
# EXAMPLE # ./script_Figure2-3_haplotypes_genotype_annotate.sh ACCase_001213F.fa Figure2_pools
# EXAMPLE # ./script_Figure2-3_haplotypes_genotype_annotate.sh ACCase_001213F.fa Figure3_pools

# Parse parameteres
REF=$1
PREFIX=$2

# Declare other variables
ref=$(echo "${REF}" | rev | cut -d'/' -f1 | cut -c 4- | rev)

input=$WORKDIR/output_mapping
output=$WORKDIR/output_mapping

# Required software
GATK4=<PATH_TO_GATK_v4.1.3.0>
SnpEff=<PATH_TO_snpEff.jar>

# Go to directory
cd $output

# Start
echo ""
echo "START script"
date

### Joint Genotyping with GATK ###
echo "Generating sample hap1 map of g.vcf files..."
ls $output/*.gatk.g.vcf.gz > $output/gvcfs_$ref.sample_map_TEMP

# Remove previous .sample_map, if existing 
rm $output/gvcfs_$ref.sample_map
while IFS= read -r line; do
	sample="$(echo "${line}" | rev | cut -d'/' -f1 | cut -c 30- | rev)"
	echo -e "$sample\t$line" >> $output/gvcfs_$ref.sample_map
done <  $output/gvcfs_$ref.sample_map_TEMP
rm $output/gvcfs_$ref.sample_map_TEMP

echo "Removing previous database"
rm -rf mydatabase

echo "Creating new GDBI..."
$GATK4 --java-options '-Xmx8G -Xms8G' GenomicsDBImport \
	-R $REF -L `grep ">" $REF | sed 's/>//g'` \
	--sample-name-map $output/gvcfs_$ref.sample_map \
	--genomicsdb-workspace-path mydatabase

echo "Joint genotyping..."
$GATK4 --java-options '-Xmx8G -Xms8G' GenotypeGVCFs \
	-R $REF \
	-V gendb://mydatabase \
	-O $output/$PREFIX.$ref.GVCF.vcf.gz

### Annotation with SnpEff ###
echo "Annotating variants..."
java -Xmx4g -jar $SnpEff $ref $output/$PREFIX.$ref.GVCF.vcf.gz > $output/$PREFIX.$ref.GVCF.ann.vcf

# End
date
echo "END script"
echo ""
