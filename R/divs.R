#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param id PARAM_DESCRIPTION, Default: 'previewImage'
#' @param ... PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso
#'  \code{\link[shiny]{builder}}
#' @rdname snapper_div
#' @export
#' @importFrom shiny tags
snapper_div <- function(id = "previewImage",...){
  shiny::tags$div(id = id,...)
}
