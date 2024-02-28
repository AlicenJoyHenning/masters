# MONOCLE3 TESTING 
# 27/02/2024
# This R script explores the Monocle 3 vignette using the interferon dataset 

# [1] Installing dependencies #####

#  Package names 
BiocManager::install(c('DelayedArray','DelayedMatrixStats','limma', 'lme4', 'S4Vectors', 
                       'SingleCellExperiment','SummarizedExperiment', 'batchelor', 'HDF5Array',
                       'terra', 'ggrastr', 'devtools')) 

library(batchelor)
library(DelayedArray)
library(DelayedMatrixStats)
library(devtools)
library(dplyr)
library(ggrastr)
library(ggplot2)
library(HDF5Arrary)
library(limma)
library(lme4)
library(S4Vectors)
library(SingleCellExperiment)
library(SummarizedExperiment)
library(terra)


# Install Monocle3 
devtools::install_github('cole-trapnell-lab/monocle3')

library(monocle3)

# [2] 