# USAGE:  # ./script_Figure2-3_cluster2fasta.sh <acc> <GENE> <accuracy>
# example # ./script_Figure2-3_cluster2fasta.sh 26536_F096 ACCase_pool 0.999

# parse parameteres
acc=$1
GENE=$2
accuracy=$3

# declare other variables
Q=q"$(printf "%.0f\n" $(echo "-10*(l(1-$accuracy)/l(10))" | bc -l))"

WORKTMP=$PWD
inputTMP=$WORKTMP/output_pbaa_"$ref"
outputTMP=$WORKTMP/output_fastas_"$ref"

# create necessary directories

mkdir -p $outputTMP

# Software requirements
SAMTOOLS=<PATH_TO_SAMTOOLS_BIN>

# start
echo ""
echo "start script"
date

# Count number of fasta sequences (NOT number of lines, which are twice as much)
total_seq=`grep -c '^>' $inputTMP/$acc.$Q."$GENE"_passed_cluster_sequences.fasta` 
# Initialize dummy counter
line=1
loops=`seq 1 $total_seq`

# Loops through each input cluster
for i in $loops
do
	next_line=$((line + 1))

	# Print fasta read for a given cluster
	awk "FNR==$line" $inputTMP/$acc.$Q."$GENE"_passed_cluster_sequences.fasta > $outputTMP/$acc.TMP$line.fasta
	awk "FNR==$next_line" $inputTMP/$acc.$Q."$GENE"_passed_cluster_sequences.fasta >> $outputTMP/$acc.TMP$line.fasta

	#Collect metadata from the fasta header
	freq=`grep '^>' $outputTMP/$acc.TMP$line.fasta | sed 's/.*cluster_freq://' | cut -d' ' -f1`
	cluster=`grep '^>' $outputTMP/$acc.TMP$line.fasta | sed 's/.*cluster-//' | cut -d'_' -f1`
	reads=`grep '^>' $outputTMP/$acc.TMP$line.fasta | sed 's/.*ReadCount-//' | cut -d' ' -f1`

	read_name="$acc"_c"$cluster"_"$freq"_"$reads" 
	sed "s/>.*/>$read_name/" $outputTMP/$acc.TMP$line.fasta > $outputTMP/$read_name.fasta  

	rm $outputTMP/$acc.TMP$line.fasta

	# Check whether sequence comes in forward orientation and convert to complementary-reverse if needed
	rc=`grep -c "^GAA" $outputTMP/$read_name.fasta`
	if [ $rc -eq 1 ]
	then
		samtools faidx --reverse-complement --mark-strand no $outputTMP/$read_name.fasta $read_name > $outputTMP/$read_name.fastaTMP
    		mv $outputTMP/$read_name.fastaTMP $outputTMP/$read_name.fasta
	fi

	line=$((line + 2))

done

#Concatenate clusters in a single file
cat $outputTMP/*.fasta > $outputTMP/$acc.$Q.passed_clusters.fasta


date
echo "End script"
echo ""



