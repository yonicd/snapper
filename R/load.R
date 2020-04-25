#' @title Load snapper JS libraries in ShinyApp
#' @description Load html2canvas jquery library and download script
#'  in Shiny App environment.
#' @param html2canvas character, url path to html2canvas library.
#' Default: 'https://html2canvas.hertzen.com/dist/html2canvas.js'
#' @return shiny.tag.list
#' @inherit preview_button examples
#' @seealso
#'  [tag][shiny::tag], [builder][shiny::builder]
#' @rdname load_snapper
#' @family load
#' @export
#' @importFrom shiny tagList tags
load_snapper <- function(html2canvas = 'https://html2canvas.hertzen.com/dist/html2canvas.js'){
  shiny::tagList(
    shiny::tags$script(src = html2canvas),
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
