# App interface

shinyUI(navbarPage("Карта России в цвете beta",
                   theme = shinythemes::shinytheme("united"),
                   tabPanel(
                     "Заочное образование",
                     sidebarLayout(
                       sidebarPanel(
                         selectInput(
                           "data_selector",
                           label = h4("Выберите данные:"),
                           choices = list("Зачислено на заочное" = "n_adm_external",
                                          "Зачислено на очное" = "n_adm_daily",
                                          "Зачислено на вечернее" = "n_adm_evening",
                                          "Доля зачисленных заочных студентов" = "n_adm_f_external",
                                          "Доля зачисленных очных студентов" = "n_adm_f_daily",
                                          "Доля зачисленных вечерних студентов" = "n_adm_f_evening",
                                          "Доля заочного в приеме менеджеров" = "n_adm_f_external_manager",
                                          "Доля заочного в приеме экономистов" = "n_adm_f_external_economics",
                                          "Доля заочного в приеме юристов" = "n_adm_f_external_law",
                                          "Доля заочного в приеме гос. управленцев" = "n_adm_f_external_public",
                                          "Доля заочного в приеме на управление персоналом" = "n_adm_f_external_public"),
                           size = 11,
                           selectize = FALSE,
                           selected = "n_adm_f_external"),
                         textInput(
                           "text_title", label = h4("Название графика"), value = "Регионы России"
                           ),
                         textInput(
                           "text_legend", label = h4("Легенда"), value = "Доля:"
                           ),
                         h4(
                           "Загрузить карту"
                         ),
                         downloadButton(
                           "downloadPNG", "PNG"
                           )
                         ),
                       mainPanel(
                         plotOutput("myplot")
                         )
                       )
                     ),
                   tabPanel("Ваши данные",
                            sidebarLayout(
                              sidebarPanel(
                                h4(
                                  "Загрузите собственные данные"
                                ),
                                helpText("Загруженный файл должен содержать 2 колонки: название региона и интересующий
                                         вас показатель. Важно, чтобы названия регионов соответствовали образцу, 
                                         представленному по", a("ссылке", href = "www"), ".", "К примеру, фраза \"г. Москва\"
                                         должна содержать пробел после \"г.\"."
                                ),
                                textInput(
                                  "reg_name", label = h5("Сначала введите название колонки со списком регионов:")
                                ),
                                textInput(
                                  "var_name", label = h5("Затем добавьте название колонки с данными из файла:")
                                ),
                                fileInput(
                                  "fileUpload_y",
                                  label = h5("Загрузите сам файл:"),
                                  accept = c("text/csv",
                                             "text/comma-separated-values,text/plain",
                                             ".csv",
                                             ".xlsx")
                                ),
                                textInput(
                                  "text_title_y", label = h5("Название вашего графика:"), value = "Регионы России"
                                ),
                                textInput(
                                  "text_legend_y", label = h5("Заголовок легенды:"), value = "Доля:"
                                ),
                                actionButton(
                                  "plot_map", "Построить карту"
                                ),
                                h4(
                                  "Загрузить карту"
                                ),
                                downloadButton(
                                  "downloadPNG_y", "PNG"
                                )
                              ),
                              mainPanel(
                                plotOutput("myplot_y")
                                )
                              )
                            ),
                   tabPanel("О проекте",
                            includeMarkdown("description.md")
                            )
                   )
        )



