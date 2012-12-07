### Sage Bionetworks
### Seattle, WA
### 20120912

### Look at the TTP difference among all patients


DG.clinical.culled <- DG.clinical[which(rownames(DG.clinical) %in% DG$Patient),]
temp <- DG

rownames(temp) <- temp$Patient
temp <- temp[sort(temp$Patient),]

km.fit <- survfit(Surv(temp$TTP,!DG.clinical.culled$Alive)~temp$Linear.DG>90, data=DG.clinical.culled)
#km.fit <- survfit(Surv(DG.clinical.culled$Patient..Survival,!DG.clinical.culled$Alive)~temp$Pseudo.progressor., data=DG.clinical.culled)



summary(km.fit)
ggkm(km.fit,timeby=365,ystratalabs=c("DG<90","DG>90"),main="",ylabs="Progression Probability") 

plot(km.fit)

cox.fit <- coxph(Surv(temp$TTP,!DG.clinical.culled$Alive)~temp$Linear.DG>90, data=DG.clinical.culled)
summary(cox.fit)

survdiff(Surv(DG.clinical.culled$Patient..Survival,!DG.clinical.culled$Alive)~temp$Linear.DG>90, data=DG.clinical.culled)
survdiff(Surv(DG.clinical.culled$Patient..Survival,!DG.clinical.culled$Alive)~temp$Pseudo.progressor., data=DG.clinical.culled)

