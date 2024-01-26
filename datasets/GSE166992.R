# This R script investigates the publicly available dataset: 

# GSE166992 for scRNAseq of COVID vs control 
# (smaller cohort no time points)

# 1 Obtain the dataset metadata tsv ####
getwd()
library(readxl)
GSE158055 <- read_xlsx("