### Sage Bionetworks
### Seattle, WA
### 20121219

### This is an exploratory view of adjusting the Days Gained score for the differences in D/rho

require(ggplot2)
library(pROC)
require(plyr)


# first let's produce a boxplot of all the patients with progression on the first scan and scale
# the points to reflect D/rho

p <- ggplot(DG.culled)
p + geom_boxplot(position="dodge", aes(x=DG.culled$Classification,y=DG.culled$Linear.DG),outlier.size=0) +geom_jitter(aes(x=DG.culled$Classification,y=DG.culled$Linear.DG,size=log10(DG.culled$Rho/DG.culled$D)),shape=2)+geom_hline(y=90,linetype=2,size=1,color="red") +theme_bw(base_size = 12, base_family = "")

p+geom_boxplot(position="dodge",aes(x=DG.culled$Classification,y=(DG.culled$Rho/DG.culled$D)))+scale_y_log10()
t.test(DG.culled$Rho[1:39]/DG.culled$D[1:39]~DG.culled$Classification[1:39])

p+geom_boxplot(position="dodge",aes(x=DG.culled$Classification,y=DG.culled$Linear.DG*(log10(2*sqrt(DG.culled$D*DG.culled$Rho)))))+scale_y_log10()

p2 <- ggplot(DG)
p2+geom_boxplot(position="dodge",aes(x=Classification,y=Linear.DG))+scale_y_log10()
p2

plot(log10(DG.culled$Rho),DG.culled$Linear.DG/DG.culled$Rho, col=c("red","blue")[as.factor(DG.culled$Classification)])


temp <- c()
for (i in 1:table(is.na(DG.culled$Rho))[1]){
  if(log10(DG.culled$Rho[i])<1)
    temp <- c(temp,DG.culled$Linear.DG[i]/log10(DG.culled$Rho[i]))
  else temp <- c(temp,DG.culled$Linear.DG[i]*log10(DG.culled$Rho[i]))
}

temp <- aov(log10(DG$Rho/DG$D)~DG$Classification)
summary(temp)

roc1 <- roc(DG.culled$Classification[1:39],temp)

p3 <- ggplot(DG.culled[1:39,])
p3+geom_boxplot(position="dodge",aes(x=Classification,y=temp))
p3+geom_boxplot(position="dodge",aes(x=Classification,y=Linear.DG))

p3+geom_boxplot(position="dodge",aes(x=Classification,y=log10(Rho/D)*Linear.DG),outlier.size=0)+
  geom_jitter(aes(x=Classification,y=log10(Rho/D)*Linear.DG,size=Survival),shape=2)+
  geom_hline(y=185,linetype=2,size=1,color="red") +theme_bw(base_size = 12, base_family = "")

p2+geom_boxplot(position="dodge",aes(x=Classification,y=log10(Rho/D)*Linear.DG),outlier.size=0)+
  geom_jitter(aes(x=Classification,y=log10(Rho/D)*Linear.DG,size=Survival),shape=2)+
  geom_hline(y=185,linetype=2,size=1,color="red") +theme_bw(base_size = 12, base_family = "")

#and now let's do an ROC for just D/rho
roc1 <- roc(DG.culled$Classification,DG.culled$Linear.DG*log10(DG.culled$Rho/DG.culled$D))
roc2 <- smooth(roc1,method="binormal")


plot(roc1,lwd=6,font=3, cex.lab=2)
plot(roc2, add=TRUE, lty=2,lwd=6)
plot(roc2)

