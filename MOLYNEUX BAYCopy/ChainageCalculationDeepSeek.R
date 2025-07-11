
# Function to project points onto a line
project_points_to_line <- function(x, y, slope, intercept) {
  # Convert line to parametric form: (x0, y0) + t*(dx, dy)
  x0 <- 0
  y0 <- intercept
  dx <- 1
  dy <- slope
  
  # For each point, find projection parameter t
  t <- ((x - x0) * dx + (y - y0) * dy) / (dx^2 + dy^2)
  
  # Calculate projected points
  x_proj <- x0 + t * dx
  y_proj <- y0 + t * dy
  
  return(list(x_proj = x_proj, y_proj = y_proj))
}

# Create example data
set.seed(123)
n_points <- 20
x <- runif(n_points, 0, 10)
y <- 2 + 1.5*x + rnorm(n_points, sd = 3)

# Define a line (we'll use y = 1 + 0.8x for this example)
line_slope <- 0.8
line_intercept <- 1

# Project points onto the line
projections <- project_points_to_line(x, y, line_slope, line_intercept)

# Create plot
plot(x, y, pch = 19, col = "blue", 
     xlim = range(c(x, projections$x_proj)), 
     ylim = range(c(y, projections$y_proj)),
     main = "Projection of Points onto a Line",
     xlab = "X", ylab = "Y")

# Add the line
abline(a = line_intercept, b = line_slope, col = "red", lwd = 2)

# Add projected points
points(projections$x_proj, projections$y_proj, pch = 19, col = "green")

# Draw segments connecting original points to their projections
segments(x, y, projections$x_proj, projections$y_proj, lty = 2, col = "gray")

# Add legend
legend("topleft", 
       legend = c("Original Points", "Projected Points", "Target Line"), 
       col = c("blue", "green", "red"), 
       pch = c(19, 19, NA), 
       lty = c(NA, NA, 1),
       lwd = c(NA, NA, 2))
