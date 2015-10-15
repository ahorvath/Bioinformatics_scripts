if [ "$#" -ne 2 ]; then
        echo "USAGE: sh $0 <FASTQFILE> <GENOME>"
        exit -1
fi
# input gzipped fastq file
# an example can be downloaded from 
# FASTQFILE=mm_ES_siSCR_I7_RXR_ATRA.fastq.gz
FASTQFILE=$1
# MOTIF file (see http://homer.salk.edu/homer/MOTIF/creatingCustomMotifs.html) 

# location of the index files for bwa
# wget ftp://igenome:G3nom3s4u@ussd-ftp.illumina.com/Mus_musculus/UCSC/mm10/Mus_musculus_UCSC_mm10.tar.gz
# tar xvfz Mus_musculus_UCSC_mm10.tar.gz 
#GENOME=Mus_musculus/UCSC/mm10/Sequence/BWAIndex/version0.6.0/genome.fa
GENOME=$2

# sample of name gained fastq
SAMPLE=`basename ${FASTQFILE} .fastq.gz`
# number of cores to be used
PROCNO=11
LOGDIR=logs

# create a folder for the bam and bai files
mkdir -p {${SAMPLE}/bam/,${LOGDIR}}

# Performing aligment 
bwa mem -t ${PROCNO} ${GENOME} ${FASTQFILE} | samtools view -buS -t ${GENOME}.fai - | samtools sort - ${SAMPLE} > ${LOGDIR}/bwa_alignment_${SAMPLE}.log 2> ${LOGDIR}/bwa_alignment_${SAMPLE}.err

# creating index files
samtools index ${SAMPLE}.bam ${SAMPLE}.bai

# moving the results in the bam folder
mv ${SAMPLE}.bam ${SAMPLE}.bai ${SAMPLE}/bam/

# creating alignment statistics 
bamtools stats -in ${SAMPLE}/bam/${SAMPLE}.bam 2>&1 | tee ${SAMPLE}/bam/${SAMPLE}.bamstats
