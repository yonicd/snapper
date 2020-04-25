library(shiny)
library(leaflet)

shiny::runGadget(
  fluidPage(
    leafletOutput('myMap'),
    snapper::load_snapper(),
    snapper::preview_button(
      ui = '#myMap',
      opts = snapper::config(
        allowTaint = TRUE,
        useCORS = TRUE)
    ),
    snapper::snapper_div()
  ),
  server = function(input, output) {
    map = leaflet() %>%
      addTiles() %>%
      setView(-93.65, 42.0285, zoom = 17)
    output$myMap = renderLeaflet(map)
  },
  viewer = shiny::browserViewer()
)
