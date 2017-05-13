library(party)
library(caret)

news = read.csv("OnlineNewsPopularity.csv" , header = TRUE)
newsreg <- subset( news, select = -c(url, timedelta ) )
for(i in ncol(newsreg)-1){ 
  newsreg[,i]<-scale(newsreg[,i], center = TRUE, scale = TRUE)
}
newscla <- newsreg
newscla$shares <- as.factor(ifelse(newscla$shares > 1400,1,0))
set.seed(100)
ind <- sample(2,nrow(newscla),replace=TRUE,prob=c(0.7,0.3))

#decision tree modelx
newscla.dt <- ctree(shares ~.,newscla[ind==1,])

#predict
newscla.dt.pred <- predict( newscla.dt,newscla[ind==2,], type="response")
newscla.dt.prob <- predict( newscla.dt,newscla[ind==2,], type="prob")
# Confusion matrix
confusionMatrix(newscla.dt.pred, newscla[ind==2,]$shares)
plot(newscla.dt)