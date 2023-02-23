## achilles filter-2

This script is based on the scflow seurat filter-2 pipeline but can be run independently and has been customised for analysis of achilles data. 

I have taken into account the best practise guide for single cell analysis by Fabian Theis (at January 2023)  
https://www.sc-best-practices.org/  


**Commands**

Run the script (in the scflow conda env)

     nohup Rscript -e "rmarkdown::render('Filter-achilles.Rmd')"


### Filter-achilles.Rmd

**Inputs:**

SingleCellExperiment objects generated in qc-1
Metadata file: Files.dir/metadata.txt

**Steps:**
1. Read in two SingleCellExperiment object from qc-1 (generated with min.cells = 3 and min.features = 20)
    sce = original unfiltered object
    sce_empty = object with empty droplets removed  

2. Empty droplets  
-  Visualise the library size of empty droplets
- Visualise the distribution of empty droplets by library size and number of features
- Check how many droplets are removed if empty droplets is implemented

3. Remove two samples that have very low cell numbers  
This is samples OMB1284-Ach-MB and OMB1284-Ach-MTJ.  They need to removed from all the lists created so far. 

4.  Ambient RNA
- Create a new object with ambient RNA removed
- Plot the ambient RNA content on the decontX_UMAP

5. Doublets 
- Plot the library size of singlets vs doublets  
- Create new objects wih doublets excluded, and with ambient RNA and doublets excluded.  
- Check how many cells were removed at each step  

6. Statistical filtering using MADs
- Use statistical analysis to identify cells with low numbers of counts and features, and high mitochondrial content (> 3 MADs)  
- Add these metrics to the colData  and visualise the outliers  
- Create new objects with outliers removed (either just low counts/features or with all outliers removed)
- Visualise how this filtering alters the number of droplets  

7.  Novelty  
- Visualise how filtering affects the novelty  

8.  Visualisation of QC metrics on PCA and UMAP  
- On the sce_empty and filtered objects: 
    - Perform log normalisation, identify variable genes, calculate PCA and UMAP  
    - Visualise the relation between the mean expression of each gene and the total / biological / technical variance of each gene.  
    - Visualise the QC metrics on UMAP  

9. Denoise PCA
- Perform denoise PCA to identify the PCs that are due to biological variation only
- Recalculate the UMAP on the reduced number of PCs and plot 

10.  Save the Single Cell Experiment and Seurat Objects as RDS files
- sce_empty: empty drops removed
- sce_decontX_doublet_filtered: ambient RNA & doublets removed
- sce_decontX_doublet_low_filtered: ambient RNA and doublets removed, low nCount and nFeature removed  
- sce_decontX_doublet_discard_filtered: ambient RNA and doublets removed, low nCount and nFeature removed, high mitochondrial reads removed  
- sce_decontX_doublet_discard_filtered_denoise: ambient RNA and doublets removed, low nCount and nFeature removed, high mitochondrial reads removed, denoise performed
- convert to Seurat Object and save (filtered only)  


**Outputs:**

Filter-achilles.Rmd knitted to html
Filtered SingleCellExperiment and Seurat Object RDS objects saved in RDS_objects.dir
QC plots saved as .png and .pdf files in Filtered_Figures.dir

