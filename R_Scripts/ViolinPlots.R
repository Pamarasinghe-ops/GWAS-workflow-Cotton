##########################################################################################################################################################
#Violin plots
#Modified from:  https://dbaranger.medium.com/showing-your-data-scatter-box-violin-plots-1f3bb06c8c2b
##########################################################################################################################################################

#Call libraries
library(dplyr)
library(ggplot2)
library(tidyr)

#Import data
data<-read.csv("Genotypes.csv", header=TRUE)

#Count genotypes
genotype_counts <- data %>%
  group_by(Genotype) %>%
  summarise(n = n())

# Reorder Genotype factor by count
data$Genotype <- factor(data$Genotype, levels = genotype_counts$Genotype[order(-genotype_counts$n)])

# Create the grouped violin plot
ggplot(data, aes(x = Genotype, y = phenotype, fill = Genotype)) +
  geom_violin(position = position_dodge(width = 0.9), trim = FALSE) +
  geom_point(shape = 21, size = 2, position = position_jitterdodge(), color = "black", alpha = 1) + 
  geom_boxplot(
    width = 0.1,
    position = position_dodge(width = 0.9),
    color = "yellow",
    fill = "white",
    alpha = 0
  ) +
  geom_text(
    data = genotype_counts,
    aes(x = Genotype, y = max(data$Phenotype) * 1.05, label = paste("n =", n)),
    inherit.aes = FALSE,
    size = 4
  ) +
  labs(  
    title = "Violin_plot",
    x = "Genotype",
    y = "Phenotype",
    fill = "Genotype",
  ) +
  theme_minimal()