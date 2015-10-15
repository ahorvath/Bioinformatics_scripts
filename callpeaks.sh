if [ "$#" -ne 2 ]; then
        echo "USAGE: sh $0 <BAMFILE> <GENOME>"
        exit -1
fi
# input gzipped fastq file
# an example can be downloaded from 
# bam file
BAMFILE=$1

# sample of name gained from bam file
SAMPLE=`basename ${BAMFILE} .bam`
# number of cores to be used
LOGDIR=logs
GENOME=$2
mkdir -p {${SAMPLE}/peaks/${SAMPLE},${LOGDIR}}

# making tag directory with HOMER for peak calling
echo -e "Making tag directory"
makeTagDirectory ${SAMPLE}/homer/${SAMPLE} ${BAMFILE} -removeSpikes 10000 5 -tbp 1 > ${LOGDIR}/${SAMPLE}-tagdir.log 2> ${LOGDIR}/${SAMPLE}-tagdir.err

# calling peaks using HOMER findPeaks 
echo -e "Calling peaks using findPeaks"
findPeaks ${SAMPLE}/homer/${SAMPLE} -o ${SAMPLE}_homerpeaks.pos > ${LOGDIR}/${SAMPLE}-findPeaks.log 2> ${LOGDIR}/${SAMPLE}-findPeaks.err

# convert pos file to bed
pos2bed.pl ${SAMPLE}_homerpeaks.pos -bed
mv ${SAMPLE}_homerpeaks.pos ${SAMPLE}_homerpeaks.bed ${SAMPLE}/peaks/${SAMPLE}

# de novo motif analysis

# window size for motif finding
SIZE=300
# preferred lengths of motives
LENGTH="10,12,14,16" 
echo -e "Find de novo motives"
mkdir -p motifResults_${LENGTH}/${SAMPLE}_motif_${GENOME}_s${SIZE}/logs;                 
findMotifsGenome.pl ${file} ${GENOME} motifResults_${LENGTH}/${SAMPLE}_motif_${GENOME}_s${SIZE} -len ${LENGTH} -p 12 -dumpFasta -bits -preparse -homer2 -size ${SIZE} > motifResults_${LENGTH}/${SAMPLE}_motif_${GENOME}_s${SIZE}/logs/${SAMPLE}.log 2> motifResults_${LENGTH}/${SAMPLE}_motif_${GENOME}_s${SIZE}/logs/${SAMPLE}.err;         
