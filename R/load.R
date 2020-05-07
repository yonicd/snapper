#' @title Attach snapper dependencies to the Shiny App
#' @description Attach html2canvas and jQuery javascript libraries and
#' download script to the Shiny App environment.
#' @param html2canvas character, url path to html2canvas library.
#' Default: 'https://html2canvas.hertzen.com/dist/html2canvas.js'
#' @param jquery character, url path to jQuery library.
#' Default: 'https://code.jquery.com/jquery-3.5.0.min.js'
#' @details
#' If your app needs to work with clients that won't be able to connect to the
#' wider internet, you'll need to download the javascript files,
#' put it in an app subdirectory (say, html2canvas),
#' and point to the arguments to the their respective paths.
#' @return shiny.tag.list
#' @inherit preview_button examples
#' @seealso
#'  [tag][shiny::tag], [builder][shiny::builder]
#' @rdname load_snapper
#' @family load
#' @export
#' @importFrom shiny tagList tags
#' @importFrom  htmltools htmlDependency
load_snapper <- function(
  html2canvas = 'https://html2canvas.hertzen.com/dist/html2canvas.min.js',
  jquery = 'https://code.jquery.com/jquery-3.5.0.min.js'){

  shiny::tagList(
    htmltools::htmlDependency("jquery", "3.5.0",
                              src = c(href = dirname(jquery)),
                              script = basename(jquery)),
    htmltools::htmlDependency("html2canvas", "1.0.0",
                              src = c(href = dirname(html2canvas)),
                              script = basename(html2canvas)),
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
