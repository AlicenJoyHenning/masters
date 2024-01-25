# This R script investigates the publicly available dataset GSE161918 for scRNAseq of COVID patients at various time points 

# 1 Obtain the dataset metadata csv ####
getwd()
metadata <- read.csv("2024_files/GSE161918_allbatches.HTOandTimepointMetadata.csv.gz")

# 2 Count the metadata features ####
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



# 3 Basic graphs describing the dataset ####
# 3.1 Pie chart of usable datasets ####

masters <- c("#94BAA8", # Healthy controls
             "#D3E3DB", # Unusable,
             "#F1E3E8", # T0
             "#E4CAD4", # T1 
             "#CD9BAE", # T2 
             "#9A4C6A") # T3
# NOTE: arranged "Metric" alphabetically so the order of colours here will match with alphabetical order below

# Create data frame 
pie <- data.frame(
  Status=c("Misassigned","Healthy controls", "T0","T1", "T2", "T3"),
  count=c(110, 31, 41, 24, 4, 3)
)

# Calculations
pie$fraction <- pie$count / sum(pie$count) # Compute percentages
pie$ymax <- cumsum(pie$fraction) # Compute the cumulative percentages (top of each rectangle)
pie$ymin <- c(0, head(pie$ymax, n=-1)) # Compute the bottom of each rectangle
pie$labelPosition <- (pie$ymax + pie$ymin) / 2 # Compute label position (if used)
pie$label <- percent(pie$fraction, accuracy = 1, suffix = "")  # # Compute percentages for labels Use accuracy = 1 to remove decimal points # suffix to remove percent sign 

# Make the plot
dataset_piechart <- ggplot(pie, aes(ymax=ymax, ymin=ymin, xmax=4, xmin=3, fill=Status)) +
  geom_rect() + 
 scale_fill_manual(values = masters)+ 
  coord_polar(theta="y") + # makes it a circle 
  xlim(c(2.7, 4)) +
  theme_void() +
  theme(legend.position = "right",
        legend.title = element_text(face = "bold", size = "22"),
        legend.text = element_text(size = "20"))
# View the plot
dataset_piechart
