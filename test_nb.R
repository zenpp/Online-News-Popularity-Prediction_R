library(e1071)

news = read.csv("OnlineNewsPopularity.csv" , header = TRUE)
newsreg <- subset( news, select = -c(url, timedelta ) )
for(i in ncol(newsreg)-1){ 
  newsreg[,i]<-scale(newsreg[,i], center = TRUE, scale = TRUE)
}
newscla <- newsreg
newscla$shares <- as.factor(ifelse(newscla$shares > 1400,1,0))
set.seed(100)
ind <- sample(2,nrow(newscla),replace=TRUE,prob=c(0.7,0.3))

#na??ve bayes model
newscla.nb <- naiveBayes(shares ~.,newscla[ind==1,])

#predict
newscla.nb.pred <- predict( newscla.nb,newscla[ind==2,], type="class")
newscla.nb.prob <- predict( newscla.nb,newscla[ind==2,], type="prob")
# Confusion matrix
confusionMatrix(newscla.nb.pred, newscla[ind==2,]$shares)