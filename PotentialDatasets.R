# Looking at potentail datasets


getwd()
metadata <- read.csv("2024_files/GSE161918_allbatches.HTOandTimepointMetadata.csv.gz")


length(which(metadata$Pool == "misassigned")) # 110 out of 213 entries are not usable 

workable <- subset(metadata, metadata$Pool != "misassigned")

length(which(workable$Gender == "Male")) # 69 / 103
length(which(workable$Gender == "Female")) # 23 / 103

length(which(workable$Ward == "Healthy_control")) # 31 / 103

length(which(workable$Ward == "Infectious_Diseases")) # 53 / 103 
length(which(workable$Ward == "Tropical_Diseases")) # 19 / 103 ??? wat beteken dit 
length(which(workable$Ward != "Healthy_control" & workable$Status == "Alive")) # 68 / 72 with infection are alive, 4 dead  

length(which(workable$Timepoint == "T0")) # 41
length(which(workable$Timepoint == "T1")) # 24 
length(which(workable$Timepoint == "T2")) # 4 
length(which(workable$Timepoint == "T3")) # 3
length(which(workable$Timepoint == "HC")) # 31 


length(meta)