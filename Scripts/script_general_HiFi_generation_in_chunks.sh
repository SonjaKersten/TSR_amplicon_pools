# USAGE:  # ./script_general_HiFi_generation_in_chunks.sh <input_file> <min_length> <max_length> <min_passes> <accuracy> <chunk> <cores> <prefix>
# EXAMPLE # ./script_general_HiFi_generation_in_chunks.sh <INPUT_SUBREADS_BAM_FILE> 500 50000 3 0.999 1/32 4 ACC_Agris42BASF_1
# EXAMPLE # ...
# EXAMPLE # ./script_general_HiFi_generation_in_chunks.sh <INPUT_SUBREADS_BAM_FILE> 500 50000 3 0.999 32/32 4 ACC_Agris42BASF_1

# Parse parameteres
input_file=$1
min_length=$2
max_length=$3
min_passes=$4
accuracy=$5
chunk=$6
cores=$7
prefix=$8

# Declare other variables
WORKTMP=$PWD

Q=q"$(printf "%.0f\n" $(echo "-10*(l(1-$accuracy)/l(10))" | bc -l))"
outputTMP=$WORKTMP/output_ccs_$Q

#min_passes=3
i_chunk=$(echo "${chunk}" | cut -d'/' -f1)

# Create necessary directories
cd $WORKTMP
mkdir -p $outputTMP

# Activate virtual environment
source activate pbbioconda_SMRTlinkv9.0

# Start
echo ""
echo "Start script"
date

# Generate circular consensus sequences (CCS) from subreads in n chunks, into a directory of your choice:
echo "Generating consensus of chunk $chunk ..."
ccs --min-passes $min_passes --min-length $min_length --max-length $max_length --min-rq $accuracy --chunk $chunk -j $cores --report-file $outputTMP/$prefix.$Q.ccs_report.chunk$i_chunk.txt $input_file $outputTMP/$prefix.$Q.CCS.chunk$i_chunk.bam

conda deactivate

# End
date
echo "End script"
echo ""
