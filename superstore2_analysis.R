# Load Libraries 
library(tidyverse)
library(dplyr)
library(ggplot2)

# Load the dataset.
superstore <- read_csv("superstore.csv", show_col_types = FALSE)
superstore

# Data Preparation: Check the dataset before analysis. inspect dataset structure. check missing values. confirm numeric columns (Sales, Profit, Discount)
str(superstore)
anyNA(superstore)
colSums(is.na(superstore))
class(superstore$Sales)
class(superstore$Profit)
class(superstore$Discount)

# Total Sales Function: Create a function: calculate_total_sales(). The function should: take the dataset as argument, calculate total Sales. Run it on the dataset.
calculate_total_sales <- function(data){
  total_sales = sum(data$Sales)
  return(total_sales)
}
calculate_total_sales(superstore)

# Total Profit Function: Create a function: calculate_total_profit(). The function should: take dataset as argument, calculate total Profit
calculate_total_profit <- function(data) {
  total_profit = sum(data$Profit)
  return(total_profit)
}
calculate_total_profit(superstore)

# Average Sales Function: Create a function: average_sales(). The function should: take dataset as argument, calculate average Sales
average_sales <- function(data) {
  avg_sales = mean(data$Sales)
  return(avg_sales)
}
average_sales(superstore)

# Sales by Category Function: Create a function: sales_by_category(). The function should: group by Category, calculate total Sales
sales_by_category <- function(data) {
  result <- data %>%
    group_by(Category) %>%
    summarise(total_sales = sum(Sales)) %>%
    arrange(desc(total_sales))
  
  return(result)
}
sales_by_category(superstore)

# Profit by Region Function: Create a function: profit_by_region(). The function should: group by Region, calculate total Profit
profit_by_region <- function(data) {
  result <- data %>%
    group_by(Region) %>%
    summarise(total_profit = sum(Profit)) %>%
    arrange(desc(total_profit))
  
  return(result)
}
profit_by_region(superstore)

# Visualizations: Create charts to show the findings. Chart 1: Bar chart: Category vs Total Sales
category_sales <- sales_by_category(superstore)

ggplot(category_sales, aes(x = Category, y = total_sales, fill = Category)) +
  geom_col() +
  labs(
    title = "Category by Total Sales",
    x = "Category",
    y = "Total Sales"
  )

# Chart 2: Bar chart: Region vs Total Profit
region_profit <- profit_by_region(superstore)

ggplot(region_profit, aes(x = Region, y = total_profit, fill = Region)) +
  geom_col() +
  labs(
    title = "Region vs Total Profit",
    x = "Region",
    y = "Total Profit"
  )

# Chart 3: Histogram: Distribution of Sales
ggplot(superstore, aes(x = Sales)) +
  geom_histogram(bins = 30, fill = "steelblue", color = "black") +
  labs(
    title = "Distribution of Sales",
    x = "Sales",
    y = "Number of Sales"
  ) +
  theme_minimal()

# Chart 4: Scatter Plot: Discount vs Profit
ggplot(superstore, aes(x = Discount, y = Profit)) +
  geom_point(alpha = 0.6) +
  labs(
    title = "Discount vs Profit",
    x = "Discount",
    y = "Profit"
  )