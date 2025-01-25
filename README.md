# CV and Clustering Project

## Overview
This project explores **Cross-Validation (CV) and Clustering** techniques using R. It includes:
- **K-Nearest Neighbors (KNN) Cross-Validation**
- **Support Vector Machine (SVM) Data Splitting**
- **K-Means Clustering**

The project involves data preprocessing, model training, validation, and performance evaluation.

## Dependencies
The project is implemented in **R** and uses the following libraries:
```r
library(ggplot2)
library(kknn)
library(kernlab)
library(caret)
```

## Dataset
The project uses **credit card data** and **Iris dataset** from the UC Irvine machine learning repository:
- **Credit Card Data:** Used for KNN and SVM classification.
- **Iris Dataset:** Used for K-Means Clustering.

## Steps & Methodology
### 1. **Preprocessing**
- Load data from CSV files.
- Standardize numerical features.
- Convert categorical data to factors.

### 2. **Cross-Validation on KNN**
- **4-fold Cross-Validation** applied.
- Optimal **K-value** selection using `trainControl()`.
- Model evaluation using RMSE and R-Squared.

```r
training_control <- trainControl(method = "cv", number= 4)
knn_model <- train(R1~ ., data=data, method="kknn", trControl=training_control, tuneLength=5)
```

### 3. **Splitting Data for SVM**
- **Manual splitting**: 70% training, 20% validation, 10% testing.
- Train **SVM model with RBF kernel**.

```r
svm_model <- ksvm(R1 ~ ., data= train_data, kernel= "rbfdot", C=1)
```

### 4. **K-Means Clustering on Iris Data**
- **Feature Scaling** applied.
- **Elbow Method** used to determine the optimal number of clusters.
- Performance evaluated using clustering accuracy.

```r
kmeans_calc <- kmeans(iris_scaled, centers=3, nstart=25)
table(kmeans_calc$cluster, iris$Species)
```

## Results
- **KNN Cross-Validation:** Optimal K = 13, RMSE minimized.
- **SVM Model:** Validation accuracy = 83.9%, Testing accuracy = 84.6%.
- **K-Means Clustering:** Best clustering results obtained using **Petal features** (Setosa: 100%, Versicolor: 96%, Virginica: 92%).

## Conclusion
- **Cross-validation improves KNN model accuracy.**
- **SVM with RBF kernel performs well for classification tasks.**
- **Clustering results depend on feature selection.**

## Future Improvements
- Try **other clustering techniques** like DBSCAN.
- Apply **hyperparameter tuning** on SVM.
- Explore **dimensionality reduction** before clustering.

---

### Author: **Karim Akram** (January 2025)

