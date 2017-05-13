library(randomForest)
library(caret)
library(ggplot)

news = read.csv("OnlineNewsPopularity.csv" , header = TRUE)
newsreg <- subset( news, select = -c(url, timedelta ) )
for(i in ncol(newsreg)-1){ 
  newsreg[,i]<-scale(newsreg[,i], center = TRUE, scale = TRUE)
}
newscla <- newsreg
newscla$shares <- as.factor(ifelse(newscla$shares > 1400,1,0))
#barplot(prop.table(table(newscla$shares)))
set.seed(100)
ind <- sample(2,nrow(newscla),replace=TRUE,prob=c(0.7,0.3))
#random forest model
newscla.rf <- randomForest(shares ~.,newscla[ind==1,],ntree=50,nPerm=10,mtry=3,proximity=TRUE,importance=TRUE)
saveRDS(newscla.rf , "newsrf.rds")

#predict
newscla.rf.pred <- predict( newscla.rf,newscla[ind==2,], type="class")
newscla.rf.prob <- predict( newscla.rf,newscla[ind==2,], type="prob")
# Confusion matrix
confusionMatrix(newscla.rf.pred, newscla[ind==2,]$shares)
