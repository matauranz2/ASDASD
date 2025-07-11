library(readr)
library(dplyr)

# Step 1: Load CSV file
file_path <- file.choose()  # User selects file
data <- read_csv(file_path)

# Step 2: Ensure correct column names
print(colnames(data))  # Verify column names

# Step 3: Select and filter required data
filtered_data <- data %>%
  select(depth, speed_of_sound) %>%  # Select both depth and speed columns
  filter(!is.na(speed_of_sound) & speed_of_sound != 0)  # Remove invalid speeds

# Step 4: Compute reciprocals and harmonic mean
filtered_data <- filtered_data %>%
  mutate(reciprocal = 1 / speed_of_sound)

reciprocal_sum <- sum(filtered_data$reciprocal, na.rm = TRUE)
num_rows <- nrow(filtered_data)

if (num_rows > 0) {
  harmonic_mean <- num_rows / reciprocal_sum
  
  # Step 5: Create the plot
  plot(filtered_data$depth, filtered_data$speed_of_sound,
       main = "Speed of Sound vs Depth with Harmonic Mean",
       xlab = "Depth", 
       ylab = "Speed of Sound",
       pch = 19, col = "blue")
  
  # Add harmonic mean horizontal line
  abline(h = harmonic_mean, col = "red", lwd = 2, lty = 2)
  
 
  
} else {
  cat("\nNo valid data available for plotting.\n")
}

# Remaining output calculations (same as before)
cat("\nReciprocal values:\n")
print(formatC(filtered_data$reciprocal, format = "f", digits = 7))
cat("\nSum of reciprocals:", formatC(reciprocal_sum, format = "f", digits = 7), "\n")
cat("Harmonic Mean:", formatC(harmonic_mean, format = "f", digits = 7), "\n")