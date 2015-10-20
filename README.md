## Bioinformatics_scripts ##

The following bioinformatics scripts and description was prepared as supplementary information for the manuscript published in Journal of Visualized Experiments (JoVE).

Please cite the following paper:



## TITLE: 
"Prediction and validation of gene regulatory elements activated during retinoic acid induced embryonic stem cell differentiation"



## AUTHORS: 

Zoltan Simandi1,§, Attila Horvath2,§, Gergely Peter Nagy1, Laszlo Nagy1,2,3

1 Sanford-Burnham-Prebys Medical Discovery Institute at Lake Nona, Orlando, FL, 

USA

2 Department of Biochemistry and Molecular Biology, Research Center for Molecular 

Medicine, University of Debrecen, Medical and Health Science Center,  Egyetem ter 

1, Debrecen, Hungary H-4012

3 MTA-DE "Lendulet" Immunogenomics Research Group, 

University of Debrecen, Egyetem ter 1, Debrecen, Hungary H-4012

§ These authors equally contributed to this work



## Dear Visitor!


This site is aiming to share bioinformatics scripts that are part of our workflow for 

ChIP-seq data analysis.

To be able to use them there are prerequisites and bioinformatics background is needed.  Software packages listed below under "Prerequisite" should be installed prior running any of the scripts.

To download the content of this page to your computer please click on the 
"Download ZIP". The downloaded files will include the scripts (perform_alignment.sh, callpeaks.sh, remap_motif.sh) and the output files obtained with the sample scripts during the analysis. 

Some of the data and output files exceed the available size limit. Please find the links 

below to access to those files (eg. raw data in fastq, BWA index file, motif files, etc.).

The "Tutorial" part cover the following steps of the ChIP-seq data analysis:

1. You will find below a link to download an example fastq file (mm_ES_RXR_24h_ATRA.fastq.gz). This can be replaced with your own data.

2. Downloading and extracting the required BWA index file (in our case: Mus_musculus_UCSC_mm10) for the alignment. 

3. Alignment of the example fastq file to mm10 genome (perform_alignment.sh) 

4. Peak calling and de novo motif analysis (callpeaks.sh)

5. Remapping of the selected motif (remap_motif.sh)


## Prerequisites ##
+ BWA [http://bio-bwa.sourceforge.net](http://bio-bwa.sourceforge.net/)
+ SAMtools [http://samtools.sourceforge.net](http://samtools.sourceforge.net/)
+ HOMER [http://homer.salk.edu/homer/introduction/configure.html](http://homer.salk.edu/homer/introduction/configure.html)

## Tutorial ##

1. The example fastq file mm_ES_RXR_24h_ATRA.fastq.gz can be downloaded from 
  [ftp://bioinformatics_scripts:z072yyq@ngsdebftp.med.unideb.hu](ftp://bioinformatics_scripts:z072yyq@ngsdebftp.med.unideb.hu)

2. BWA index files can be found 
  [ftp://igenome:G3nom3s4u@ussd-ftp.illumina.com/Mus_musculus/UCSC/mm10/Mus_musculus_UCSC_mm10.tar.gz](ftp://igenome:G3nom3s4u@ussd-ftp.illumina.com/Mus_musculus/UCSC/mm10/Mus_musculus_UCSC_mm10.tar.gz)

  To extract file: 
  ```
  tar xvfz Mus_musculus_UCSC_mm10.tar.gz
  ```

3. Aligning the example fastq file to mm10 genome
  ```
  sh perform_alignment.sh mm_ES_RXR_24h_ATRA.fastq.gz Mus_musculus/UCSC/mm10/Sequence/BWAIndex/version0.6.0/genome.fa
  ```

  The output files of the alignment step e mm_ES_RXR_24h_ATRA.fastq.gz can be also downloaded from 
  ftp://bioinformatics_scripts:z072yyq@ngsdebftp.med.unideb.hu

4. Calling peaks and finding de novo motives (bam file is produced by the previous script

  Assumed that HOMER mm10 genome is installed, see [http://homer.salk.edu/homer/introduction/configure.html](http://homer.salk.edu/homer/introduction/configure.html))
  ```
  sh callpeaks.sh mm_ES_RXR_24h_ATRA/bam/mm_ES_RXR_24h_ATRA.bam mm10
  ```
5. Finding motif occurences on the peaks found
  ```
  MOTIF=motifResults_10,12,14,16/mm_ES_RXR_24h_ATRA_motif_mm10_s300/homerResults/motif1.motif

  sh remap_motif.sh mm_ES_RXR_24h_ATRA/peaks/mm_ES_RXR_24h_ATRA/mm_ES_RXR_24h_ATRA_homerpeaks.bed ${MOTIF} 200 mm10
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
sh remap_motif.sh <PEAK> <MOTIF> <SIZE> <GENOME>
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

