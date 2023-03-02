# achilles
### Script for analysis of achilles tendon single cell data  

This script follows the first two parts of the scflow pipeline.  

1.  scflow main quantnuclei  
This script performs fastqc analysis, maps the reads to the genome using kallisto, and generates a count matrix  

2. scflow seurat qc-1  
This script creates a seurat object and generates QC metrics  

Filter-achilles is based on the filter-2 workflow of the scflow pipeline but has been customised specifically for the analysis of the following achilles samples.  

MSK0785  
MSK1250  
MSK1284  
MSK1556  

Each of these samples has a section from enthesis (Enth), midbody (MB) and myotendinous junction (MTJ)  

MSK0785 also has a sample of muscle.  

The patient identifiers are base on the OMB ethics number.  

The next step is to run the Cluster-achilles.Rmd script for dimensionality reduction and clustering.  
