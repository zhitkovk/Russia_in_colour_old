# Libraries
source("libraries.R")

# Data is read only once: when the app is started
source("read_data.R")

# Function for plotting map
source("map_plotter.R")

# Download fonts
source("global.R")

# Server code itself
shinyServer(
  function(input, output) {
    
  
      inFile <- reactive({
        # Read data
        # Check contents of the file
        init_file <- input$fileUpload_y
        
        if(is.null(init_file)) {
          return(user_data(NULL))
        } else {
          init_file <- openxlsx::read.xlsx(init_file$datapath)
          init_file <- user_data(init_file, input$reg_name)
          init_file[, ncol(init_file)] <- as.numeric(init_file[, ncol(init_file)])
          return(init_file)
        }
        })

      plotInput <- function() {
        return(mapPlotter(inFile(), input$data_selector, input$text_title, input$text_legend))
      }
      
      plotInput_y <- eventReactive(input$plot_map, {
        mapPlotter(inFile(), input$var_name, input$text_title_y, input$text_legend_y)
      })
      
      output$myplot <- renderPlot({
        plotInput()
      })
      
      output$myplot_y <- renderPlot({
        plotInput_y()
      })
      
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