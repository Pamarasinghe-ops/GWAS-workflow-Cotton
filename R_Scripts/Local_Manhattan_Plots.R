#################################################################################
#Local Manhattan Plots Customize
#Modified from: https://github.com/YinLiLin/CMplot
#################################################################################

#Call packages
library(CMplot)
library(dplyr)

#Load GAPIT result table
Chrm_GAPIT_results = read.csv("GAPIT_Association.csv")

#The local Manhattan plot with custom thresholds
CMplot(Chrm_GAPIT_results,
       type = "p", 
       plot.type = "m", 
       LOG10 = TRUE,
       threshold = 6.76e-7,  
       threshold.col = "red",
       threshold.lty = 2, 
       threshold.lwd = 2, 
       highlight = highlight_snps,
       highlight.col = "green",  
       highlight.cex = 1.5,      
       chr.den.col = "black",
       file = "jpg",
       dpi = 300,
       file.output = TRUE)