# Create intervals
numericCutter <- function(vect, step = 0.2) {
  # Wrapper for cut function
  # Takes numeric vector as input
  # Returns factor based on intervals
  vect <- round(vect, 2)
  vect <- cut(vect,
              breaks = unique(quantile(vect, 
                                       probs = seq(0, 1, step),
                                       names = FALSE,
                                       na.rm = TRUE)),
              dig.lab = 10,
              ordered_result = TRUE,
              include.lowest = TRUE,
              right = FALSE)
  return(vect)
}

# Merge with new file
user_data <- function(user_data, merge_by_var, merge_by_reg = TRUE) {
  if(is.null(user_data)) {
    data <- ggrmap
  } else {
    if (merge_by_reg) {
      data <- left_join(ggrmap, user_data, by = c("id" = merge_by_var))
    } else {
      data <- left_join(ggrmap, user_data, by = c("okato" = merge_by_var))
    }
  }
  return(data)
}



