#' @title Preview Canvas
#' @description div object to capture
#' [preview_button][snapper::preview_button] outputs.
#' @param id character, id of the object, Default: 'previewImage'
#' @param ... elements to pass to div
#' @return shiny.tag
#' @inherit preview_button examples
#' @seealso
#'  [builder][shiny::builder]
#' @rdname snapper_div
#' @export
#' @importFrom shiny tags
#' @family elements
snapper_div <- function(id = "previewImage",...){
  shiny::tags$div(id = id,...)
}
