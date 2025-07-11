# Prompt the user to select a file
file_path <- file.choose()

# Load the CSV file
data <- read.csv(file_path)

# Inspect the data (optional)
head(data)

# Plot the data (assuming columns are named 'x' and 'y')
plot(
  data$x, data$y,
  main = "Scatter Plot of X vs Y",
  xlab = "X Values",
  ylab = "Y Values",
  col = "blue",   # Blue color for points
  pch = 19,       # Solid circle points
  type = "b"      # Both points and lines
)
