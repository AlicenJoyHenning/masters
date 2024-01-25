# This R script investigates the publicly available dataset: 

# GSE158055 for scRNAseq of COVID patients at varying severities 

# 1 Obtain the dataset metadata tsv ####
getwd()
library(readxl)
GSE158055 <- read_xlsx("masters/datasets/GSE158055/GSE158055_sample_metadata.xlsx")

# 2 Count the metadata features ####

length(unique(GSE158055$Patients)) # 196 
PBMC <- subset(GSE158055, GSE158055$`Sample type` == "fresh PBMC")
length(unique(PBMC$Patients)) # 79
