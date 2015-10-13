## Bioinformatics_scripts ##


## Authors ##

Attila Horváh, PhD Student, bioinformatician
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

## remap_motif.sh ##

## Usage ##

sh remap_motif.sh <PEAK> <MOTIF> <SIZE> <GENOME>

## Example ##

sh remap_motif.sh examples/example.bed examples/rxr.motif 200 mm10

## Results ##

 a folder named example_rxr_mm10s_200_remaped containing the following files

example_rxr_mm10s_200_remaped_mbed.bed  - containing genomic locations of the motives found (can be opened with https://www.broadinstitute.org/igv/)

example_rxr_mm10s_200_remaped_w_motives.bed  - containing genomic locations of the input peaks and annotated with he motif files found (can be opened with https://www.broadinstitute.org/igv/)

example_rxr_mm10s_200_remaped_w_motives.txt  - similar to the previous one but a pos file developed and preferred by Homer (can be opened with e.g. Excel) 

example_rxr_mm10s_200_remaped.log  - log file for debugging

example_rxr_mm10s_200_remaped_w_motives.stat - simple statistics of the motif occurences

