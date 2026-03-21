permutations <- function(n){
  if(n==1){
    return(matrix(1))
  } else {
    sp <- permutations(n-1)
    p <- nrow(sp)
    A <- matrix(nrow=n*p,ncol=n)
    for(i in 1:n){
      A[(i-1)*p+1:p,] <- cbind(i,sp+(sp>=i))
    }
    return(A)
  }
}

corrs<-matrix(c(
  rep(0,9),
  0.63,rep(0,8),
  0.73,0.54,rep(0,7),
  0.73,0.62,0.63,rep(0,6),
  0.29,0.07,0.31,0.21,rep(0,5),
  0.41,0.19,0.40,0.35,0.71,rep(0,4),
  0.40,0.25,0.38,0.37,0.54,0.59,rep(0,3),
  0.35,0.25,0.34,0.37,0.46,0.57,0.63,rep(0,2),
  0.35,0.25,0.37,0.34,0.53,0.62,0.61,0.57,rep(0,1)
),9,9)

corrs<-corrs+t(corrs)+pracma::eye(9)
rownames(corrs)<-paste0("v",format(1:9))
colnames(corrs)<-paste0("v",format(1:9))

allModels<-permutations(9)
# use<-max(which(allModels[,1]==1))
# allModels<-allModels[1:use,]

nm<-nrow(allModels)
startm<-length(result)+1
result<-c(result,rep(NA,nm-length(result)))
for (j in startm:nm) {
  
  pathModel<-""
  for (i in 2:9)
    pathModel<-paste0(pathModel,'\n','v',format(allModels[j,i]), '~', 'v', format(allModels[j,i-1]))
  
  semResult<-lavaan::sem(pathModel,sample.cov=corrs,sample.nobs=1000)
  fit<-lavaan::fitMeasures(semResult)
  result[j]<-fit["aic"]
  if (floor(j/1000)*1000==j) print(c(j,which.min(result[1:j]),allModels[which.min(result[1:j]),]))
}

print(allModels[which.min(result),])

j<-which.min(result)
pathModel<-""
for (i in 2:9)
  pathModel<-paste0(pathModel,'\n','v',format(allModels[j,i]), '~', 'v', format(allModels[j,i-1]))

semResult<-lavaan::sem(pathModel,sample.cov=corrs,sample.nobs=1000)
coeffs<-rowSums(lavaan::lavInspect(semResult,"coef")$beta)

# v2   v4   v1   v3   v8   v7   v9   v6   v5  
# 0.00 0.62 0.73 0.73 0.34 0.63 0.61 0.62 0.71  

