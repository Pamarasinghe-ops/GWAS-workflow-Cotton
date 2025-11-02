############################################################################################################################################################################################################
#SNP-density plot using CM plot 
#Modified from: https://github.com/YinLiLin/CMplot
############################################################################################################################################################################################################

#Call package
library(CMplot)

#Load data
snp_data <- read.table("Chrms.txt", header = TRUE)

#Generate SNP-density plot
CMplot(snp_data, plot.type = "d", bin.size = 1e6, file.output = TRUE)

#Generate SNP-density plot
pdf("SNP_density_custom.pdf", width = 10, height = 6)
par(cex = 3) 

CMplot(snp_data,
       plot.type = "d",
       bin.size = 1e6,
       file.output = FALSE
)

dev.off()