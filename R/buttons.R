#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param inputId PARAM_DESCRIPTION, Default: 'btn-Preview-Image'
#' @param label PARAM_DESCRIPTION, Default: 'Preview'
#' @param contentId PARAM_DESCRIPTION, Default: 'html-content-holder'
#' @param previewId PARAM_DESCRIPTION, Default: 'previewImage'
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso
#'  \code{\link[shiny]{actionButton}}
#' @rdname preview_button
#' @export
#' @importFrom shiny actionButton
preview_button <- function(inputId = 'btn-Preview-Image',
                           label = 'Preview',
                           contentId = "html-content-holder",
                           previewId = 'previewImage'){
  shiny::actionButton(
    inputId = inputId,
    label = label,
    onclick = sprintf('(function () {
    html2canvas($("#%s")[0]).then(function(canvas) {
      $("#%s").empty()
      $("#%s").append(canvas);
    });
    })();',contentId,previewId,previewId)
  )
}

#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param inputId PARAM_DESCRIPTION, Default: 'btn-Convert-Html2Image'
#' @param label PARAM_DESCRIPTION, Default: 'Download'
#' @param contentId PARAM_DESCRIPTION, Default: 'html-content-holder'
#' @param filename PARAM_DESCRIPTION, Default: 'canvas.png'
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso
#'  \code{\link[shiny]{actionButton}}
#' @rdname download_button
#' @export
#' @importFrom shiny actionButton
download_button <- function(inputId = 'btn-Convert-Html2Image',
                            label = 'Download',
                            contentId = "html-content-holder",
                            filename = 'canvas.png'){
  shiny::actionButton(
    inputId = inputId,
    label = label,
    onclick = sprintf('(function () {
    html2canvas($("#%s")[0]).then(function(canvas) {
    saveAs(canvas.toDataURL(), "%s");
  });
  })();',contentId,filename)
  )
}
