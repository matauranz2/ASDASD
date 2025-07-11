library(tidyverse)

# Read CSV data (modify path as needed)
survey_data <- read_csv("your_data.csv")

# Create reference line data
reference_line <- data.frame(
  Easting = c(1352098.06, 1352555.97),
  Northing = c(4860507.49, 4860035.72)
)

# Create the plot with minimal point size
ggplot() +
  # Survey points (minimal size)
  geom_point(
    data = survey_data,
    aes(x = Easting, y = Northing),
    color = "blue",
    size = 0.5,  # Smallest practical point size
    alpha = 0.7   # Slight transparency
  ) +
  
  # Reference line
  geom_line(
    data = reference_line,
    aes(x = Easting, y = Northing),
    color = "red",
    linetype = "dashed",
    linewidth = 0.5
  ) +
  
  # Labels
  geom_text(
    data = reference_line,
    aes(x = Easting, y = Northing, 
        label = c("Start", "End")),
    hjust = -0.1,
    vjust = -0.5,
    size = 3
  ) +
  
  # Plot formatting
  labs(title = "Survey Points with Reference Line",
       x = "Easting",
       y = "Northing") +
  theme_minimal() +
  coord_equal() +
  theme(
    plot.title = element_text(size = 10),
    axis.title = element_text(size = 8)
  )  # <-- This was the missing closing parenthesis
