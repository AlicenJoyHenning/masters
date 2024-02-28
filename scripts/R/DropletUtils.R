# Installing and looking at documentation for DropletUtils

# DropletUtils 
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("DropletUtils")
# took a while

browseVignettes("DropletUtils")

