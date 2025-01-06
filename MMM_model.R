#-----------------The First one with best till now-----------------##

library(Robyn)
library(readr)

# Step 1: Load Data
model_input_data <- read.csv("C:/Users/shaik/Desktop/Master's Project/RCT/Dataset/weekly_data_all_years.csv")
head(model_input_data)
str(model_input_data)

# Check and format date
if (sum(is.na(as.Date(model_input_data$DATE_DAY, "%Y-%m-%d")))) {
  model_input_data$Week <- as.Date(model_input_data$DATE_DAY, format = "%m/%d/%Y")
} else {
  model_input_data$Week <- as.Date(model_input_data$DATE_DAY, format = "%m/%d/%Y")
}


model_input_data$Week <- as.Date(model_input_data$DATE_DAY, format = "%m/%d/%Y")

# Optionally, you can also check and confirm the format
head(model_input_data$Week)  # Check the first few rows

# Step 2: Load Holiday Data
data("dt_prophet_holidays")  # Use built-in Prophet holidays
tail(dt_prophet_holidays)

# Step 3: Define Model Configuration
InputCollect <- robyn_inputs(
  dt_input = model_input_data,
  dt_holidays = dt_prophet_holidays,
  date_var = "Week",  # Ensure "YYYY-MM-DD" format
  window_start = "2019-07-21",  # Adjust for your dataset
  window_end = "2024-06-02",
  dep_var = "FIRST_PURCHASES_ORIGINAL_PRICE",  # Change to your dependent variable
  dep_var_type = "revenue",  # Options: "revenue" or "conversion"
  prophet_vars = c("holiday", "season"), # "trend","season", "holiday"
  prophet_country = "UK",
  # Paid Media Variables
  paid_media_spends = c("GOOGLE_PAID_SEARCH_SPEND", "GOOGLE_SHOPPING_SPEND", 
                        "GOOGLE_PMAX_SPEND", "GOOGLE_DISPLAY_SPEND", 
                        "GOOGLE_VIDEO_SPEND", "META_FACEBOOK_SPEND", 
                        "META_INSTAGRAM_SPEND"),
  
  paid_media_vars = c("GOOGLE_PAID_SEARCH_CLICKS", "GOOGLE_SHOPPING_CLICKS",
                      "GOOGLE_PMAX_CLICKS", "GOOGLE_DISPLAY_CLICKS",
                      "GOOGLE_VIDEO_CLICKS", "META_FACEBOOK_CLICKS",
                      "META_INSTAGRAM_CLICKS"),
  
  # Organic and Context Variables
  organic_vars = NULL,  # No organic variables in dataset
  context_vars = "FIRST_PURCHASES_GROSS_DISCOUNT",
  context_signs = "negative",
  
  adstock = "geometric" # Options: "geometric", "weibull_cdf", "weibull_pdf"
)
print(InputCollect)

# Step 4: Plot Adstock and Saturation
plot_adstock(plot = TRUE)
plot_saturation(plot = TRUE)

# Step 5: Define Hyperparameters
# Customize based on channel type
theta_list <- list(
  GOOGLE_PAID_SEARCH_SPEND_thetas = c(0.1, 0.3),
  GOOGLE_SHOPPING_SPEND_thetas = c(0, 0.3),
  GOOGLE_PMAX_SPEND_thetas = c(0, 0.3),
  GOOGLE_DISPLAY_SPEND_thetas = c(0, 0.3),
  GOOGLE_VIDEO_SPEND_thetas = c(0, 0.3),
  META_FACEBOOK_SPEND_thetas = c(0, 0.4),
  META_INSTAGRAM_SPEND_thetas = c(0, 0.4)
)

alpha_list <- list(
  GOOGLE_PAID_SEARCH_SPEND_alphas = c(0.5, 3),
  GOOGLE_SHOPPING_SPEND_alphas = c(0.5, 3),
  GOOGLE_PMAX_SPEND_alphas = c(0.5, 3),
  GOOGLE_DISPLAY_SPEND_alphas = c(0.5, 3),
  GOOGLE_VIDEO_SPEND_alphas = c(0.5, 3),
  META_FACEBOOK_SPEND_alphas = c(0.5, 3),
  META_INSTAGRAM_SPEND_alphas = c(0.5, 3)
)

gamma_list <- list(
  GOOGLE_PAID_SEARCH_SPEND_gammas = c(0.3, 1),
  GOOGLE_SHOPPING_SPEND_gammas = c(0.3, 1),
  GOOGLE_PMAX_SPEND_gammas = c(0.3, 1),
  GOOGLE_DISPLAY_SPEND_gammas = c(0.3, 1),
  GOOGLE_VIDEO_SPEND_gammas = c(0.3, 1),
  META_FACEBOOK_SPEND_gammas = c(0.3, 1),
  META_INSTAGRAM_SPEND_gammas = c(0.3, 1)
)

other_hyper_params <- list(train_size = c(1))

# Combine Hyperparameters
hyperparams_list <- c(theta_list, alpha_list, gamma_list, other_hyper_params)
InputCollect <- robyn_inputs(InputCollect = InputCollect, hyperparameters = hyperparams_list)
print(InputCollect)

# Step 6: Run the Model
OutputModels <- robyn_run(
  InputCollect = InputCollect,
  cores = NULL,  # Defaults to (max cores - 1)
  iterations = 2000,  # Recommended: 2000
  trials = 5  # Recommended: 5-10
)
print(OutputModels)

# Step 7: Export and Visualize Results
OutputCollect <- robyn_outputs(
  InputCollect,
  OutputModels,
  pareto_fronts = "auto",
  csv_out = "pareto",  # Export Pareto results
  export = TRUE,  # Create files locally
  plot_folder = "C:/Users/shaik/Desktop/Master's Project/RCT/Dataset/plots",  # Adjust path
  plot_pareto = TRUE
)
print(OutputCollect)