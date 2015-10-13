#!/bin/bash

if [ "$#" -ne 4 ]; then
	echo "USAGE: $0 <PEAK> <MOTIF> <SIZE> <GENOME>"
	exit -1
fi

peak=$1
motif=$2
size=$3
genome=$4
sample=`basename $peak .bed`_`basename $motif .motif`_${genome}s_${size}_remaped
mkdir -p ${sample}
annotatePeaks.pl $peak ${genome} -size $size -m $motif -mbed ${sample}/${sample}_mbed.bed | tee ${sample}/${sample}_w_motives.txt | awk -F"\t" '$22!=""{OFS="\t"; print $2,$3,$4,$22,$5,$1}' 2> /dev/null > ${sample}/${sample}_w_motives.bed 2> ${sample}/${sample}.log
totalpeak=`wc -l $peak | cut -d" " -f1`;
motivespeak=`wc -l ${sample}/${sample}_w_motives.bed | cut -d" " -f1`;
rate=`echo "scale=4;$motivespeak/$totalpeak" | bc`;
echo -e "$totalpeak\t$motivespeak\t$rate";
