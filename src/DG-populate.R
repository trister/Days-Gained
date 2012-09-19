### Andrew Trister
### Sage Bionetworks
### Seattle, WA
### 20120912

### Load the Linear Days Gained Data in and print a quick plot


require(ggplot2)


#load in the DG data
DG <- read.delim("./data/Linear_Days_Gained.txt",sep=",",stringsAsFactors = FALSE)
t.test(DG$Linear.DG[which(DG$Classification=="Pseudoprogression")],DG$Linear.DG[which(DG$Classification=="Progression")])

#load in the clinical data to go with it
DG.clinical <- read.delim("./data/Clinical_PSP.txt",stringsAsFactors=FALSE)

#and also the TTP data:
DG.TTP <- read.delim2("./data/TTP.txt",stringsAsFactors = FALSE)

DG$TTP <- DG.TTP[DG$Patient,"Patient.ID..TTP"]

DG.culled <- DG[which(DG$Classification!="Nonprogressor"),]
#DG.culled$TTP <- DG.TTP[DG.culled$Patient,"Patient.ID..TTP"]

p <- ggplot(DG.culled)
p + geom_point(aes(x=1:dim(DG.culled)[1],y=Linear.DG[order(Linear.DG)],color=Classification[order(Linear.DG)]))

#require(scales)

p+geom_boxplot(aes(x=Classification,y=Linear.DG),size=1.5,outlier.size=4,) + geom_jitter(aes(x=Classification,y=Linear.DG),shape=2,size=4) +ylab("Days Gained") + theme_grey(36) 








