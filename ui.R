# App interface
source("libraries.R")

shinyUI(navbarPage("Карта России в цвете beta",
                   theme = shinythemes::shinytheme("united"),
                   tabPanel(
                     "Заочное образование",
                     sidebarLayout(
                       sidebarPanel(
                         selectInput(
                           "data_selector",
                           label = h4("Выберите данные:"),
                           choices = list("Зачислено на заочное" = "n_adm_external.1",
                                          "Зачислено на очное" = "n_adm_daily.1",
                                          "Зачислено на вечернее" = "n_adm_evening.1",
                                          "Доля зачисленных заочных студентов" = "n_adm_f_external.1",
                                          "Доля зачисленных очных студентов" = "n_adm_f_daily.1",
                                          "Доля зачисленных вечерних студентов" = "n_adm_f_evening.1",
                                          "Доля заочного в приеме менеджеров" = "n_adm_f_external_manager.1",
                                          "Доля заочного в приеме экономистов" = "n_adm_f_external_economics.1",
                                          "Доля заочного в приеме юристов" = "n_adm_f_external_law.1",
                                          "Доля заочного в приеме гос. управленцев" = "n_adm_f_external_public.1",
                                          "Доля заочного в приеме на управление персоналом" = "n_adm_f_external_hr.1"),
                           size = 11,
                           selectize = FALSE,
                           selected = "n_adm_f_external.1"),
                         selectInput(
                           "pal",
                           label = h4("Выберите цветовую схему:"),
                           choices = list("Синий-зеленый" = "BuGn",
                                          "Синий-сиреневый" = "BuPu",
                                          "Зеленый-синий" = "GnBu",
                                          "Сиреневый-красный" = "PuRd",
                                          "Желтый-зеленый" = "YlGn",
                                          "Желтый-зеленый-синий" = "YlGnBu",
                                          "Желтый-оранжевый-красный" = "YlOrRd"),
                           selectize = TRUE,
                           selected = "YlGnBu"
                         ),
                         textInput(
                           "text_title", label = h4("Название графика"), value = "Регионы России"
                           ),
                         textInput(
                           "text_legend", label = h4("Легенда"), value = "Доля:"
                           ),
                         h4(
                           "Загрузить изображение"
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
                                helpText("Загруженный файл должен быть в формате xlsx и содержать минимум 2 колонки: название региона и интересующий
                                         вас показатель. Важно, чтобы названия регионов соответствовали образцу, 
                                         представленному по", a("ссылке", href = "https://github.com/zhitkovk/Russia_in_colour/raw/master/data/region_list.xlsx", target="_blank",
                                                                rel="noopener noreferrer"), ".", "К примеру, фраза \"г. Москва\"
                                         должна содержать пробел после \"г.\"."
                                ),
                                fileInput(
                                  "fileUpload_y",
                                  label = h5("Загрузите ваш файл:"),
                                  accept = c("text/csv",
                                             "text/comma-separated-values,text/plain",
                                             ".csv",
                                             ".xlsx")
                                ),
                                # conditionalPanel(
                                #   "output.fileUploaded",
                                #   selectInput(
                                #     "reg_sel",
                                #     "Выберите колонку с названием региона:",
                                #     colnames(inFile())
                                #   )
                                # ),
                                selectInput(
                                  "reg_select",
                                  label = h5("Выберите колонку с названием региона:"),
                                  ""
                                ),
                                selectInput(
                                  "var_select",
                                  label = h5("Укажите колонку с показателем:"),
                                  ""
                                ),
                                # textInput(
                                #   "reg_name", label = h5("Сначала введите название колонки со списком регионов:")
                                # ),
                                # textInput(
                                #   "var_name", label = h5("Затем добавьте название колонки с данными из файла:")
                                # ),
                                selectInput(
                                  "pal_y",
                                  label = h5("Выберите цветовую схему:"),
                                  choices = list("Синий-зеленый" = "BuGn",
                                                 "Синий-сиреневый" = "BuPu",
                                                 "Зеленый-синий" = "GnBu",
                                                 "Сиреневый-красный" = "PuRd",
                                                 "Желтый-зеленый" = "YlGn",
                                                 "Желтый-зеленый-синий" = "YlGnBu",
                                                 "Желтый-оранжевый-красный" = "YlOrRd"),
                                  selectize = TRUE,
                                  selected = "YlGnBu"
                                ),
                                selectInput(
                                  "pal_q_y",
                                  label = h5("Выберите число градаций цвета"),
                                  choices = list("2" = 0.5,
                                                 "4" = 0.25,
                                                 "5" = 0.2),
                                  selectize = TRUE,
                                  selected = 0.2
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
                                  "Загрузить изображение"
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

