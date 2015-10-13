#!/bin/bash


#################################################################
#                                                               #
# This simple bash script can find the occurrences of the given #           
# motif under the window defined by the peak summit+-(size/2)   #
# and results a new bed containing the genomic locations of     #
# the motives found, a bed file with the original peaks having  #
# at least one motif (and a similar tsv file with header) and   # 
# a statistics in the log file. The script uses the perl script # 
# annotatePeaks.pl provided by Homer.                           #
#                                                               #
#################################################################     

if [ "$#" -ne 4 ]; then
	echo "USAGE: sh $0 <PEAK> <MOTIF> <SIZE> <GENOME>"
	exit -1
fi
# peak file in which the motif to be found occurences 
peak=$1
# motif file (see http://homer.salk.edu/homer/motif/creatingCustomMotifs.html) 
motif=$2
# window defined by the peak summit+-(size/2)
size=$3
# the genome must be installed by Homer (see http://homer.salk.edu/homer/introduction/install.html)
genome=$4
# the basename of the result files
sample=`basename $peak .bed`_`basename $motif .motif`_${genome}s_${size}_remaped
mkdir -p ${sample}
#  annotatePeaks.pl perl script provided by Homer must be installed (see http://homer.salk.edu/homer/introduction/install.html)
annotatePeaks.pl $peak ${genome} -size $size -m $motif -mbed ${sample}/${sample}_mbed.bed | tee ${sample}/${sample}_w_motives.pos | awk -F"\t" '$22!=""{OFS="\t"; print $2,$3,$4,$22,$5,$1}' 2> /dev/null > ${sample}/${sample}_w_motives.bed 2> ${sample}/${sample}.log
totalpeak=`wc -l $peak | cut -d" " -f1`;
motivespeak=`wc -l ${sample}/${sample}_w_motives.bed | cut -d" " -f1`;
rate=`echo "scale=4;$motivespeak/$totalpeak" | bc`;
echo -e "$totalpeak\t$motivespeak\t$rate" > ${sample}/${sample}_w_motives.stat;

# result 
# a folder named example_rxr_mm10s_200_remaped containing the following files
# example_rxr_mm10s_200_remaped_mbed.bed - containing genomic locations of the motives found (can be opened with https://www.broadinstitute.org/igv/)
# example_rxr_mm10s_200_remaped_w_motives.bed - containing genomic locations of the input peaks and annotated with he motif files found (can be opened with https://www.broadinstitute.org/igv/)
# example_rxr_mm10s_200_remaped_w_motives.txt - similar to the previous one but a pos file developed and preferred by Homer (can be opened with e.g. Excel) 
# example_rxr_mm10s_200_remaped.log - log file for debugging
# example_rxr_mm10s_200_remaped_w_motives.stat - simple statistics of the motif occurences
