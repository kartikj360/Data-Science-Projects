cat("\014")
rm(list=ls())
library(caret)
library(party)
library(rpart)
library(e1071)
library(caTools)
library("compareDF")
library(arsenal)

#website from where the dataset was picked up
#https://archive.ics.uci.edu/ml/datasets/Breast+Cancer+Wisconsin+%28Diagnostic%29

#reading the csv file from the system
bstdata<-read.csv("F:/My programs/R/R data/breast_cancer.csv" , header=TRUE)

#seeing the top rows of the data
head(bstdata)

#drop the column id because it of no use for the analysis 
bstdata<-subset(bstdata,select=-c(id))

#converting char to factor so that the data set classification can be easily interpret by the function
bstdata$factor<-factor(bstdata$diagnosis)

#droping the diagnosis as factor is already obtained on above step
bstdata<-subset(bstdata,select=-c(diagnosis))


#Compactly display the internal structure of an R object,
str(bstdata)

#bstdata

#seting up seed so that the data can be partitioned
set.seed(1)
#A series of test/training partitions are created using createDataPartition 
#while createResample creates one or more bootstrap samples. createFolds splits
#the data into k groups while createTimeSlices creates cross-validation split for
#series data. groupKFold splits the data based on a grouping factor.

#split divides the data in the vector x into the groups defined by f.
# The replacement forms replace values corresponding to such a divisionunsplit reverses the effect of split.
sample<-sample.split( bstdata$factor , SplitRatio=0.7)

#Returns subsets of a data.table.
train<-subset(bstdata , sample == TRUE)


test<-subset(bstdata , sample == FALSE)

#Retrieve or set the dimension of an object.
dim(train)

dim(test)

#test

#train

#summary is a generic function used to produce result summaries of the results of various model fitting functions.
summary(bstdata)

dim(bstdata)

dim(train)
dim(test)

#Recursive partitioning for continuous, censored, ordered, nominal and multivariate response variables in a conditional inference framework.
dtree<-ctree(factor~.,data=train)
 
#print the tree
dtree

#graphical represntation of the tree
plot(dtree,main="all parameter with no pruning")


#the value of the test statistic (for testtype == "Teststatistic"), or 
#1 - p-value (for other values of testtype) that must be exceeded in order to\
#mplement a split. 
#having mincritreria of 0.99 purity of the node
dtree2<-ctree(factor~.,data=train ,controls=ctree_control(mincriterion=0.99))

dtree2

#graphical represntation of the data
plot(dtree2 ,main="Minceriterion=0.99,all parameters")

#testing the data over the test data
testresult<-predict(dtree2,test,type="response")

testresult

#misclassfication error of the model
table<-table(predict(dtree2),train$factor)

#table to check missclassification
table

#obtaining the diagonal sum of the table
sum(diag(table))

#error in false fraction
value=1-sum(diag(table))/sum(table)

#percentange value
percentage=value*100

#Final result
answer<-paste(percentage,"% of error form the model")

answer
confusionMatrix(testresult,test$factor)








#using rpart library as diffent approach
library(rpart)

#rpart model
tree<-rpart(factor~.,train)

#library for ploting the tree
library("rpart.plot")

#graphical reperentation of the tree
rpart.plot(tree,main="all parameters")

#number of each class
#Display the number of observations that fall in the node (per class for class
#objects; prefixed by the number of events for poisson and exp models).
rpart.plot(tree,extra=1 ,main="all parameters,numbers of each")

#fraction of labelof each class
#Class models: display the classification rate at the node, expressed as the
#number of correct classifications and the number of observations in the node.
#Poisson and exp models: display the number of events.
rpart.plot(tree,extra=2,main="all parameters,fractions")

#1-true fraction
#misclassification rate at the node, expressed as the number of
#incorrect classifications and the number of observations in the node.
rpart.plot(tree,extra=3 ,main="all parameters,leftover fractions")

#probability of each class
#probability per class of observations in the node (conditioned
#on the node, sum across a node is 1)
rpart.plot(tree,extra=4 ,main="all patramters,probablity")

#Displays the cp(complexity parameter) table for fitted rpart object.
printcp(tree)

#Gives a visual representation of the cross-validation results in an rpart object.
plotcp(tree,main="CP plot")

#obtaining the predicition results on the test data
test2results<-predict(tree,test,type="class")

test2results

#misclassfication error of the model
table2<-table(test2results,test$factor)

#table to check missclassification
table2


#obtaining the diagonal sum of the table
sum(diag(table2))

#error in false fraction
value2=1-sum(diag(table2))/sum(table2)

#percentange value
percentage2=value*100

#Final result
answer2<-paste(percentage2,"% of error form the model by rpart")


answer2
confusionMatrix(test2results,test$factor)
    