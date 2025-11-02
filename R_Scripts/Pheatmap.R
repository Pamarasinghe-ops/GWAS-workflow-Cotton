################################################################################################################################################
#Heatmap of gene expression across tissues-customized to visualize transcript data from ccNET
#Modified from: https://github.com/raivokolde/pheatmap and https://biostatsquid.com/step-by-step-heatmap-tutorial-with-pheatmap/
################################################################################################################################################

#Load the packages
library(pheatmap)
library(RColorBrewer)
library(tidyverse)
library(dplyr)
library(tibble)

#Load expression data
expression_data <- read.csv("Expression_Data.csv", row.names = 1)

#Transpose
expr_t <- t(expression_data)

#Add labels and convert to data frame
sample_labels <- gsub("_[0-9]+$", "", rownames(expr_t))
expr_t_df <- as.data.frame(expr_t)
expr_t_df$tissue_time <- sample_labels


#Aggregate by Mean Across Replicates
expr_avg <- expr_t_df %>%
  group_by(tissue_time) %>%
  summarise(across(where(is.numeric), mean)) %>%
  column_to_rownames("tissue_time")

#Transpose back to genes as rows
expr_matrix_avg <- t(as.matrix(expr_avg))


#Optional: Log-Transform
expr_matrix_log <- log2(expr_matrix_avg + 1)

#See what are column names (prep for next step)
colnames(expr_matrix_log)

#Match desired Order of tissues
grep("Ovule|Seed|fiber", colnames(expr_matrix_log), value = TRUE)
desired_order <- c("Ovule_.3DPA", "Ovule_.1DPA", "Ovule_0DPA", "Ovule_1DPA", "Ovule_3DPA", "Ovule_5DPA", "Ovule_10DPA", "Ovule_20DPA", "Ovule_25DPA", "Ovule_35DPA", "fiber_5dpa", "fiber_10dpa", "fiber_20dpa", "fiber_25dpa")

#Reorder Safely
expr_matrix_ordered <- expr_matrix_log[, desired_order]

#Plot heatmap
heat_plot <-pheatmap(expr_matrix_ordered,
            cluster_rows = FALSE,
            cluster_cols = FALSE,
            clustering_distance_rows = 'euclidean',
            clustering_distance_cols = 'euclidean',
            clustering_method = 'ward.D',
            color = colorRampPalette(c("navy", "lightyellow", "firebrick3"))(50),
            main = "Ovule Gene Expression Over Time (DPA)",
            fontsize_row = 10,
            fontsize_col = 10,
            border_color = "gray")
