# snapper
snap images of html objects in Shiny apps using canvas2html JQuery library

## Installation

```r
remotes::install_github('yonicd/snapper')
```

## How to use

  - Load to bindings to the UI `snapper::load_snapper()`
  - Preview Button: `snapper::preview_button(contentId = 'ace',previewId = "previewImage")`
  - Div that is connected to Preview Button: `snapper::snapper_div(id = "previewImage")`
  - Download Button: `snapper::download_button(contentId = 'ace')`


## Examples

### ShinyAce

Add preview and download buttons to create `shinyAce` images to share online.

```r
library(shiny)
library(shinyAce)
options(shiny.launch.browser = TRUE)

init <- "createData <- function(rows) {
  data.frame(col1 = 1:rows, col2 = rnorm(rows))
}"

# define server logic required to generate simple ace editor
server <- function(input, output, session) {
  
  observe({
    updateAceEditor(
      session,
      "ace",
      theme = input$theme,
      mode = input$mode,
      tabSize = input$size,
      useSoftTabs = as.logical(input$soft),
      showInvisibles = as.logical(input$invisible)
    )
  })
  
  observeEvent(input$reset, {
    updateAceEditor(session, "ace", value = init)
  })
  
  observeEvent(input$clear, {
    updateAceEditor(session, "ace", value = "")
  })
}

ace <- aceEditor(
  outputId = "ace",
  selectionId = "selection",
  value = init,
  placeholder = "Show a placeholder when the editor is empty ...")

# define UI for application that demonstrates a simple Ace editor
ui <- pageWithSidebar(
  headerPanel("Simple Shiny Ace!"),
  sidebarPanel(id = 'side',
               snapper::load_snapper(),
               selectInput("mode", "Mode: ", choices = shinyAce::getAceModes(), selected = "r"),
               selectInput("theme", "Theme: ", choices = shinyAce::getAceThemes(), selected = "ambience"),
               numericInput("size", "Tab size:", 4),
               radioButtons("soft", NULL, c("Soft tabs" = TRUE, "Hard tabs" = FALSE), inline = TRUE),
               radioButtons("invisible", NULL, c("Hide invisibles" = FALSE, "Show invisibles" = TRUE), inline = TRUE),
               actionButton("reset", "Reset text"),
               actionButton("clear", "Clear text"),
               snapper::preview_button(contentId = 'ace'),
               snapper::download_button(contentId = 'ace')
  ),mainPanel(ace, shiny::tags$h3('Preview'), snapper::snapper_div())
)

# Return a Shiny app object
shinyApp(ui = ui, server = server)
```

### App

![](inst/images/shinyAce.png)

### Saved Image

![](inst/images/shinyAce_snap.png)

