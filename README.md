
<!-- README.md is generated from README.Rmd. Please edit that file -->

# snapper

snap images of html objects in Shiny apps using canvas2html JQuery
library

## Installation

``` r
remotes::install_github('yonicd/snapper')
```

## Where it can be useful

  - seleniumless shiny app testing
      - Take a snap of any element in the page using `JavaScript`
        strings
  - offline script image sharing (a la carbon)
      - Implemented in [carbonace](https://github.com/yonicd/carbonace)

## How to use

  - Load to bindings to the UI using
      - `snapper::load_snapper()`
  - Add a Preview Button to the UI
      - e.g.: `snapper::preview_button(ui = '#NAME',previewId =
        "previewImage")`
  - Add a Div that is connected to Preview Button
      - e.g.: `snapper::snapper_div(id = "previewImage")`
  - Add a Download Button to download directly to a local path
      - e.g.: `snapper::download_button(ui = '#NAME')`

## Verbose Examples

### Ace editor

Adding preview and download buttons to create ace editor images to share
online.

<details closed>

<summary> <span title="Click to Open"> Script </span> </summary>

``` r

library(shiny)
options(device.ask.default = FALSE)
# Define UI
ui <- fluidPage(id = 'page',

# load snapper into the app
load_snapper(),

titlePanel("Hello Shiny!"),

sidebarLayout(

 sidebarPanel(id = 'side', # add id to side panel
   sliderInput("obs",
               "Number of observations:",
               min = 0,
               max = 1000,
               value = 500),

   # add a download button for the side panel by id
   snapper::download_button(ui = '#side',
   label = 'Download Side Panel',
   filename = 'side_panel.png'),

   # add a preview button for the side panel by id
   snapper::preview_button(ui = '#side',
   previewId = 'preview_side',
   label = 'Preview Side Panel'),

   # add a preview button for the main panel by id
   snapper::preview_button(ui = '#main',
   previewId = 'preview_main',
   label = 'Preview Main Panel')
 ),

 # Show a plot of the generated distribution
 mainPanel(id = 'main', # add id to main panel
   plotOutput("distPlot"),

   # create a div that will display the content created by preview_side
   shiny::tags$h3('Preview Side Panel'),
   snapper::snapper_div(id = 'preview_side'),

   # create a div that will display the content created by preview_main
   shiny::tags$h3('Preview Main Panel'),
   snapper::snapper_div(id = 'preview_main')
 )
  )
)

# Server logic
server <- function(input, output) {
  output$distPlot <- renderPlot({
    hist(rnorm(input$obs))
  })
}

# Complete app with UI and server components
shinyApp(ui, server)
```

</details>

<br>

<details>

<summary> Example Outputs </summary>

Default:

<img src="/Library/Frameworks/R.framework/Versions/3.6/Resources/library/snapper/images/shinyAce.png" width="50%" />

Saved Image:

<img src="/Library/Frameworks/R.framework/Versions/3.6/Resources/library/snapper/images/shinyAce_snap.png" width="30%" />

Different Mode:

<img src="/Library/Frameworks/R.framework/Versions/3.6/Resources/library/snapper/images/shinyAce_python.png" width="50%" />

Different Theme:

<img src="/Library/Frameworks/R.framework/Versions/3.6/Resources/library/snapper/images/shinyAce_chrome.png" width="50%" />

</details>

<br>

### Htmlwidgets

<details closed>

<summary> <span title="Click to Open"> Leaflets </span> </summary>

``` r

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
```

</details>

<br>

<details closed>

<summary> <span title="Click to Open"> Leaflets with Reactive Cropping
</span> </summary>

``` r

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
```

</details>

<br>
