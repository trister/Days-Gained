### Andrew Trister
### Sage Bionetworks
### Seattle, WA
### 20120912

### Load the Linear Days Gained Data in and print a quick plot


require(ggplot2)

# 
# #load in the DG data
# DG <- read.delim("./data/Linear_Days_Gained.txt",sep=",",stringsAsFactors = FALSE)
# t.test(DG$Linear.DG[which(DG$Classification=="Pseudoprogression")],DG$Linear.DG[which(DG$Classification=="Progression")])
# 
# #load in the clinical data to go with it
# DG.clinical <- read.delim("./data/Clinical_PSP.txt",stringsAsFactors=FALSE)
# 
# #and also the TTP data:
# DG.TTP <- read.delim2("./data/TTP.txt",stringsAsFactors = FALSE)
# 
# DG$TTP <- DG.TTP[DG$Patient,"Patient.ID..TTP"]
# DG.TTP$Days.Gained <- as.numeric(DG.TTP$Days.Gained)
# 
# DG.culled <- DG[which(DG$Classification!="Nonprogressor"),]
# #DG.culled$TTP <- DG.TTP[DG.culled$Patient,"Patient.ID..TTP"]
# 
# #put in the information whether the patient was on trial
# #DG$trial <- c(1,0,1,1,0,1,0,1,0,1,0,0,0,0,0,0,0,1,1,1,1,0,1,0,0,0,0,0,0,1,1,0,0,1,1,1,0,0,1,0,0,1,0,1,1,0,1,0,1,1,1,0,0,1,0,0,1,0)
# DG.clinical$trial <- c(1,0,1,1,1,1,0,0,0,1,1,0,1,1,0,1,0,0,1,0,0,0,1,0,1,0,0,0,0,0,0,1,1,0,0,0,1,0,0,1,1,1,1,1,0,1,1,0,0,1,0,0,1,0,0,0,0,0,1,0,0,0,0)
#   

#here are the 68 new DG3 patients:
DG.new <- read.delim("./data/DG3-fullsheet.txt",stringsAsFactors=FALSE)


DG.new$Classification <- DG.new$Patient.ID..Classification
DG.new$Pseudo.progressor. <- unlist(lapply(DG.new$Classification,function(x){
  if(x=="Pseudoprogression") 1
  else 0
}))
DG.new$Linear.DG <- DG.new$Linear.model.Days.Gained.score
DG.new$Patient <- rownames(DG.new)
DG.new$Patient..Survival <- DG.new$Survival
DG.new$trial <- DG.new$Trial

DG <- DG.new
DG.culled <- DG[which(DG$Classification=="Progression"|DG$Classification=="Pseudoprogression"),]
#DG.culled <- DG.new[which(DG.new$Patient.ID..Classification!="Nonprogressor"),]
DG.clinical <- DG





unlist(lapply(rownames(DG.clinical),function(x){
  return(DG[which(DG$Patient==x),"trial"])
}))
p <- ggplot(DG.culled)
p + geom_point(aes(x=1:dim(DG.culled)[1],y=Linear.DG[order(Linear.DG)],color=Classification[order(Linear.DG)]))

#require(scales)

p+geom_boxplot(aes(x=Classification,y=Linear.DG),size=1.5,outlier.size=4,) + geom_jitter(aes(x=Classification,y=Linear.DG),shape=2,size=4) +ylab("Days Gained") + theme_grey(36) 








