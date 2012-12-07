### Sage Bionetworks
### Seattle, WA
### 20120912

### Look at the survival difference among the patients with progression


require(ggplot2)
library(pROC)
require(plyr)
require(reshape)
require(survival)
source("./src/ggkm.R")
#require(ROCR)


###Block for only the ones with progression

DG.clinical.culled <- DG.clinical[which(rownames(DG.clinical) %in% DG.culled$Patient[which(DG.culled$Classification=="Progression")]),]
temp <- DG.culled[which(DG.culled$Classification=="Progression"),]
rownames(temp) <- temp$Patient
temp <- temp[sort(temp$Patient),]

km.fit <- survfit(Surv(DG.clinical.culled$Patient..Survival,!DG.clinical.culled$Alive)~temp$Linear.DG>90, data=DG.clinical.culled)
km.fit <- survfit(Surv(DG.clinical.culled$Patient..Survival,!DG.clinical.culled$Alive)~temp$Pseudo.progressor., data=DG.clinical.culled)



summary(km.fit)
ggkm(km.fit,timeby=365,ystratalabs=c("DG<90","DG>90"),main="") 

plot(km.fit)

cox.fit <- coxph(Surv(DG.clinical.culled$Patient..Survival,!DG.clinical.culled$Alive)~temp$Linear.DG>90, data=DG.clinical.culled)
summary(cox.fit)

survdiff(Surv(DG.clinical.culled$Patient..Survival,!DG.clinical.culled$Alive)~temp$Linear.DG>90, data=DG.clinical.culled)
survdiff(Surv(DG.clinical.culled$Patient..Survival,!DG.clinical.culled$Alive)~temp$Pseudo.progressor., data=DG.clinical.culled)
