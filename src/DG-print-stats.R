### Andrew Trister
### Sage Bionetworks
### Seattle, WA
### 20121219

#Print out the statistics for all of the patients

printStats <- function(DG){
  print(paste("Median Age:",median(DG$Age),sep=" "))
  print(cat("Range:",range(DG$Age)))
  print(cat("Female:",table(DG$Gender)[1]/length(DG$Gender)))
  print(paste("Median KPS:",median(as.numeric(DG$KPS.score.used.for.paper),na.rm=TRUE),sep=" "))
  print(cat("Range:",range(as.numeric(DG$KPS.score.used.for.paper),na.rm=TRUE)))
  print(cat("RPA III:",table(DG$RTOG.RPA.Class)[1]/table(is.na(DG$RTOG.RPA.Class))[1]))
  print(cat("RPA IV:",table(DG$RTOG.RPA.Class)[2]/table(is.na(DG$RTOG.RPA.Class))[1]))
  print(cat("RPA V:",table(DG$RTOG.RPA.Class)[3]/table(is.na(DG$RTOG.RPA.Class))[1]))
  print(cat("Biopsy:",table(DG$Only.Biopsy.at.Start)[2]/length(DG$Only.Biopsy.at.Start)))
  print(cat("STR:",table(DG$STR.at.Start)[2]/length(DG$STR.at.Start)))
  print(cat("GTR:",table(DG$GTR.at.Start)[2]/length(DG$GTR.at.Start)))
  print(paste("Median XRT:",median(DG$Total.dose.to.tumor..cGy.,na.rm=TRUE)))
  print(cat("Range XRT:",range(DG$Total.dose.to.tumor..cGy.,na.rm=TRUE)))
  print(cat("TMZ:",table(DG$TMZ.During.XRT)[2],table(DG$TMZ.During.XRT)[2]/length(DG$TMZ.During.XRT)))
  print(cat("BCNU:",table(DG$BCNU.During.XRT)[2],table(DG$BCNU.During.XRT)[2]/length(DG$BCNU.During.XRT)))
  print(cat("MGMT:",table(DG$MGMT)[2],table(DG$MGMT)[2]/table(is.na(DG$MGMT))[1]))
  print(cat("Mean days before scan:",mean(DG$Days.b.w.end.of.XRT.and.1st.posttreat.MRI)))
  print(cat("Range of days:",range(DG$Days.b.w.end.of.XRT.and.1st.posttreat.MRI)))
}


print("All patients")
printStats(DG)

print("True Progression")
printStats(DG[which(DG$Classification=="Progression"),])

print("Psuedo Progression")
printStats(DG[which(DG$Classification=="Pseudoprogression"),])