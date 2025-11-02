############################################################################################################################################################################################################
#GWAS result visualization with Fastman package
#Modified from: https://github.com/kaustubhad/fastman
############################################################################################################################################################################################################

#Call packages
library(data.table)
library(devtools) 
library(fastman)
library(ggplot2)

#Load GAPIT results
GAPIT_results = fread("Input/GAPIT.Association.GWAS_Results.MLM.SCN(NYC).csv")

#See table info
head(GAPIT_results) 
tail(GAPIT_results)
dim(GAPIT_results) 
colnames(GAPIT_results) 

##Manhattan plot with customized threshold, parameters, & colors
png("SCN_MLM_ManPlot.png", width=30, height=6, units="in", res=300)
fastman(GAPIT_results, chr = "Chr",ps = "BP", p = "P.value", snp="SNP", logp = TRUE, baseline=NULL, suggestiveline = 7.47, cex.lab = 1.5, cex.axis = 1.5, col=c("blue", "orange1", "green", "lightblue", "#ff5733", "orchid4", "gold", "brown", "black", "pink", "brown2", "green4" , "pink4"))
dev.off()

#Customized Q-Q plot
png("SCN_MLM_QQPlot.png", width=10, height=6, units="in", res=300)
fastqq(GAPIT_results$P.value, logtransform=TRUE, pairwisecompare=TRUE, speedup=TRUE, lambda=TRUE, fix_zero=TRUE, cex=0.6, cex.axis=0.9)
dev.off()
