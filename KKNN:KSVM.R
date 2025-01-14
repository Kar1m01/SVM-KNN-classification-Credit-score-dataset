install.packages("ggplot2")
library(ggplot2)

#Step 1: Loading data and checking structure.

#Loading the data

credit_dataset<- read.table("~/Downloads/hw1 (1)/data 2.2/credit_card_data-headers.txt", header = TRUE)

#assigning column 11 as a factor or a target variable
credit_dataset[,11] <- as.factor(credit_dataset[,11])

#Making sure it is a factor/ target Variable
is.factor(credit_dataset[,11])

str(credit_dataset)


# Step 2: Configuring the SVM module and training it.

install.packages("kernlab")
library(kernlab)

svm_model <-ksvm(as.matrix(credit_dataset[,1:10]),credit_dataset[,11], 
     type="C-svc", kernel="vanilladot", C=13, scaled=TRUE)
                         
print(credit_svm_model)

#Step 3: Calculating coefficients and the intercept(Bias)

a <- colSums(svm_model@xmatrix[[1]] * svm_model@coef[[1]])
print(a)
a0 <- -svm_model@b
print(a0)

# Step 4: Predict function

SVM_prediction <- predict(svm_model, as.matrix(credit_dataset[1:10]))
SVM_accuracy <- sum(SVM_prediction == credit_dataset[,11]) / nrow(credit_dataset)
print(SVM_accuracy)

#Step 5: Tuning the C Parameter to get the best classifier for the existing dataset.

#THIS PART OF THE CODE IS PROVIDED BY CHATGPT!

# Try different C values
#We will use  for loop to try multiple C parameters to check their accuracy and then choose the best classifier

for (C_value in c(0.1, 1, 10, 100)) {
  svm_model <- ksvm(as.matrix(credit_dataset[,1:10]), credit_dataset[,11], 
                    type="C-svc", kernel="vanilladot", C=C_value, scaled=TRUE)
  svm_predictions <- predict(svm_model, as.matrix(credit_dataset[,1:10]))
  svm_accuracy <- sum(svm_predictions == credit_dataset[,11]) / nrow(credit_dataset)
  cat("C =", C_value, ", Accuracy =", svm_accuracy, "\n")
  
  
}


#No matter what the C parameter is, the accuracy remains constant @ 0.84 (approx)

#So I decided to visualize the data with the ggplot2 package to see if the dataset is linearly seperable, which might explain the ineffectivness of the C parameter changes.

#PART OF THIS CODE IS PROVIDED BY CHATGPT!

library(ggplot2)
pca <- prcomp(credit_dataset[,1:10], scale=TRUE)
pca_data <- data.frame(PC1 = pca$x[,1], PC2 = pca$x[,2], Class = credit_dataset[,11])
ggplot(pca_data, aes(x = PC1, y = PC2, color = Class)) + 
  geom_point() + 
  theme_minimal()


#So as after checking the scatter plot, it appears that the data is not linearly seperable, which means that the problem might be related to the vanilladot linear kernel.

#OPTIONAL PART: we are going to try a different kernel, this time we are going to use RBF (Radial) which is non-linear, using the previous code but this time instead of "vanilladot", we are going to use "rbfdot

svm_model_rbf <- ksvm(as.matrix(credit_dataset[,1:10]), credit_dataset[,11], 
                      type="C-svc", kernel="rbfdot", C=1, scaled=TRUE)

svm_predictions_rbf <- predict(svm_model_rbf, as.matrix(credit_dataset[,1:10]))
svm_accuracy_rbf <- sum(svm_predictions_rbf == credit_dataset[,11]) / nrow(credit_dataset)

#Radial basis has a better accuracy rate than the vanilladot function, it's not significantly better though..



#PART2 OF Q2.2: KNN Approach..

install.packages("kknn")



library(kknn)
#after trying a few times the k=5 returned the best accuracy rate.
knn_model <- kknn(credit_dataset[,11] ~ ., 
                  train=data.frame(credit_dataset),
                  test=data.frame(credit_dataset),
                  k=5,
                  scale=TRUE)

knn_predictions <- ifelse(as.numeric(fitted(knn_model)) > 0.5, 1, 0) #Claude helped to link the prediction
knn_accuracy <- sum(knn_predictions == credit_dataset[,11]) / nrow(credit_dataset)





