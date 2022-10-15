cat("\014")
rm(list=ls())
library(caret)
library(party)
library(rpart)
library(e1071)
library(caTools)
library("compareDF")
library(arsenal)

#https://archive.ics.uci.edu/ml/datasets/Breast+Cancer+Wisconsin+%28Diagnostic%29

bstdata<-read.csv("F:/My programs/R/R data/breast_cancer.csv" , header=TRUE)

bstdata<-subset(bstdata,select=-c(id))

bstdata$factor<-factor(bstdata$diagnosis)

bstdata<-subset(bstdata,select=-c(diagnosis))

head(bstdata)

str(bstdata)

#bstdata

set.seed(1)
#A series of test/training partitions are created using createDataPartition 
#while createResample creates one or more bootstrap samples. createFolds splits
#the data into k groups while createTimeSlices creates cross-validation split for
#series data. groupKFold splits the data based on a grouping factor.
#intrain<-createDataPartition(y=bstdata$diagnosis,p=0.7,list=FALSE)

sample<-sample.split( bstdata$factor , SplitRatio=0.7)


train<-subset(bstdata , sample == TRUE)


test<-subset(bstdata , sample == FALSE)

dim(train)

dim(test)

#test

#train

summary(bstdata)
dim(bstdata)

dim(train)
dim(test)


dtree<-ctree(factor~.,data=train)

dtree

plot(dtree,main="all parameter with no pruning")

dtree2<-ctree(factor~.,data=train ,controls=ctree_control(mincriterion=0.99))

dtree2

plot(dtree2 ,main="Minceriterion=0.99,all parameters")

testresult<-predict(dtree2,test,type="response")

comparedf(testresult,bstdata$diagnosis)


library(rpart)

tree<-rpart(factor~.,train)

library("rpart.plot")

rpart.plot(tree,main="all parameters")

rpart.plot(tree,extra=1 ,main="all parameters,numbers of each")

rpart.plot(tree,extra=2,main="all parameters,fractions")

rpart.plot(tree,extra=3 ,main="all parameters,leftover fractions")

rpart.plot(tree,extra=4 ,main="all patramters,probablity")

test2results<-predict(tree,test ,type="class")
test2results
comparedf(test2results,test$factor)
checkit<-test$factor
check<-test2results %in% bstdata

check<-testresult %in% bstdata

check

check<-test2results %in% testresult