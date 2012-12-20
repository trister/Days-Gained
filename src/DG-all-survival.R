### Sage Bionetworks
### Seattle, WA
### 20120912

### Look at the survival difference among all patients

source("./src/ggkm.R")

DG.clinical.culled <- DG.clinical[which(rownames(DG.clinical) %in% DG$Patient),]
temp <- DG
rownames(temp) <- temp$Patient
#temp <- temp[sort(temp$Patient),]

km.fit <- survfit(Surv(DG.clinical.culled$Patient..Survival,!DG.clinical.culled$Alive)~temp$Linear.DG>90, data=DG.clinical.culled)
#km.fit <- survfit(Surv(DG.clinical.culled$Patient..Survival,!DG.clinical.culled$Alive)~temp$Pseudo.progressor., data=DG.clinical.culled)



summary(km.fit)
ggkm(km.fit,timeby=365,ystratalabs=c("DG<90","DG>90"),main="")
plot(km.fit)



cox.fit <- coxph(Surv(DG.clinical.culled$Patient..Survival,!DG.clinical.culled$Alive)~temp$Linear.DG>90, data=DG.clinical.culled)
print(summary(cox.fit))

survdiff(Surv(DG.clinical.culled$Patient..Survival,!DG.clinical.culled$Alive)~temp$Linear.DG>90, data=DG.clinical.culled)
survdiff(Surv(DG.clinical.culled$Patient..Survival,!DG.clinical.culled$Alive)~temp$Pseudo.progressor., data=DG.clinical.culled)



#check the survival based only on whether the patients were on a trial

cox.fit <- coxph(Surv(DG.clinical.culled$Patient..Survival,!DG.clinical.culled$Alive)~temp$trial, data=DG.clinical.culled)
summary(cox.fit)

km.fit <- survfit(Surv(DG.clinical.culled$Patient..Survival,!DG.clinical.culled$Alive)~temp$trial, data=DG.clinical.culled)
ggkm(km.fit)

survdiff(Surv(DG.clinical.culled$Patient..Survival[which(temp$trial==0)],!DG.clinical.culled$Alive[which(temp$trial==0)])~temp$Linear.DG[which(temp$trial==0)]>90, data=DG.clinical.culled)
survdiff(Surv(DG.clinical.culled$Patient..Survival,!DG.clinical.culled$Alive)~temp$Pseudo.progressor., data=DG.clinical.culled)




