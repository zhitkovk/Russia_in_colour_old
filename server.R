# Libraries
source("libraries.R")

# Data is read only once: when the app is started
source("read_data.R")

# Function for plotting map
source("map_plotter.R")
source("helper.R")

# Download fonts
source("global.R")

# Server code itself
shinyServer(
  function(input, output, session) {
    
      # READ DATA ----
      inFile <- reactive({
        
        #Check contents of the file
        if (is.null(input$fileUpload_y)) {
          return(NULL)
        } else {
          init_file <- openxlsx::read.xlsx(input$fileUpload_y$datapath)
        }
        })
      
      # MERGE IT WITH INITIAL DATAFRAME ----
      fileMerger <- reactive({
        cols <- ncol(inFile())
        
        # Implicit facitity for multiple columns with data
        init_file <- user_data(inFile(), input$reg_select)
        init_file[, (ncol(init_file) - cols - 1):ncol(init_file)] <- lapply(
          init_file[,(ncol(init_file) - cols - 1):ncol(init_file)],
          function(x)
            numericCutter(as.numeric(x)))
        init_file
      })
      
      # UPDATE SELECTORS ----
      observe({
        updateSelectInput(
          session,
          "reg_select",
          choices = colnames(inFile()))
        
      })
      
      observe({
        updateSelectInput(
          session,
          "var_select",
          choices = colnames(inFile()))
        
      })
      
      # CREATE PLOT ----
      plotInput <- function() {
        return(mapPlotter(user_data(NULL), input$data_selector, input$text_title, input$text_legend,
                          input$pal))
      }
      
      plotInput_y <- eventReactive(input$plot_map, {
        mapPlotter(fileMerger(), input$var_select, input$text_title_y, input$text_legend_y,
                   input$pal_y)
      })
      
      # DISPLAY IT (RENDER) ----
      output$myplot <- renderPlot({
        plotInput()
      })
      
      output$myplot_y <- renderPlot({
        plotInput_y()
      })
      
      # DOWNLOAD PLOT AS PNG ----
      output$downloadPNG <- downloadHandler(
        filename = "map.png", 
        content = function(file) {
          ggsave(file, 
                 plot = plotInput(), 
                 device = "png", 
                 width = 12,
                 height = 9, 
                 units = "cm", 
                 scale = 2)
        })
      
      output$downloadPNG_y <- downloadHandler(
        filename = "map.png", 
        content = function(file) {
          ggsave(file, 
                 plot = plotInput_y(), 
                 device = "png", 
                 width = 12,
                 height = 9, 
                 units = "cm", 
                 scale = 2)
        })
      # output$downloadPDF <- downloadHandler(
      #   filename = "map.pdf", 
      #   content = function(file) {
      #     ggsave(file, plot = plotInput(), device = "pdf")
      #   })
  }
  
)
