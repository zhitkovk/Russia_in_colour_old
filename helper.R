# Create intervals
numericCutter <- function(vect) {
  # Wrapper for cut function
  # Takes numeric vector as input
  # Returns factor based on intervals
  vect <- cut(vect,
              breaks = unique(quantile(vect, 
                                       probs = seq(0, 1, 0.2),
                                       names = FALSE,
                                       na.rm = TRUE)),
              dig.lab = 10,
              ordered_result = TRUE)
  return(vect)
}

# Merge with new file
user_data <- function(user_data, merge_by) {
  if(is.null(user_data)) {
    data <- ggrmap
  } else {
    data <- left_join(ggrmap, user_data, by = c("id" = merge_by))
  }
  return(data)
}
