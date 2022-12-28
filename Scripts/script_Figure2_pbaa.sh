# USAGE:  # ./script_Figure2_pbaa.sh <REF> <acc> <GENE> <accuracy>
# example # ./script_Figure2_pbaa.sh ACCase_001213F.fa BE01585 ACCase_pool 0.999

# parse parameteres
REF=$1
acc=$2
GENE=$3
accuracy=$4

# declare other variables
WORKTMP=$PWD

ref=$(echo "${REF}" | rev | cut -d'/' -f1 | cut -c 4- | rev)
Q=q"$(printf "%.0f\n" $(echo "-10*(l(1-$accuracy)/l(10))" | bc -l))"

inputTMP=$WORKTMP/output_fastq
outputTMP=$WORKTMP/output_pbaa_"$ref"_BASF

# create necessary directories
cd $WORKTMP
mkdir -p $outputTMP

# activate virtual environment
SAMTOOLS=<PATH_TO_SAMTOOLS_BIN>

# start
echo ""
echo "start script"
date

# gunzipping input fastq
rsync -av $inputTMP/"$acc"_*.$GENE.$Q.fastq.gz $outputTMP
sleep 2
gunzip -f $outputTMP/"$acc"_*.$GENE.$Q.fastq.gz
sleep 2

# Concatenating the available FASTQ files 
cat $outputTMP/"$acc"_*.$GENE.$Q.fastq > $outputTMP/$acc.$GENE.$Q.raw.fastq

# Downsample the concatenated files to normalize to the same number of reads
echo "Normalize the concatenated fastq"
source activate fastqtools_v0.8.3

# Batch with 200 samples
fastq-sample -n 16000 -o $outputTMP/$acc.$GENE.$Q $outputTMP/$acc.$GENE.$Q.raw.fastq

conda deactivate


# Indexing fastq files
echo "Indexing fastq files"
$SAMTOOLS faidx $outputTMP/$acc.$GENE.$Q.fastq


# Create list-of-files
ls $outputTMP/$acc.$GENE.$Q.fastq > $outputTMP/$acc.$GENE.$Q.fofn


echo "Clustering with pbAA..."
# clustering
source activate pbaa_v1.0.0_691333c

# Pool with 200 individuals
pbaa cluster \
	ACCase_bait.fa \
	--min-read-qv 30 \
	--max-alignments-per-read 16000 \
	--max-reads-per-guide 16000 \
	--pile-size 50 \
	--min-var-frequency 0.4 \
	--min-cluster-read-count 20 \
	--min-cluster-frequency 0.00125 \
	$outputTMP/$acc.$GENE.$Q.fofn \
	$outputTMP/$acc.$Q.$GENE

# Remove unneccesary files
rm $outputTMP/$acc*.rep*.$GENE.$Q.fastq*
rm $outputTMP/$acc.$GENE.$Q.fofn

conda deactivate


# Mapping with pbmm2
source activate pbbioconda_SMRTlinkv9.0

echo "Mapping with pbmm2..."
# Alignment to a given REFERENCE with pbmm2 (PacBio's wrapper for minimap2)
pbmm2 align $REF $outputTMP/$acc.$GENE.$Q.fastq $outputTMP/$acc.$Q.$ref.bam \
	--preset CCS --sort \
	--rg "@RG\tID:$acc\tSM:$acc"

conda deactivate



# Bam painting with cluster assignment

echo "BAM painting with pbAA..."
source activate pbaa_v1.0.0_691333c
pbaa bampaint \
	$outputTMP/$acc.$Q."$GENE"_read_info.txt \
	$outputTMP/$acc.$Q.$ref.bam \
	$outputTMP/$acc.$Q.$GENE.pbaa_painted.bam

conda deactivate

# End
date
echo "End script"
echo ""



