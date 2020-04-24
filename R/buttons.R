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
#' @param \dots settings to pass to html2canvas
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
#' @export
#' @importFrom shiny actionButton
preview_button <- function(inputId = 'btn-Preview-Image',
                           label = 'Preview',
                           ui = "#html-content-holder",
                           previewId = 'previewImage',
                           ...){

  shiny::actionButton(
    inputId = inputId,
    label = label,
    onclick = build_preview_call(
      list(...),
      ui = ui,
      previewId = previewId)
  )
}

#' @rdname buttons
#' @export
#' @importFrom shiny actionButton
download_button <- function(inputId = 'btn-Convert-Html2Image',
                            label = 'Download',
                            ui = "#html-content-holder",
                            filename = 'canvas.png',
                            ...){
  shiny::actionButton(
    inputId = inputId,
    label = label,
    onclick = build_download_call(list(...),ui,filename)
  )
}

#'@importFrom jsonlite toJSON
build_preview_call <- function(opts,ui,previewId){

  canvas_opts <- ''

  if(length(opts)>0){
    canvas_opts <- jsonlite::toJSON(opts,auto_unbox = TRUE)
    canvas_opts <- gsub('["]','',canvas_opts)
    canvas_opts <- sprintf(',%s',canvas_opts)
  }

  sprintf('(function () {
    html2canvas($("%s")[0]%s).then(canvas=>{
      $("#%s").empty()
      $("#%s").append(canvas);
    });
    })();',ui,canvas_opts,previewId,previewId)
}

#'@importFrom jsonlite toJSON
build_download_call <- function(opts,ui,filename){

  canvas_opts <- ''

  if(length(opts)>0){
    canvas_opts <- jsonlite::toJSON(opts,auto_unbox = TRUE)
    canvas_opts <- gsub('["]','',canvas_opts)
    canvas_opts <- sprintf(',%s',canvas_opts)
  }

  sprintf('(function () {
    html2canvas($("%s")[0]%s).then(canvas=>{
      saveAs(canvas.toDataURL(), "%s");
    });
    })();',ui,canvas_opts,filename)
}
