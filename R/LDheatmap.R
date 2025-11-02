###########################################################################################################################################################
#Linkage Disequilibrium (LD) heat maps
###########################################################################################################################################################
#Call libraries
library(devtools)
library(snpStats)
library(LDheatmap)
library(GAPIT)
library(ggplot2)

#Import data set
gdat<-read.csv ("Chr.hmp.csv", header=TRUE)

#Subset data
gdat1<-subset(gdat,chrom=='A07')

#Obtain a numeric dataset. 
datN<-GAPIT(G=gdat1, output.numerical = TRUE)
Numericdata<-datN$GD[,-1]
Geno<-as.matrix(Numericdata)

#Extract map data
Map0<-datN$GM

#Check dimensions of genotypic data & map data to ascertain if they match
dim(Geno)
dim(Map0)

#Convert SNP data into snpMatrix object
Gdat<-as(Geno, "SnpMatrix")

#From Map0, extract Position
Gdis<-Map0$Position

#Plot LD
MyHeatmap<-LDheatmap(Gdat,genetic.distances=Gdis)


