# USAGE:  # ./script_Figure2_multiple_alignment_AND_tree.sh <POP>
# EXAMPLE # ./script_Figure2_multiple_alignment_AND_tree.sh BE01585

# Parse parameteres
POP=$1

# Create necessary directories
WORKDIR=$PWD
output=$WORKDIR/output_multiple_alignment_BASF_pool_indv

cd $WORKDIR

# Start
echo ""
echo "START script"
date

# Activate virtual environment
source activate mafft

mafft --thread 10 --threadtb 10 --threadit 10 --reorder --maxiterate 1000 --retree 1 --genafpair $output/"$POP"_pool_indv_v2_combined.fasta > $output/"$POP"_multiple_alignment_pool_indv.fasta

conda deactivate

# Transform Fastas into Nexus
echo "Transform Fastas into Nexus"
source activate pgdspider_v2.1.1.5

PGDSpider2-cli -inputfile $output/"$POP"_multiple_alignment_pool_indv.fasta -inputformat FASTA -outputfile $output/"$POP"_multiple_alignment_pool_indv.nex -outputformat NEXUS -spid $output/Multiple_alignment.spid

conda deactivate

# Generate RAXML tree
echo "Generate RAXML tree"

source activate RAXML-NG

raxml-ng --all --msa $output/"$POP"_multiple_alignment_pool_indv.fasta --model GTR+G --seed 9 --bs-trees 1000 --threads 1 --bs-metric fbp,tbe

conda deactivate

# Generate metadata file
echo "Generate metadata file"

grep ">" $output/"$POP"_pool_indv_v2_combined.fasta | sed "s/>//g" > $output/"$POP"_pool_indv_meta.txt

# End
date
echo "END script"
echo ""
