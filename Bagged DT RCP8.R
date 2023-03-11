#Model 1, bagged decision trees. 
rm(list=ls())
install.packages("rlang")
local({r <- getOption("repos")
r["CRAN"] <- "http://cran.r-project.org" 
options(repos=r)})
install.packages("https://cran.r-project.org/src/contrib/Archive/rlang/rlang_1.0.1.tar.gz", repo=NULL, type="source") # for specific rlang version, in this case 0.4.9. For latest version can run install.packages("rlang")
packageVersion("rlang") #to check you now have rlang version you want

A1 <- read.csv(".../Merged_Texas counties_RCP8_16Models_3Cats.csv", header = T, stringsAsFactors = FALSE)
#A1 <- read.csv("/.../Merged_Texas counties_RCP6_3Cats.csv", header = T, stringsAsFactors = FALSE)

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
#Best Performance Models: 
#  35539: Misclass Error 0.4545, Models: 2,5,6,8,9,10,12,13
#  14796: Misclass error 0.4855, Models: 7,10,11,13,15,16


library(dplyr)       #for data wrangling
library(ggplot2)     #for creating plots
library(e1071)       #for calculating variable importance
library(caret)       #for general model fitting
library(rpart)       #for fitting decision trees
library(ipred)       #for fitting bagged decision trees
library(tree)
library(ipred)
install.packages("ipred")



set.seed(123)
#Model 1: 1,2,3,5,9,11,12,14,15,16
Data_bagging <- Data2[,c(1,4+1,4+1+16,4+1+32,4+1+48,4+1+64, 4+2,4+2+16,4+2+32,4+2+48,4+2+64, 4+3,4+3+16,4+3+32,4+3+48,4+3+64, 4+5,4+5+16,4+5+32,4+5+48,4+5+64, 4+6,4+6+16,4+6+32,4+6+48,4+6+64, 4+9,4+9+16,4+9+32,4+9+48,4+9+64, 
                         4+11,4+11+16,4+11+32,4+11+48,4+11+64, 4+12,4+12+16,4+12+32,4+12+48,4+12+64, 4+14,4+14+16,4+14+32,14+48,4+14+64, 4+15,4+15+16,4+15+32,4+15+48,4+15+64,4+16,4+16+16,4+16+32,4+16+48,4+16+64)]

ind <- sample(2,nrow(Data_bagging), replace=TRUE, prob=c(0.7,0.3))
train <- Data_bagging[ind==1,]
#validate<-Data[ind==2,]
test <- Data_bagging[ind==2,]
train$Category <- as.factor(train$Category)
test$Category <- as.factor(test$Category)
str(train)
str(test)

library(rpart)
#Training Dataset
set.seed(1)

#fit the bagged model
Data5.bagging <- bagging(
  formula = Category~.,
  data = train,
  nbagg = 150,   
  coob = TRUE,
  control = rpart.control(minsplit = 2, cp = 0)
)



predicted_classes_Train <- predict(Data5.bagging, train[,-c(1)]) #Test on training dataset
train$prediction <- predicted_classes_Train
head(train)
tab<-with(train, table(Category, prediction))
tab
1-sum(diag(tab))/sum(tab)

#Testing Dataset
predicted_classes_Test <- predict(Data5.bagging, test[,-c(1)]) #Test on training dataset
test$prediction <- predicted_classes_Test
head(test)
str(test$Category)
tab1<-with(test, table(Category, prediction))
tab1
1-sum(diag(tab1))/sum(tab1)
#########################################################################################################
#Visualization of importance of variables w keda
var <- names(train[,-c(1,42)])
var
imp <- varImp(Data5.bagging)
VI<- data.frame(var,imp)
#sort variable importance descending
VI_plot <- VI[order(VI$Overall, decreasing=FALSE),]
png(file=".../Variable_inportance_BaggedDT_RCP8_TIMESNEWROMAN.png",
    width=1000, height=1500, unit = "px", pointsize = 20)
par(omi = c(1,0.5,0,0))
par(las=1) # make label text perpendicular to axis
barplot(VI_plot$Overall,
        names.arg=rownames(VI_plot),
        horiz=TRUE,
        col='steelblue',
        xlab='Variable Importance',
        font.axis=1, family = "times")
dev.off()





B <- read.csv(".../Excluded_Merged_Texas_RCP8_Final_16Models.csv", header = T, stringsAsFactors = FALSE)
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
#Prediction_Data <- Data2_B[,c(1,1+16,1+32,1+48,1+64, 2,2+16,2+32,2+48,2+64, 3,3+16,3+32,3+48,3+64, 5,5+16,5+32,5+48,5+64, 9,9+16,9+32,9+48,9+64, 11,11+16,11+32,11+48,11+64,
 # 12,12+16,12+32,12+48,12+64, 14,14+16,14+32,14+48,14+64, 15,15+16,15+32,15+48,15+64,16,16+16,16+32,16+48,16+64)]

Prediction_Data <- Data2_B[,c(7,7+16, 7+32, 7+48, 7+64,  11, 11+16, 11+32, 11+48, 11+64,  13, 13+16, 13+32, 13+48, 13+64, 15, 15+16, 15+32, 15+48, 15+64, 16, 16+16, 16+32, 16+48, 16+64,
                               10, 10+16, 10+32, 10+48, 10+64)]



#Prediction_Data <- Data2_B[,c(1,1+16,1+32,1+48,1+64)]
head(Prediction_Data,2)
str(Prediction_Data)

predicted_classes_final <- predict(Data5.bagging, Prediction_Data) #Test on training dataset
Prediction_Data$prediction <- predicted_classes_final
head(Prediction_Data)
str(Prediction_Data)
y <- hist(as.numeric(Prediction_Data$prediction))
y
Prediction_Data$County <- B$County
Prediction_Data$Month <- B$Month
Prediction_Data$Year <- B$Year

write.table(Prediction_Data, file="Prediction Output Bagged DT RCP8_trial_3cats.csv", sep=",", row.names = FALSE, col.names = TRUE)
###############################################################################################################################################

table(Prediction_Data$prediction)
table(Data_bagging$Category)


