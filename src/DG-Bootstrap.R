### Sage Bionetworks
### Seattle, WA
### 20121219

### Let's do a Boostrap 10-fold CV


require(ggplot2)
library(pROC)

### Build a more robust classifer using bootstrapping

N <- 10
fit <- c()

for(i in 1:N){
  j <- sample(1:floor(2*length(DG$Patient)/3),replace=TRUE)
  roc1 <- roc(DG.culled$Pseudo.progressor.[j],DG.culled$Linear.DG[j])
  cutoff <- coords(roc1,"best",ret="threshold")
  for(i in DG$Patient[-j]) {
    if(DG[i,"Linear.DG"]>=cutoff) {
      if(DG[i,"Classification"]=="Progression")
        fit <- c(fit,0)
      else fit <- c(fit,1)
    } else if(DG[i,"Classification"]=="Progression")
      fit <- c(fit,1)
    else fit <- c(fit,0)
  }
}
print(sum(fit)/length(fit))
