# SpatialPolygonsDataFrame was taken from rusmaps package
# Than it was converted to dataframe using broom::tidy

# rusmap package link:
# https://github.com/akondrashov96/rusmaps

ggrmap <- readRDS("data/rmap.RDS")

user_data <- function(user_data, merge_by) {
  if(is.null(user_data)) {
    data <- ggrmap
  } else {
    data <- merge(ggrmap, user_data, by.x = "region", by.y = merge_by)
  }
  return(data)
}


# t <- user_data(read.xlsx(paste0(getwd(), "/data/ext_frac_regions.xlsx")))
# 
# 
# write.xlsx(unique(ggrmap$id), "data/reg_names.xlsx", row.names = FALSE)
# 
# rm(t)
# 
# summary(Encoding(hz$region[1]))
# 
# 
# hz <- read.xlsx(paste0(getwd(), "/data/ext_frac_regions.xlsx"))
# 
# ggrmap$id[1]
# hz$region[1]
# 
# # # 
# hz <- read.xlsx("data/w_ext_frac_regions.xlsx", sheet = 1)
# 
# 
# gz <- merge(ggrmap, hz, by.x = "region", by.y = "region", all.x = TRUE)
# 
# 
# mapPlotter(gz, "n_adm_f")
