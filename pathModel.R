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

# removing 5 & 7
vars<-c(1:4,6,8:9)
vars<-c(1:4,6:9)
corrs<-corrs[vars,]
corrs<-corrs[,vars]
nvar<-nrow(corrs)

corrs<-corrs+t(corrs)+pracma::eye(nvar)
rownames(corrs)<-paste0("v",format(vars))
colnames(corrs)<-paste0("v",format(vars))

allModels<-permutations(nvar)
# use<-max(which(allModels[,1]==1))
# allModels<-allModels[1:use,]

nmodel<-nrow(allModels)
result<-c()
startm<-length(result)+1
result<-c(result,rep(NA,nmodel-length(result)))
for (j in startm:nmodel) {
  
  pathModel<-""
  for (i in 2:nvar)
    pathModel<-paste0(pathModel,'\n','v',format(vars[allModels[j,i]]), '~', 'v', format(vars[allModels[j,i-1]]))
  
  semResult<-lavaan::sem(pathModel,sample.cov=corrs,sample.nobs=1000)
  fit<-lavaan::fitMeasures(semResult)
  result[j]<-fit["aic"]
  if (floor(j/1000)*1000==j) print(c(j,nmodel,which.min(result[1:j]),vars[allModels[which.min(result[1:j]),]]))
}

print(vars[allModels[which.min(result),]])

j<-which.min(result)
pathModel<-""
for (i in 2:nvar)
  pathModel<-paste0(pathModel,'\n','v',format(vars[allModels[j,i]]), '~', 'v', format(vars[allModels[j,i-1]]))

semResult<-lavaan::sem(pathModel,sample.cov=corrs,sample.nobs=1000)
coeffs<-rowSums(lavaan::lavInspect(semResult,"coef")$beta)

#full
# v2   v4   v1   v3   v8   v7   v9   v6   v5  
# 0.00 0.62 0.73 0.73 0.34 0.63 0.61 0.62 0.71  

#sensible
# v2   v4   v1   v3   v6   v9   v7   v8   
# 0.00 0.62 0.73 0.73 0.40 0.62 0.61 0.63  


#minimal
# v2   v4   v1   v3   v6   v9   v8   
# 0.00 0.62 0.73 0.73 0.40 0.62 0.57  

