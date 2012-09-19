### Sage Bionetworks
### Seattle, WA
### 20120912

### Let's do a LOOCV for the DG data


require(ggplot2)
library(pROC)

rownames(DG.culled) <- DG.culled$Patient

DG.culled$LOOCV <- DG.culled$Pseudo.progressor.
cuts <- c()
for (i in 1:length(DG.culled$Patient)) {
  roc.temp <- roc(DG.culled[-i,"Pseudo.progressor."],DG.culled[-i,"Linear.DG"])
  cutoff <- coords(roc.temp, "best", ret="threshold")
  cuts <- c(cuts,cutoff)

  if(DG.culled[i,"Linear.DG"]>cutoff)
    DG.culled[i,"LOOCV"] <- 1
  else DG.culled[i,"LOOCV"] <- 0
}

print(paste("Average cut:",mean(cuts)))

testTable <- table(DG.culled$LOOCV)
outcomesTable <- table(DG.culled$LOOCV,DG.culled$Pseudo.progressor.)

print(paste("NPV:",outcomesTable[1,1]/testTable[1]))
print(paste("PPV:",outcomesTable[2,2]/testTable[2]))
print(paste("Specificity:",outcomesTable[1,1]/testTable[2]))
print(paste("Sensitivity:",outcomesTable[2,2]/testTable[1]))


