### Andrew Trister
### Sage Bionetworks
### Seattle, WA
### 20121207

### Look at the logistic regression across all of the different classes of patients




DG.clinical.culled <- DG.clinical[which(rownames(DG.clinical) %in% DG$Patient),]
temp <- DG
rownames(temp) <- temp$Patient
temp <- temp[sort(temp$Patient),]

km.fit <- survfit(Surv(DG.clinical.culled$Patient..Survival,!DG.clinical.culled$Alive)~temp$Linear.DG>90, data=DG.clinical.culled)
#km.fit <- survfit(Surv(DG.clinical.culled$Patient..Survival,!DG.clinical.culled$Alive)~temp$Pseudo.progressor., data=DG.clinical.culled)



summary(km.fit)
ggkm(km.fit,timeby=365,ystratalabs=c("DG<90","DG>90"),main="") 

plot(km.fit)

cox.fit <- coxph(Surv(DG.clinical.culled$Patient..Survival,!DG.clinical.culled$Alive)~as.factor(temp$Linear.DG>90)+as.factor(temp$trial)+DG.clinical.culled$Age+
  as.factor(DG.clinical.culled$Gender)+as.factor(DG.clinical.culled$RTOG.RPA.Class), data=DG.clinical.culled)

cox.fit <- coxph(Surv(DG.clinical.culled$Patient..Survival,!DG.clinical.culled$Alive)~as.factor(DG.clinical.culled$TMZ.During.XRT))
summary(cox.fit)


#redo this with the full 63 using the TTP data


cox.fit <- coxph(Surv(DG.clinical$Patient..Survival,!DG.clinical$Alive)~as.factor(DG.TTP$Days.Gained>90)+as.factor(DG.clinical$trial)+DG.clinical$Age+
  as.factor(DG.clinical$Gender)+as.factor(DG.clinical$RTOG.RPA.Class), data=DG.clinical)

cox.fit <- coxph(Surv(DG.clinical$Patient..Survival,!DG.clinical$Alive)~as.factor(DG.clinical$RTOG.RPA.Class))
summary(cox.fit)

