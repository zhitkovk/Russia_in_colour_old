pop_pal <- colorNumeric(palette = "YlOrRd", rds_map@data$n_adm_f_external)

pop_popup <- paste0("<b>", rds_map@data$name, "</b>", "<br>",
                    "Доля очных студентов: ", rds_map@data$n_adm_f_daily, "<br>",
                    "Доля заочных студентов: ", rds_map@data$n_adm_f_external, "<br>",
                    "Доля очно-заочных студентов: ", rds_map@data$n_adm_f_evening)