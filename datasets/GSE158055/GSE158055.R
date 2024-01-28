# This R script investigates the publicly available dataset: 

# GSE158055 for scRNAseq of COVID patients at varying severities 

# 1 Obtain the dataset metadata tsv ####
getwd()
library(readxl)
GSE158055 <- read_xlsx("masters/datasets/GSE158055/GSE158055_sample_metadata.xlsx")

# 2 Count the metadata features ####

length(unique(GSE158055$Patients)) # 196 



Genomics10Xv3 <- subset(GSE158055, GSE158055$`Single cell sequencing platform` == "10X 3'")

Genomics10xv5 <- subset(GSE158055, GSE158055$`Single cell sequencing platform` == "10X 5'" & GSE158055$`BCR single cell sequencing` == "No" & GSE158055$`TCR single cell sequencing` == "No")

PBMC <- subset(GSE158055, GSE158055$`Sample type` == "fresh PBMC")
length(unique(PBMC$Patients)) # 79

PBMC <- subset(PBMC$


# 3 Plot some features 
PB <- subset(PBMC, PBMC$`Sampling day (Days after symptom onset)`!= "control" & PBMC$`Sampling day (Days after symptom onset)`!= "unknown")
PB$`Sampling day (Days after symptom onset)` <- as.numeric(PB$`Sampling day (Days after symptom onset)`)
PB <- arrange(PB, PB$`Sampling day (Days after symptom onset)`)
PB <- PB %>%
  group_by(`Sampling day (Days after symptom onset)`) %>%
  mutate(Count = n())

PB <- PB$`Sampling day (Days after symptom onset)`\
PB <- as.data.frame(PB)

# Specify the data and the column for the boxplot
ggplot(data = PB, aes(x = PB)) +
  geom_bar(stat = "count") +
  scale_fill_manual(values = c("#94BAA8")) +
  labs(title = "",
       x = "Days after symptom onset",
       y = "Number of datasets") + 
  theme_bw() + 
  theme(panel.grid  = element_blank())

?theme()
ggplot(data = PB, aes(x = PB)) +
  geom_bar(stat = "count", fill = "#94BAA8") +
  labs(title = "",
       x = "Days after symptom onset",
       y = "Number of datasets") + 
  theme_bw() + 
  theme(panel.grid  = element_blank())
