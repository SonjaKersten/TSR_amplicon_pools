# USAGE:  # ./script_general_HiFi_merge_demultiplex.sh <GUESS> <BARCODE> <prefix> <GENE> <accuracy> <min> <MAX>
# EXAMPLE # ./script_general_HiFi_merge_demultiplex.sh 80 ACCase.barcodeset_24F_16R_bc1066-bc1080.fasta ACC_Agris42BASF_1 ACCase_pool 0.999 50 0 

# Parse parameteres
GUESS=$1
BARCODE=$2
prefix=$3
GENE=$4
accuracy=$5
min=$6
MAX=$7

# Declare other variables
WORKTMP=$PWD

Q=q"$(printf "%.0f\n" $(echo "-10*(l(1-$accuracy)/l(10))" | bc -l))"

outccsTMP=$WORKTMP/output_ccs_$Q
outlimaTMP=$WORKTMP/output_lima
outputTMP=$WORKTMP/output_fastq


# Create necessary directories
cd $WORKTMP
mkdir -p $outccsTMP
mkdir -p $outlimaTMP
mkdir -p $outputTMP

# Activate virtual environment
source activate pbbioconda_SMRTlinkv9.0

# Start
echo ""
echo "Start script"
date

## Merge BAM files (be aware, it could lead to overwritting of an empty file when re-ran)
echo "Merging chunks for $prefix ..."
pbmerge -o $outccsTMP/$prefix.$Q.CCS.bam $outccsTMP/$prefix.$Q.CCS.chunk*.bam

# Demultiplexing with lima
echo "Demultiplexing with lima"
lima --ccs --different \
	--peek-guess --guess $GUESS \
	--split-bam-named \
	--min-ref-span 0.875 --min-scoring-regions 2 \
	--min-length $min --max-input-length $MAX \
	$outccsTMP/$prefix.$Q.CCS.bam $WORKDIR/$BARCODE $outlimaTMP/$prefix.$Q.$min-$MAX.bam

# Remove unneccesary files
rm $outccsTMP/$prefix.$Q.CCS.chunk*.bam*

# Converting BAM to FASTQ, and modify samples names
while IFS= read -r line; do
	acc=$(echo "${line}" | cut -f2)
	BarcodePair=$(echo "${line}" | cut -f1)
	rep=rep"$(echo "${line}" | cut -f3)"

	if [ -f "$outlimaTMP/$prefix.$Q.$min-$MAX.$BarcodePair.bam" ]; then
		echo "Converting BAM to FASTQ for sample $acc ..."
		bam2fastq -o $outputTMP/$acc.$rep.$GENE.$Q $outlimaTMP/$prefix.$Q.$min-$MAX.$BarcodePair.bam

	else
		echo "Empty file $acc ..."
		touch $outputTMP/$acc.$rep.$GENE.$Q.fastq.gz
	fi

done < $WORKTMP/names_"$prefix".txt

# Remove unneccesary files
rm $outlimaTMP/$prefix.$Q.*.bam*
rm $outlimaTMP/$prefix.$Q.*.xml

conda deactivate

# End
date
echo "End script"
echo ""
