# USAGE:            # ./script_Figure2-3_haplotypes_minimap2.sh <REF> <SAMPLE>
# EXAMPLE Figure2   # ./script_Figure2-3_haplotypes_minimap2.sh ACCase_001213F.fa BE01585.cluster-26_76_0.00475238
# EXAMPLE Figure3   # ./script_Figure2-3_haplotypes_minimap2.sh ACCase_001213F.fa 16471_F999_c0_0.217252_11513

# Parse parameteres
REF=$1
SAMPLE=$2

# Declare other variables
ref=$(echo "${REF}" | rev | cut -d'/' -f1 | cut -c 4- | rev)

# BASF
WORKDIR=$PWD
input=$WORKDIR/output_fastas_"$ref"
output=$WORKDIR/output_mapping

# Create necessary directories
cd $WORKDIR
mkdir $output

# Activate virtual environment
source activate minimap2_v2.15
PICARD=<PATH_TO_picard.jar>
FASTA_TO_FASTQ=<PATH_TO_Fasta_to_Fastq>

# Start
echo ""
echo "Start script"
date

echo "Converting fasta to fastq files, in which all bases are assigned quality I"
perl $FASTA_TO_FASTQ/fasta_to_fastq.pl $input/$SAMPLE.fasta > $output/$SAMPLE.ACCase.fq

echo "Mapping with minimap2... -Phase1"
# Alignment to a given REFERENCE with minimap2 - Phase 1
minimap2 -t 1 -ax asm20 $REF $output/$SAMPLE.ACCase.fq > $output/$SAMPLE.$ref.minimap2.sam
samtools view -bh -t $REF.fai -o $output/$SAMPLE.$ref.minimap2.bam $output/$SAMPLE.$ref.minimap2.sam
samtools sort -o $output/$SAMPLE.$ref.minimap2.sort.bam $output/$SAMPLE.$ref.minimap2.bam


echo "Modifying @RG group... -Phase1"
# Modification of Read Group –@RG– required to avoid issues with DeepVariants later on 
java -jar -Xmx4g $PICARD AddOrReplaceReadGroups I=$output/$SAMPLE.$ref.minimap2.sort.bam O=$output/$SAMPLE.$ref.minimap2.bam RGID=$SAMPLE RGLB=ccs RGPL=pacbio RGPU=unit1 RGSM=$SAMPLE

samtools index $output/$SAMPLE.$ref.minimap2.bam

rm $output/$SAMPLE.$ref.minimap2.sam
rm $output/$SAMPLE.$ref.minimap2.sort.bam

conda deactivate 


#END

date
echo "End script"
echo ""
