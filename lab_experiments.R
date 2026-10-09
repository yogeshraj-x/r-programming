# ITA04 - Statistics with R Programming
# Lab Experiments: Solutions 1-21
# Run section-by-section in R/RStudio. Some sections require optional packages/data files;
# setup notes are included where needed.

# ------------------------------ 1. Vectors ------------------------------
numeric_vector <- c(10, 20.5, -3, 8)
character_vector <- c("R", "Statistics", "Programming")
logical_vector <- c(TRUE, FALSE, TRUE, TRUE)

for (x in list(numeric_vector, character_vector, logical_vector)) {
  print(x)
  print(typeof(x))
  print(class(x))
}

# ------------------------------ 2. Labeled matrices ------------------------------
m5x4 <- matrix(1:20, nrow = 5, ncol = 4, byrow = TRUE,
               dimnames = list(paste0("Row", 1:5), paste0("Col", 1:4)))
m3x3 <- matrix(1:9, nrow = 3, ncol = 3, byrow = FALSE,
               dimnames = list(paste0("R", 1:3), paste0("C", 1:3)))
m2x2 <- matrix(1:4, nrow = 2, ncol = 2, byrow = TRUE,
               dimnames = list(c("Top", "Bottom"), c("Left", "Right")))
print(m5x4); print(m3x3); print(m2x2)

# ------------------------------ 3. Three-dimensional array ------------------------------
arr3d <- array(1:24, dim = c(3, 4, 2),
               dimnames = list(paste0("Row", 1:3), paste0("Col", 1:4),
                               paste0("Table", 1:2)))
print(arr3d)
cat("Dimensions:", dim(arr3d), "\n")

# ------------------------------ 4. Array dimension names and elements ------------------------------
values <- 1:12
named_array <- array(values, dim = c(2, 3, 2),
                     dimnames = list(c("A", "B"), c("X", "Y", "Z"),
                                     c("First", "Second")))
print(named_array)
cat("Element B, Y, Second:", named_array["B", "Y", "Second"], "\n")
cat("Element A, X, First:", named_array["A", "X", "First"], "\n")

# ------------------------------ 5. Factors ------------------------------
# The built-in women dataset contains heights and weights, not individual gender labels.
data(women)
height_group <- cut(women$height, breaks = 3,
                    labels = c("Short", "Medium", "Tall"), include.lowest = TRUE)
print(height_group)
print(factor(sample(LETTERS, 10, replace = FALSE)))
print(factor(c("Low", "High", "Medium", "High"),
             levels = c("Low", "Medium", "High"), ordered = TRUE))

# ------------------------------ 6. List with vectors, matrix and function ------------------------------
my_function <- function(x) x^2
my_list <- list(numbers = c(2, 4, 6), words = c("one", "two"),
                matrix = matrix(1:4, nrow = 2),
                square = my_function)
print(my_list)
print(my_list$square(5))

# ------------------------------ 7. Factors, random integers, FizzBuzz ------------------------------
number <- 36
if (number < 1 || number != as.integer(number)) stop("Use a positive integer.")
cat("Factors of", number, ":", which(number %% 1:number == 0), "\n")
set.seed(123)
random_integers <- sample(-50:50, size = 10, replace = TRUE)
print(random_integers)
for (i in 1:100) {
  if (i %% 15 == 0) cat("FizzBuzz\n")
  else if (i %% 3 == 0) cat("Fizz\n")
  else if (i %% 5 == 0) cat("Buzz\n")
  else cat(i, "\n")
}

# ------------------------------ 8. Normal random numbers and occurrence counts ------------------------------
set.seed(123)
normal_values <- rnorm(1000, mean = 0, sd = 1)
print(head(normal_values, 10))
# Count values in intervals; cut() creates readable bins.
normal_bins <- cut(normal_values,
                   breaks = c(-Inf, -2, -1, 0, 1, 2, Inf),
                   labels = c("< -2", "-2 to -1", "-1 to 0", "0 to 1",
                              "1 to 2", "> 2"), right = FALSE)
print(table(normal_bins))

# ------------------------------ 9. Empty plots with axis limits ------------------------------
plot(NA, xlim = c(0, 10), ylim = c(-5, 5),
     xlab = "X", ylab = "Y", main = "Empty Plot (0 to 10, -5 to 5)")
plot.new()
plot.window(xlim = c(-2, 2), ylim = c(0, 20))
title(main = "Second Empty Plot", xlab = "X", ylab = "Y")
axis(1); axis(2)

# ------------------------------ 10. Data frame operations ------------------------------
exam_data <- data.frame(
  name = c("Anu", "Bala", "Charan", "Divya", "Ezhil"),
  score = c(88, 55, 72, 39, 91),
  attempts = c(1, 3, 2, 4, 1),
  qualify = c("yes", "no", "yes", "no", "yes"),
  stringsAsFactors = FALSE
)
print(exam_data)
print(exam_data[exam_data$score >= 70, ])     # extract rows
exam_data$grade <- ifelse(exam_data$score >= 60, "Pass", "Needs improvement")
exam_data <- rbind(exam_data,
                   data.frame(name = "Farah", score = 66, attempts = 2,
                              qualify = "yes", grade = "Pass"))
exam_data <- cbind(exam_data, score_plus_5 = exam_data$score + 5)
print(exam_data[order(exam_data$score, decreasing = TRUE), ])
write.csv(exam_data, "exam_data.csv", row.names = FALSE)
cat("Saved exam_data.csv in:", getwd(), "\n")

# ------------------------------ 11. Read a CSV file ------------------------------
# Put a file named input.csv in the working directory, or change the path below.
csv_path <- "input.csv"
if (file.exists(csv_path)) {
  csv_data <- read.csv(csv_path, stringsAsFactors = FALSE)
  print(csv_data)
} else {
  message("To run Experiment 11, place input.csv in the working directory.")
  message("Example: csv_data <- read.csv('your_file.csv'); print(csv_data)")
}

# ------------------------------ 12. Reshape airquality and monthly averages ------------------------------
# Install once if needed: install.packages("reshape2")
if (requireNamespace("reshape2", quietly = TRUE)) {
  library(reshape2)
  aq <- transform(datasets::airquality, Month = factor(Month))
  aq_long <- melt(aq, id.vars = c("Month", "Day"),
                  measure.vars = c("Ozone", "Solar.R", "Wind", "Temp"),
                  variable.name = "Measurement", value.name = "Value")
  print(head(aq_long))
  aq_cast <- dcast(aq_long, Month ~ Measurement, fun.aggregate = function(x)
    mean(x, na.rm = TRUE))
  print(aq_cast)
  monthly_averages <- aggregate(cbind(Ozone, Solar.R, Wind, Temp) ~ Month,
                                data = datasets::airquality,
                                FUN = function(x) mean(x, na.rm = TRUE))
  print(monthly_averages)
} else {
  message("Experiment 12 requires reshape2. Install with install.packages('reshape2').")
}

# ------------------------------ 13. Combine arrays row-wise ------------------------------
array1 <- matrix(1:6, nrow = 2, byrow = TRUE)
array2 <- matrix(7:12, nrow = 2, byrow = TRUE)
combined_rows <- rbind(array1, array2)
print(array1); print(array2); print(combined_rows)

# ------------------------------ 14. ChickWeight: sort, melt and cast by Diet ------------------------------
data(ChickWeight)
chick <- ChickWeight
print(head(chick[order(chick$weight, decreasing = TRUE), ]))
if (requireNamespace("reshape2", quietly = TRUE)) {
  library(reshape2)
  # Reshape the built-in dataset using its actual column names:
  chick_long <- melt(chick, id.vars = c("Chick", "Time", "Diet"),
                     variable.name = "Measure", value.name = "Value")
  print(head(chick_long))
  chick_cast <- dcast(chick_long, Diet ~ Time, value.var = "Value",
                      fun.aggregate = mean)
  print(chick_cast)
} else {
  message("Experiment 14 reshaping requires reshape2; sorting works without it.")
}
print(aggregate(weight ~ Diet, data = chick, FUN = mean))

# ------------------------------ 15. EDA on iris ------------------------------
data(iris)
cat("Dimensions:\n"); print(dim(iris))
cat("Summary:\n"); print(summary(iris))
cat("Standard deviations:\n"); print(sapply(iris[1:4], sd))
cat("Quantiles:\n"); print(sapply(iris[1:4], quantile))
cat("Means by Species:\n"); print(aggregate(. ~ Species, data = iris, FUN = mean))
cat("Pivot table (Species by Sepal.Length category):\n")
iris$SepalLengthCategory <- cut(iris$Sepal.Length,
                                breaks = c(-Inf, 5, 6, Inf),
                                labels = c("Short", "Medium", "Long"))
print(with(iris, table(Species, SepalLengthCategory)))

# ------------------------------ 16. EDA on USArrests ------------------------------
data(USArrests)
print(summary(USArrests))
cat("State with largest Rape value:", rownames(USArrests)[which.max(USArrests$Rape)], "\n")
cat("Maximum Murder:", max(USArrests$Murder), "State:",
    rownames(USArrests)[which.max(USArrests$Murder)], "\n")
cat("Minimum Murder:", min(USArrests$Murder), "State:",
    rownames(USArrests)[which.min(USArrests$Murder)], "\n")
print(cor(USArrests))
print(USArrests[USArrests$Assault > median(USArrests$Assault), ])
murder_q1 <- quantile(USArrests$Murder, 0.25)
print(USArrests[USArrests$Murder <= murder_q1, ])
hist(USArrests$Murder, main = "Murder Arrest Rates", xlab = "Murder", col = "grey")
plot(density(USArrests$Assault), main = "Density of Assault Arrest Rates")
plot(USArrests$UrbanPop, USArrests$Murder, xlab = "Urban Population (%)",
     ylab = "Murder Arrest Rate", main = "Urban Population vs Murder")
pairs(USArrests, main = "USArrests Scatterplot Matrix")
barplot(sort(USArrests$Murder, decreasing = TRUE)[1:10],
        names.arg = names(sort(USArrests$Murder, decreasing = TRUE)[1:10]),
        las = 2, main = "10 Highest Murder Rates", ylab = "Murder")

# ------------------------------ 17. Titanic charts ------------------------------
# Base R's Titanic dataset is aggregated counts (it has no Age column).
data(Titanic)
titanic_df <- as.data.frame(Titanic)
survival_class <- aggregate(Freq ~ Survived + Class, data = titanic_df, sum)
barplot(table(titanic_df$Class, titanic_df$Survived),
        beside = TRUE, legend.text = TRUE,
        main = "Titanic Survival by Class", xlab = "Passenger Class", ylab = "Count")
survival_gender <- aggregate(Freq ~ Survived + Sex, data = titanic_df, sum)
barplot(table(titanic_df$Sex, titanic_df$Survived),
        beside = TRUE, legend.text = TRUE,
        main = "Titanic Survival by Sex", xlab = "Sex", ylab = "Count")
# For an age histogram, use an individual-passenger dataset with an Age column.
# Example if you have titanic.csv: titanic_people <- read.csv("titanic.csv")
if (file.exists("titanic.csv")) {
  titanic_people <- read.csv("titanic.csv")
  if ("Age" %in% names(titanic_people)) {
    hist(titanic_people$Age, na.rm = TRUE, main = "Titanic Passenger Ages",
         xlab = "Age", col = "grey")
  } else message("titanic.csv exists but has no Age column.")
} else {
  message("Base R Titanic data has no Age variable; provide titanic.csv with an Age column for this histogram.")
}

# ------------------------------ 18. Common graph types ------------------------------
data(iris)
boxplot(Sepal.Length ~ Species, data = iris, main = "Sepal Length by Species",
        xlab = "Species", ylab = "Sepal Length")
hist(iris$Sepal.Length, main = "Sepal Length Histogram", xlab = "Sepal Length")
barplot(table(iris$Species), main = "Iris Count by Species", xlab = "Species")
plot(1:10, cumsum(1:10), type = "l", main = "Line Chart",
     xlab = "X", ylab = "Cumulative Sum")
plot(iris$Sepal.Length, iris$Petal.Length, col = as.integer(iris$Species),
     pch = 19, main = "Sepal vs Petal Length", xlab = "Sepal Length",
     ylab = "Petal Length")
legend("topleft", legend = levels(iris$Species), col = 1:3, pch = 19)

# ------------------------------ 19. Regression: Sales ~ Spend ------------------------------
# Supply advertising.csv with numeric columns named Spend and Sales.
if (file.exists("advertising.csv")) {
  advertising <- read.csv("advertising.csv")
  if (all(c("Spend", "Sales") %in% names(advertising))) {
    advertising_model <- lm(Sales ~ Spend, data = advertising)
    print(summary(advertising_model))
    advertising$Predicted_Sales <- predict(advertising_model, newdata = advertising)
    print(head(advertising))
    plot(advertising$Spend, advertising$Sales, pch = 19,
         xlab = "Spend", ylab = "Sales", main = "Sales vs Spend")
    abline(advertising_model, lwd = 2)
    new_spend <- data.frame(Spend = 100)
    print(predict(advertising_model, newdata = new_spend,
                  interval = "prediction"))
  } else {
    message("advertising.csv must contain numeric columns named Spend and Sales.")
  }
} else {
  message("Experiment 19 needs advertising.csv with columns Spend and Sales; no dataset was supplied.")
}

# ------------------------------ 20. Multiple regression: ChickWeight ------------------------------
data(ChickWeight)
chick_model <- lm(weight ~ Time + Diet, data = ChickWeight)
print(summary(chick_model))
chick_predictions <- predict(chick_model, newdata = ChickWeight)
mae <- mean(abs(ChickWeight$weight - chick_predictions))
rmse <- sqrt(mean((ChickWeight$weight - chick_predictions)^2))
cat("MAE:", mae, "\nRMSE:", rmse, "\n")
new_chick <- data.frame(Time = c(10, 20), Diet = factor(c("1", "3"),
                                      levels = levels(ChickWeight$Diet)))
print(predict(chick_model, newdata = new_chick, interval = "prediction"))

# ------------------------------ 21. Iris train/test classification ------------------------------
# Species has 3 classes, so multinomial logistic regression is appropriate.
# Install once if needed: install.packages("nnet")
data(iris)
set.seed(123)
train_rows <- sample(seq_len(nrow(iris)), size = floor(0.8 * nrow(iris)))
train_data <- iris[train_rows, ]
test_data <- iris[-train_rows, ]
if (requireNamespace("nnet", quietly = TRUE)) {
  iris_model <- nnet::multinom(Species ~ Petal.Length + Petal.Width,
                               data = train_data, trace = FALSE)
  predicted_species <- predict(iris_model, newdata = test_data)
  confusion_matrix <- table(Actual = test_data$Species, Predicted = predicted_species)
  print(confusion_matrix)
  accuracy <- sum(diag(confusion_matrix)) / sum(confusion_matrix)
  cat("Test accuracy:", round(accuracy * 100, 2), "%\n")
} else {
  message("Experiment 21 requires nnet. Install with install.packages('nnet').")
}
