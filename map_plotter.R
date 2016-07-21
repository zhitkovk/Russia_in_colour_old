# Function to create a map of Russia with filling of choice

mapPlotter <- function(data, fill_var, title = "", leg_name = "") {
  # Function plots map of Russia with chosen filling
  #
  # Args:
  #  data: dataframe with long, lat, group by variable and filling
  #  fill_var: variable to fill the plot
  #  title: title of the plot
  #  leg_name: title of the legend
  #
  # Returns:
  #  ggplot2 object: map of Russia
  plot <- ggplot(data = data, aes_(x = ~long, y = ~lat, group = ~group, fill = as.name(fill_var))) +
    geom_polygon(colour = "white", size = 0.3) + 
    coord_quickmap() + 
    labs(x = "", 
         y = "",
         title = title) + 
    #scale_fill_gradient(low = "orange", high = "purple") +
    scale_fill_distiller(name = leg_name, palette = "GnBu", labels = comma) +
    scale_x_continuous(breaks = NULL) +
    scale_y_continuous(breaks = NULL) + 
    theme_bw()
  return(plot)
}
