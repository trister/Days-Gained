### Andrew Trister
### Sage Bionetworks
### Seattle, WA
### 20121207

### Look at the logistic regression across all of the different classes of patients


cox.fit <- coxph(Surv(DG$Patient..Survival,!DG$Alive)~as.factor(DG$Linear.DG>90)+as.factor(DG$trial)+DG.clinical$Age
                 +as.numeric(DG$Total.dose.to.tumor..cGy.)+as.factor(DG$TMZ.During.XRT)+as.factor(DG$BCNU.During.XRT)
                 +as.factor(DG$Special.chemo.with.XRT)+as.factor(DG$Gender)+as.factor(DG$Race), data=DG)

summary(cox.fit)

