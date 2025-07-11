library(dplyr)
library(purrr)

# Read your data
data <- read_csv("C:/Users/HP15-ZBOOK/OneDrive/Desktop/Test_CSV.csv") %>%
  rename_with(tolower)

# Define reference line (two points: start and end)
ref_start <- c(x = 1352098.06, y = 4860507.491)  # Replace with your reference line start coordinates
ref_end <- c(x = 1352555.973, y = 4860035.718)    # Replace with your reference line end coordinates

# Function to project point onto line segment
project_point <- function(point, line_start, line_end) {
  ap <- point - line_start
  ab <- line_end - line_start
  t <- sum(ap * ab) / sum(ab * ab)
  t <- pmin(pmax(t, 0), 1)  # Clamp to line segment
  projection <- line_start + t * ab
  return(projection)
}

# Calculate projections and chainage
result <- data %>%
  mutate(
    # Convert to matrix for vectorized operations
    point_matrix = map2(x, y, ~c(.x, .y)),
    
    # Project each point
    projection = map(point_matrix, ~project_point(.x, ref_start, ref_end)),
    
    # Extract projected coordinates
    proj_x = map_dbl(projection, 1),
    proj_y = map_dbl(projection, 2),
    
    # Calculate distance along reference line (chainage)
    chainage = sqrt((proj_x - ref_start["x"])^2 + (proj_y - ref_start["y"])^2)
  ) %>%
  select(-point_matrix, -projection)

# View results
head(result)

# Save output
write_csv(result, "projected_points_with_chainage.csv")

