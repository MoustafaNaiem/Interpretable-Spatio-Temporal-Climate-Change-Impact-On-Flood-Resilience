rm(list=ls())

#Upload dataset here
A1 <- read.csv("....", header = T, stringsAsFactors = FALSE)


Data1 <- A1[,-c(1:18)]
summary(Data1)
Data2<-Data1
for (i in 5:84){
  Data2[,c(i)] <- as.numeric(Data2[,c(i)])
}
Data2[,c(1)] <- as.factor(Data2[,c(1)])
Data2[,c(5:84)] <- scale(Data2[,c(5:84)], center = TRUE, scale = TRUE)

summary(Data2)
head(Data2,3)
str(Data2)


set.seed(123)
#Model 1
Data_RF300 <- DData2_B[,c(7,7+16, 7+32, 7+48, 7+64,  11, 11+16, 11+32, 11+48, 11+64,  13, 13+16, 13+32, 13+48, 13+64, 15, 15+16, 15+32, 15+48, 15+64, 16, 16+16, 16+32, 16+48, 16+64,
                          10, 10+16, 10+32, 10+48, 10+64)]

#Model trial
#Data_bagging <- Data2[,c(1,4+1,4+1+16,4+1+32,4+1+48,4+1+64)]

ind <- sample(2,nrow(Data_RF300), replace=TRUE, prob=c(0.7,0.3))
train <- Data_RF300[ind==1,]
#validate<-Data[ind==2,]
test <- Data_RF300[ind==2,]
train$Category <- as.factor(train$Category)
test$Category <- as.factor(test$Category)
str(train)
str(test)

#Random Forest
#install.packages("randomForest")
library(randomForest)
set.seed(222)
rf <- randomForest(Category~.,data=train, ntree=3000,mtry=6, method = "gbm",
                   importance=TRUE,
                   proximity=TRUE)
print(rf)
attributes(rf)
rf$confusion

#Prediction and Confusion Matrix - train data
library(caret)
p1 <- predict(rf,train[,-c(1)])
head(p1)
head(train$Category)
confusionMatrix(p1, train$Category)
tab <- confusionMatrix(p1, train$Category)
tab1 <- tab$table
tab1

#Prediction and Confusion Matrix - test data
p2<-predict(rf,test[,-c(1)])
confusionMatrix(p2,test$Category)

png(file=".../OOBError_RF_RCP8_2.png",
    width=1600, height=800, unit = "px", pointsize = 20)
par(omi = c(0.1,0.2,0,0))
par(las=1) # make label text perpendicular to axis
plot(rf, main = " ", lwd = 3, cex.lab = 1.5)
title(main = "Random Forest Out of Bag Error Rate RCP8.5", 
      xlab = NULL)
rf.legend <- if (is.null(rf$test$err.rate)) {colnames(rf$err.rate)} else {colnames(rf$test$err.rate)}
legend(x= "top", cex =1.1, legend=c("Average OOB","Category 1", "Category 2", "Category 3"), lty=c(1,2,3,4), col=c(1,2,3,4), horiz=T, bg = rgb(0, 0, 0,1, alpha = 0), lwd = 3)
dev.off()
### PDF
pdf(file="/.../OOBError_RF_RCP8_2.pdf",
    width=1600, height=800, pointsize = 1000)
par(omi = c(0.1,0.2,0,0))
par(las=1) # make label text perpendicular to axis
plot(rf, main = " ", lwd = 3, cex.lab = 1.5)
title(main = "Random Forest Out of Bag Error Rate RCP8.5", 
      xlab = NULL)
rf.legend <- if (is.null(rf$test$err.rate)) {colnames(rf$err.rate)} else {colnames(rf$test$err.rate)}
legend(x= "top", cex =1.1, legend=c("Average OOB","Category 1", "Category 2", "Category 3"), lty=c(1,2,3,4), col=c(1,2,3,4), horiz=T, bg = rgb(0, 0, 0,1, alpha = 0), lwd = 4)
dev.off()


#No. of nodes for trees
hist(treesize(rf),
     main="No of Nodes for the Trees",
     col="green")
#Variable importance
varImpPlot(rf)
importance(rf)
varUsed(rf)


########## Prediction
B <- read.csv("....../Excluded_Merged_Texas_RCP6_Final.csv", header = T, stringsAsFactors = FALSE)
head(B,2)
str(B)
Data_B <- B[,-c(1:3)]
summary(Data_B)
Data2_B<-Data_B
#for (i in 1:80){
#  Data2_B[,c(i)] <- as.numeric(Data2_B[,c(i)])
#}

Data2_B[,] <- scale(Data2_B, center = TRUE, scale = TRUE)

summary(Data2_B)
head(Data2_B,3)
str(Data2_B)

###
#Prediction_Data <- Data2_B[,c( 2, 2+16, 2+32, 2+48, 2+64,  5, 5+16, 5+32, 5+48, 5+64,  6, 6+16, 6+32, 6+48, 6+64, 8, 8+16, 8+32, 8+48, 8+64, 9, 9+16, 9+32, 9+48, 9+64,
#                               10, 10+16, 10+32, 10+48, 10+64,  12, 12+16, 12+32, 12+48, 12+64, 13, 13+16, 13+32, 13+48, 13+64)]
Prediction_Data <- Data2_B[,c(7,7+16, 7+32, 7+48, 7+64,  11, 11+16, 11+32, 11+48, 11+64,  13, 13+16, 13+32, 13+48, 13+64, 15, 15+16, 15+32, 15+48, 15+64, 16, 16+16, 16+32, 16+48, 16+64,
                               10, 10+16, 10+32, 10+48, 10+64)]

Prediction_result <- predict(rf, Prediction_Data, type="response", method = "gbm",
        norm.votes=TRUE, predict.all=FALSE, proximity=FALSE, nodes=FALSE)







