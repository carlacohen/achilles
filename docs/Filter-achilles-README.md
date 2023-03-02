## achilles filter-2

This script is based on the scflow seurat filter-2 pipeline but can be run independently and has been customised for analysis of achilles data. 

I have taken into account the best practise guide for single cell analysis by Fabian Theis (at January 2023)  
https://www.sc-best-practices.org/  


**Commands**

Run the script (in the scflow conda env)

     nohup Rscript -e "rmarkdown::render('Filter-achilles.Rmd')"

Alternatively the script could be submitted as a job to the cluster using slurm.   

### Filter-achilles.Rmd  

**Inputs:**  

SingleCellExperiment objects generated in qc-1  
Metadata file: Files.dir/metadata.txt  

**Steps:**  
1. Read in two SingleCellExperiment objects from qc-1  
    sce = original unfiltered object  
    sce_empty = object with empty droplets removed    

2. Visualise & remove empty droplets  

3. Remove samples that have very low cell numbers or that have failed earlier QC (multiqc)  

4. Visualise & remove Ambient RNA

5. Visualise & remove Doublets 

6. Perform statistical filtering using MADs  

7.  Visualise how filtering affects the novelty  

8.  Visualise QC metrics on UMAP  

9.  Perform PCA & UMAP on filtered object  

10.  Save the Single Cell Experiment and Seurat Objects as RDS files  
 - sce_empty: empty droplets removed, ambient RNA identified, doublets identified, MADs identified  
 - sce_decontX_filtered: empty droplets removed, ambient RNA removed  
 - sce_doublet_filtered: empty droplets removed, doublets removed  
 - sce_doublet_decontX_filtered: , empty droplets removed, ambient RNA and doublets removed  
 - sce_decontX_doublet_low_filtered: empty droplets removed, ambient RNA and doublets removed, low nCount and nFeature removed  
 - sce_decontX_doublet_discard_filtered: empty droplets removed, ambient RNA and doublets removed, low nCount and nFeature removed, high mitochondrial reads removed  


**Outputs:**

Filter-achilles.Rmd knitted to html  
Filtered SingleCellExperiment and Seurat Object RDS objects saved in RDS_objects.dir  
QC plots saved as .png and .pdf files in Filtered_Figures.dir  

