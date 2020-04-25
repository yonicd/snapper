library(shiny)
library(leaflet)

shiny::runGadget(
  fluidPage(
    snapper::load_snapper(),
    sidebarLayout(
      sidebarPanel = sidebarPanel(
        sliderInput(
          inputId = 'x_slide',
          label = 'Crop X',
          min = 0,
          max = 1200,
          value = 555
        ),
        sliderInput(
          inputId = 'y_slide',
          label = 'Crop Y',
          min = 0,
          max = 400,
          value = 0
        ),
        uiOutput('mybtn')
      ),
      mainPanel = mainPanel(
        leafletOutput('myMap'),
        snapper::snapper_div()
      )
    )),
  server = function(input, output) {
    output$mybtn <- renderUI({
       snapper::preview_button(
        ui = '#myMap',
        opts = snapper::config(
          allowTaint = TRUE,
          useCORS = TRUE,
          x = as.numeric(input$x_slide),
          y = as.numeric(input$y_slide)
          )
      )
    })
    map = leaflet() %>%
      addTiles() %>%
      setView(-93.65, 42.0285, zoom = 17)
    output$myMap = renderLeaflet(map)
  },
  viewer = shiny::browserViewer()
)
