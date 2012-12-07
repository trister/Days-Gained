### Andrew Trister
### Sage Bionetworks
### Seattle, WA
### 20120919

#Master source calls for DG analysis

setwd("~/Days-Gained/")

#load the data
source("./src/DG-populate.R")

#make the ROC analysis
source("./src/DG-ROC.R")

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

