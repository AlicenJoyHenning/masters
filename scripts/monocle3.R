#### MONOCLE3 TESTING
# 27/02/2024
# This R script explores the Monocle 3 vignette using the interferon dataset 

# [0] Installing the Biocoductor dependencies & monocle3 ####

BiocManager::install(c('BiocGenerics', 'DelayedArray', 'DelayedMatrixStats',
'limma', 'lme4', 'S4Vectors', 'SingleCellExperiment',
'SummarizedExperiment', 'batchelor', 'HDF5Array',
'terra', 'ggrastr', 'devtools'))

install.packages("devtools")
devtools::install_github('cole-trapnell-lab/monocle3')



# [1] 