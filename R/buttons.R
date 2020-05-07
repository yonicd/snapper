#' @title Snapper Buttons
#' @description Buttons to populate [snapper_div][snapper::snapper_div] or
#' download to local file the canvas contents.
#' @param inputId character, The input slot that will be used to access the value.
#'  Default: 'btn-Preview-Image'
#' @param label character, The contents of the button. Default: 'Preview'
#' @param ui character, The [jQuery selector](https://api.jquery.com/category/selectors/)
#' of the target ui element to be captured. Default: '#html-content-holder'
#' @param previewId character, The id that is mapped to the container that captures
#' the canvas output. Default: 'previewImage'
#' @param filename character, Local path to save the image. Default: 'canvas.png'
#' @param opts configuration settings to pass to
#'   [html2canvas](https://html2canvas.hertzen.com/configuration).
#' @param icon icon to pass use for in the link objects, Default: 'camera'
#' @details Use [config][config] to define the configuration options
#' @return shiny.tag
#' @examples
#'
#' if(interactive()){
#' options(device.ask.default = FALSE)
# Define UI
#' ui <- fluidPage(id = 'page',
#'
#' # load snapper into the app
#' load_snapper(),
#'
#' titlePanel("Hello Shiny!"),
#'
#' sidebarLayout(
#'
#'  sidebarPanel(id = 'side', # add id to side panel
#'    sliderInput("obs",
#'                "Number of observations:",
#'                min = 0,
#'                max = 1000,
#'                value = 500),
#'
#'    # add a download button for the side panel by id
#'    snapper::download_button(ui = '#side',
#'    label = 'Download Side Panel',
#'    filename = 'side_panel.png'),
#'
#'    # add a preview button for the side panel by id
#'    snapper::preview_button(ui = '#side',
#'    previewId = 'preview_side',
#'    label = 'Preview Side Panel'),
#'
#'    # add a preview button for the main panel by id
#'    snapper::preview_button(ui = '#main',
#'    previewId = 'preview_main',
#'    label = 'Preview Main Panel')
#'  ),
#'
#'  # Show a plot of the generated distribution
#'  mainPanel(id = 'main', # add id to main panel
#'    plotOutput("distPlot"),
#'
#'    # create a div that will display the content created by preview_side
#'    shiny::tags$h3('Preview Side Panel'),
#'    snapper::snapper_div(id = 'preview_side'),
#'
#'    # create a div that will display the content created by preview_main
#'    shiny::tags$h3('Preview Main Panel'),
#'    snapper::snapper_div(id = 'preview_main')
#'  )
#'   )
#' )
#'
# Server logic
#' server <- function(input, output) {
#'   output$distPlot <- renderPlot({
#'     hist(rnorm(input$obs))
#'   })
#' }
#'
#' # Complete app with UI and server components
#' shinyApp(ui, server)
#'
#' }
#' @seealso
#' [actionButton][shiny::actionButton]
#' @rdname buttons
#' @family elements
#' @export
#' @importFrom shiny actionButton
preview_button <- function(inputId = 'btn-Preview-Image',
                           label = 'Preview',
                           ui = "#html-content-holder",
                           previewId = 'previewImage',
                           opts = config()){

  shiny::actionButton(
    inputId = inputId,
    label = label,
    onclick = build_call(
      type = 'preview',
      arg = previewId,
      opts = opts,
      ui = ui
    )
  )
}

#' @rdname buttons
#' @export
#' @importFrom shiny actionLink icon
preview_link <- function(inputId = 'btn-Preview-Image',
                         label = 'Preview',
                         ui = "#html-content-holder",
                         previewId = 'previewImage',
                         opts = config(),
                         icon = "camera"){

  shiny::actionLink(
    inputId = inputId,
    label = label,
    icon = shiny::icon(icon),
    onclick = build_call(
      type = 'preview',
      arg = previewId,
      opts = opts,
      ui = ui
    )
  )
}


#' @rdname buttons
#' @export
#' @importFrom shiny actionButton
download_button <- function(inputId = 'btn-Convert-Html2Image',
                            label = 'Download',
                            ui = "#html-content-holder",
                            filename = 'canvas.png',
                            opts = config()){
  shiny::actionButton(
    inputId = inputId,
    label = label,
    onclick = build_call(
      type = 'download',
      arg = filename,
      opts = opts,
      ui = ui
    )
  )
}

#' @rdname buttons
#' @export
#' @importFrom shiny actionLink icon
download_link <- function(inputId = 'btn-Convert-Html2Image',
                          label = '',
                          ui = "#html-content-holder",
                          filename = 'canvas.png',
                          opts = config(),
                          icon = "camera"){
  shiny::actionLink(
    inputId = inputId,
    label = label,
    icon = shiny::icon(icon),
    onclick = build_call(
      type = 'download',
      arg = filename,
      opts = opts,
      ui = ui
    )
  )
}

