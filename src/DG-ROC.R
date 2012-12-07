### Andrew Trister
### Sage Bionetworks
### Seattle, WA
### 20120912

### Perform ROC analysis on the loaded Data for DG 


require(ggplot2)
library(pROC)
require(plyr)



roc1 <- roc(DG.culled$Pseudo.progressor.,DG.culled$Linear.DG)
#roc2 <- roc(DG$Pseudo.progressor.,DG$Linear.DG)
roc2 <- smooth(roc1,method="binormal")

temp <- list(data.frame(roc1$sensitivities,roc1$specificities),data.frame(roc2$sensitivities,roc2$specificities))
roc.data <- do.call(rbind.fill,temp)

p2 <- ggplot(roc.data)
p2 + geom_path(aes(y=roc1.sensitivities,x=roc1.specificities), size=1.5) + scale_x_reverse() + ylab("Sensitivity") + xlab("Specificity") + theme_grey(36) + geom_path(aes(y=roc2.sensitivities,x=roc2.specificities), size=1.5, lty=2) 


plot(roc1,lwd=6,font=3, cex.lab=2)
plot(roc2, add=TRUE, lty=2,lwd=6)
plot(roc2)

coords(roc1, "best", ret=c("threshold", "specificity", "sensitivity","1-npv"))
coords(roc1, "local maximas", ret=c("threshold", "sens", "spec", "ppv", "npv"))
coords(smooth(roc1), "best", ret=c("threshold", "specificity", "sensitivity", "accuracy",
                                   "tn","fn","tp","tn",   "npv", "ppv", "1-specificity",
                                   "1-sensitivity", "1-npv", "1-ppv"))

coords(roc1, "best", ret=c("threshold", "specificity", "sensitivity", "accuracy",
                           "tn","fn","tp","tn",   "npv", "ppv", "1-specificity",
                           "1-sensitivity", "1-npv", "1-ppv"))
boxplot(DG.culled$Linear.DG~DG.culled$Classification)

#DG.culled.2 <- DG[which(DG$Classification!="Progression"),]
#p <- ggplot(DG.culled.2)
#p + geom_point(aes(x=1:dim(DG.culled.2)[1],y=Linear.DG[order(Linear.DG)],color=Classification[order(Linear.DG)]))
#boxplot(DG.culled.2$Linear.DG~DG.culled.2$Classification)

t.test(DG$Linear.DG[which(DG$Classification=="Pseudoprogression")],DG$Linear.DG[which(DG$Classification=="Nonprogressor")])

DG.clinical.culled <- DG.clinical[which(rownames(DG.clinical) %in% DG.culled$Patient),]
DG.clinical.culled$KPS.score.used.for.paper[which(DG.clinical.culled$KPS.score.used.for.paper=="no pretreatment exam")] <- NA
DG.clinical.culled$KPS.score.used.for.paper <- as.numeric(DG.clinical.culled$KPS.score.used.for.paper)

median(DG.clinical.culled$Days.b.w.end.of.XRT.and.1st.posttreat.MRI[which(rownames(DG.clinical.culled) %in% DG.culled$Patient[which(DG.culled$Classification=="Progression")])],na.rm=TRUE)
range(na.rm=T, DG.clinical.culled$Days.b.w.end.of.XRT.and.1st.posttreat.MRI[which(rownames(DG.clinical.culled) %in% DG.culled$Patient[which(DG.culled$Classification=="Progression")])])

median(na.rm=T, DG.clinical.culled$Days.b.w.end.of.XRT.and.1st.posttreat.MRI[which(rownames(DG.clinical.culled) %in% DG.culled$Patient[which(DG.culled$Classification=="Pseudoprogression")])])
range(na.rm=T, DG.clinical.culled$Days.b.w.end.of.XRT.and.1st.posttreat.MRI[which(rownames(DG.clinical.culled) %in% DG.culled$Patient[which(DG.culled$Classification=="Pseudoprogression")])])

table(DG.clinical.culled$TMZ.During.XRT[which(rownames(DG.clinical.culled) %in% DG.culled$Patient[which(DG.culled$Classification=="Progression")])])


