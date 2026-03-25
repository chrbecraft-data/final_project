here::i_am("code/02_make_figure.R")

#Libraries
library(ggplot2)
library(caTools)
library(reshape2)
library(dplyr)

#Read in clean data  
data <- readRDS(
  file = here::here("output/data_clean.rds")
)

#Binarize outcome
data <- data |>
  mutate(coke_bin = if_else(coke == "Never used", 0, 1))

#Split data
split <- sample.split(data$coke_bin, SplitRatio = 0.8)
train_data <- subset(data, split == "TRUE")
test_data <- subset(data, split == "FALSE")

log_model <- glm(coke_bin ~ age + gender + education + country + ethnicity,
                 data = train_data,
                 family = "binomial")

#Make predictions on test data
test_predictions <- predict(log_model,
                            test_data, type = "response")
test_predictions <- as.data.frame(test_predictions)

#Create confusion matrix
bin_prediction <- ifelse(test_predictions > 0.5, 1, 0)
conf_matrix <- table(test_data$coke_bin, bin_prediction)
conf_matrix_df <- as.data.frame(conf_matrix)
colnames(conf_matrix_df) <- c("Actual", "Predicted", "Count")

#Create visualization of confusion matrix
figure <- ggplot(conf_matrix_df, aes(x = Actual, y = Predicted, fill = Count)) +
  geom_tile() +
  geom_text(aes(label = Count), color = "black", size = 6) +  # Add text labels
  scale_fill_gradient(low = "white", high = "blue") +
  labs(title = "Confusion Matrix Heatmap", x = "Actual", y = "Predicted") +
  theme_minimal()

#Save figure for report
saveRDS(
  figure,
  file = here::here("output/figure.rds")
)