### Test parallel loops for Find Markers ###

library('doMC')
library(tidyverse)
library(Seurat)
library(cowplot)
library(yaml)
library(viridis)
library(svglite)

# set up the parallel bit

# import the number of available CPUs
# this is the number we supplied at the line
#SBATCH --cpus-per-task=4
# in our .sh file
n.cpus <- Sys.getenv("SLURM_CPUS_PER_TASK")
n.cpus <- as.numeric(n.cpus)
n.cpus

# register a parallel backend specifying the number of CPUs as the number we imported via Sys.getenv()
registerDoMC(cores = n.cpus) 

# make a new output folder for each run, with the date & time in the directory name
date <- Sys.Date() %>% str_replace_all("-", "")
time <- format(Sys.time(), "%X") %>% str_replace_all(":", "-") %>%
    str_sub(1, 5)
directory <- paste0(date,"_", time, "_Parallel_loops.dir")
dir.create(directory, showWarnings = FALSE)
dir.create(paste0(directory, "/Marker_lists/"))

# read in the object
so.fibroblasts <- readRDS("20240509_09-52_Subset_fibroblasts.dir/RDS_objects.dir/Achilles_fibroblast_subset.rds")

# define function to find markers at a specific resolution
find_markers <- function(resolution){
    res_name <- paste0("soupX_snn_res.", resolution)
    print(res_name)
    # set the idents to the resolution
    Idents(so.fibroblasts) <- so.fibroblasts[[res_name]] %>% pull()
    # how many clusters are there?
    print(length(unique(Idents(so.fibroblasts))))
    
    markers <-  FindAllMarkers(so.fibroblasts,
                               assay = "soupX",
                               only.pos = TRUE, 
    )
    write.table(markers, 
                paste0(directory, "/Marker_lists/Markers_", resolution, ".txt"), 
                quote = FALSE, sep = "\t")
    return(markers)
    
}

# find markers at each resolution
found_markers <- list()
foreach (resolution = seq(0.05, 3, by = 0.05), .packages = c("Seurat", "tidyverse")) %dopar% {
    found_markers[[resolution]] <- find_markers(resolution)
}