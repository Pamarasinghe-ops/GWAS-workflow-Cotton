###############################################################################################################################
#Best Linear Unbiased Prediction (BLUP) calculation for phenotypic data
###############################################################################################################################

#Load packages
library(Matrix)
library(lme4)

#Import and read phenotypic dataset
Cotton_neps_data=read.csv("CottonNeps.csv", header=T)

#Attach the dataset
attach(Cotton_neps_data)

##Visualize data
#Draw a histogram to check if data sets are normally distributed for the trait of interest. e.g, Seed Coat Neps (SCN)
hist(SCN,col="brown")

##Draw a box plot to see how each trait varies with location
boxplot(SCN~Location,
        xlab="Location",
        ylab = "SCN by location",col="brown")

# Rename variables for ease of use
LINE = as.factor(Taxa)
YEAR = as.factor(Year)
LOC = as.factor(Location)
REP = as.factor(Replications)
SCN = as.numeric(SCN)

## Linear Model with random effects for variance components
# SCN
SCNvarcomp = lmer(SCN~ (1|LINE) + (1|LOC) + (1|YEAR) + (1|REP%in%LOC:YEAR) + (1|LINE:LOC) + (1|LINE:YEAR))
# Extract variance components
summary(SCNvarcomp)

# Fit the model
SCNmodel = lmer(SCN ~ (1|LINE) + (1|LOC) + (1|YEAR) + (1|REP%in%LOC:YEAR) + (1|LINE:LOC) + (1|LINE:YEAR))

# Estimate BLUPs
SCNblup = ranef(SCNmodel)
# Check output structure
str(SCNblup)
# Extract blups. e.g., for line
SCNlineblup = SCNblup$LINE
# Save the extracted output to a separate .csv file
write.csv(SCNlineblup, file="SCNLineBLUPS.csv")

## Create plots with the BLUPs
# Create a numeric vector with the BLUP for each line
LINEBLUP = SCNlineblup[,1]
# Create a histogram with the BLUP for each line
hist(LINEBLUP, col="brown")

## Compare BLUP to line averages on a scatterplot
lmean = tapply(SCN, LINE, na.rm=T, mean)
plot(LINEBLUP, lmean, col="brown")





