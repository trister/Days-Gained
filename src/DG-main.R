### Andrew Trister
### Sage Bionetworks
### Seattle, WA
### 20120919

#Master source calls for DG analysis

setwd("~/Days-Gained/")

#load the data
source("./src/DG-populate.R")

#print out the statistics for table 1
source("./src/DG-print-stats.R")

#make the ROC analysis
source("./src/DG-ROC.R")

#check the ability of D/p to normalize the data:
source("./src/DG-Drho.R")

#the survival analysis for progressors
source("./src/DG-progressors-survival.R")

#and survival for all patients
source("./src/DG-all-survival.R")

#and TTP for progressors
source("./src/DG-progressors-TTP.R")

#and TTP for all patients
source("./src/DG-all-TTP.R")

#finally let's do the LOOCV
source("./src/DG-LOOCV.R")

#and the multivariate analysis
source("./src/DG-Multivariate.R")

