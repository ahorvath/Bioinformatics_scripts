## Bioinformatics_scripts ##


## Authors ##

Attila Horváth, PhD Student, bioinformatician
Email: horvath.attila@med.unideb.hu

NLab [http://nlab.med.unideb.hu/](http://nlab.med.unideb.hu/)

University of Debrecen-Med. and Health Sci. Centre

Department of Biochemistry and Molecular Biology

Clinical Genomics Centre/ IVDI Building

Nagyerdei krt 98

H-4012 Pf6, Debrecen, Hungary

location: http://g.co/maps/5hm59

phone: +36-52-411717/ext 50231

ResearchGate
[ResearchGate](https://www.researchgate.net/profile/Attila_Horvath9)
[LinkedIn](https://www.linkedin.com/hp/?dnr=oVL_xVLIOvvZ7IVooNyotA0wOPufXI8UAya1)

## License ##

All source code is copyright, under the Artistic-2.0 License.
For more information on Artistic-2.0 License see [http://opensource.org/licenses/Artistic-2.0](http://opensource.org/licenses/Artistic-2.0)

## Prerequisites ##
+ BWA [http://bio-bwa.sourceforge.net](http://bio-bwa.sourceforge.net/)
+ SAMtools [http://samtools.sourceforge.net](http://samtools.sourceforge.net/)
+ HOMER [http://homer.salk.edu/homer/introduction/configure.html](http://homer.salk.edu/homer/introduction/configure.html)

## Tutorial ##

The example fastq file mm_ES_RXR_24h_ATRA.fastq.gz can be downloaded from [here](ftp://bioinformatics_scripts:z072yyq@ngsdebftp.med.unideb.hu)

 BWA index files can be found [ftp://igenome:G3nom3s4u@ussd-ftp.illumina.com/Mus_musculus/UCSC/mm10/Mus_musculus_UCSC_mm10.tar.gz](here)

To extract file: tar xvfz Mus_musculus_UCSC_mm10.tar.gz

 Aligning the example fastq file to mm10 genome
```
sh perform_alignment.sh mm_ES_RXR_24h_ATRA.fastq.gz Mus_musculus/UCSC/mm10/Sequence/BWAIndex/version0.6.0/genome.fa
```
Calling peaks and finding de novo motives (bam file is produced by the previous script

Assumed that HOMER mm10 genome is installed, see [http://homer.salk.edu/homer/introduction/configure.html](http://homer.salk.edu/homer/introduction/configure.html))
```
sh callpeaks.sh mm_ES_RXR_24h_ATRA/bam/mm_ES_RXR_24h_ATRA.bam mm10
```
Finding motif occurences on the peaks found
```
MOTIF=

sh remap_motif.sh mm_ES_RXR_24h_ATRA/peaks/mm_ES_RXR_24h_ATRA_homerpeaks.bed ${MOTIF} 200 mm10
```
## Bash scripts ##

### callpeaks.sh ###

### Usage ###
```
sh callpeaks.sh <BAMFILE> <GENOME>
```
### remap_motif.sh ###

### Usage ###
```
sh remap_motif.sh \<PEAK\> \<MOTIF\> \<SIZE\> \<GENOME\>
```
### Example ###
```
sh remap_motif.sh examples/example.bed examples/rxr.motif 200 mm10
```
### Results ###

a folder named example_rxr_mm10s_200_remaped containing the following files

+ example_rxr_mm10s_200_remaped_mbed.bed  - containing genomic locations of the motives found (can be opened with https://www.broadinstitute.org/igv/)

+ example_rxr_mm10s_200_remaped_w_motives.bed  - containing genomic locations of the input peaks and annotated with he motif files found (can be opened with https://www.broadinstitute.org/igv/)

+ example_rxr_mm10s_200_remaped_w_motives.txt  - similar to the previous one but a pos file developed and preferred by Homer (can be opened with e.g. Excel) 

+ example_rxr_mm10s_200_remaped.log  - a log file for debugging

+ example_rxr_mm10s_200_remaped_w_motives.stat - a simple statistics of the motif occurences

