#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION

#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso
#'  \code{\link[shiny]{tag}}, \code{\link[shiny]{builder}}
#' @rdname load_snapper
#' @export
#' @importFrom shiny tagList tags
load_snapper <- function(){
  shiny::tagList(
    shiny::tags$script(src='https://html2canvas.hertzen.com/dist/html2canvas.js'),
    shiny::tags$script('
      var saveAs = function(uri, filename) {
            var link = document.createElement("a");
            if (typeof link.download === "string") {
              link.href = uri;
              link.download = filename;

              //Firefox requires the link to be in the body
              document.body.appendChild(link);

              //simulate click
              link.click();

              //remove the link when done
              document.body.removeChild(link);
            } else {
              window.open(uri);
            }
          };')
  )
}
