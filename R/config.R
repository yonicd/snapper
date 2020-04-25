#' @title Configure html2canvas
#' @description Customize configuration of the html2canvas call.
#' @param allowTaint Whether to allow cross-origin images to taint the canvas.
#' Default = FALSE
#' @param backgroundColor Canvas background color, if none is specified in DOM.
#' Set NULL for transparent. Default: '#ffffff'
#' @param canvas Existing canvas element to use as a base for drawing on.
#' Default = NULL
#' @param foreignObjectRendering Whether to use ForeignObject rendering if the
#' browser supports it. Default = FALSE
#' @param imageTimeout Timeout for loading an image (in milliseconds).
#' Set to 0 to disable timeout. Default: 15000
#' @param ignoreElements Predicate function which removes the matching elements
#' from the render. Usage: '(element) => false'
#' @param logging Enable logging for debug purposes. Default = TRUE
#' @param onclone Callback function which is called when the Document has been
#' cloned for rendering, can be used to modify the contents that will be rendered
#' without affecting the original source document. Default = NULL
#' @param proxy Url to the proxy which is to be used for loading cross-origin images.
#' If left empty, cross-origin images will not be loaded. Default = NULL
#' @param removeContainer Whether to cleanup the cloned DOM elements html2canvas
#'  creates temporarily. Default = TRUE
#' @param useCORS Whether to attempt to load images from a server using CORS.
#' Default = FALSE
#' @param scale The scale to use for rendering. Defaults to the browsers
#' device pixel ratio. Default: 'window.devicePixelRatio'
#' @param windowWidth Window width to use when rendering Element,
#' which may affect things like Media queries. Default: 'window.innerWidth'
#' @param windowHeight Window height to use when rendering Element,
#' which may affect things like Media queries. Default: 'window.innerHeight'
#' @param width The width of the canvas. Default: Element width
#' @param height The height of the canvas. Default: Element height
#' @param x Crop canvas x-coordinate. Default: Element x-offset
#' @param y Crop canvas y-coordinate. Default: Element y-offset
#' @param scrollX The x-scroll position to used when rendering element,
#' (for example if the Element uses position: fixed). Default: Element scrollX
#' @param scrollY The y-scroll position to used when rendering element,
#' (for example if the Element uses position: fixed). Default: Element scrollY
#' @param \dots not used
#' @return json
#' @details To find further information on the configurations that can be used
#' please refer to [html2canvas](https://html2canvas.hertzen.com/documentation)
#' @family config
#' @importFrom utils modifyList
#' @importFrom jsonlite toJSON
#' @export
config <- function(allowTaint,
                   backgroundColor,
                   canvas,
                   foreignObjectRendering,
                   imageTimeout,
                   ignoreElements,
                   logging,
                   onclone,
                   proxy,
                   removeContainer,
                   useCORS,
                   scale,
                   width,
                   height,
                   x,
                   y,
                   scrollX,
                   scrollY,
                   windowWidth,
                   windowHeight,
                   ...
                   ){

  setting <- find_args(...)

  bad_name <- setdiff(names(setting),names(default_class))

  if(length(bad_name)>0)
    stop(sprintf('%s not a valid element',paste0(bad_name,collapse = ', ')))

  invisible(lapply(names(setting),check_setting,setting))

  canvas_opts <- ''

  if(length(setting)>0){
    canvas_opts <- jsonlite::toJSON(setting,auto_unbox = TRUE,null = 'null')
    canvas_opts <- gsub('["]','',canvas_opts)
  }

  canvas_opts
}

find_args <- function (...) {
  env <- parent.frame()
  args <- names(formals(sys.function(sys.parent(1))))
  vals <- mget(args, envir = env)
  vals <- vals[!vapply(vals, is_missing_arg, logical(1))]
  utils::modifyList(vals, list(..., ... = NULL))
}

is_missing_arg <- function (x) identical(x, quote(expr = ))

check_setting <- function(e,elements){
  e_val <- elements[[e]]
  if(!inherits(e_val,unlist(default_class[e],use.names = FALSE)))
    stop(sprintf('%s must be of class %s',e,default_class[e]))
}

default_class <- list(
  'allowTaint' = 'logical',
  'backgroundColor' = 'character',
  'canvas' = c('character','NULL'),
  'foreignObjectRendering' = 'logical',
  'imageTimeout' = 'numeric',
  'ignoreElements' = 'character',
  'logging' = 'logical',
  'onclone' = c('character','NULL'),
  'proxy' = c('character','NULL'),
  'removeContainer' = 'logical',
  'useCORS' = 'logical',
  'scale' = c('character','numeric'),
  'width' = c('character','numeric'),
  'height' = c('character','numeric'),
  'x' = c('character','numeric'),
  'y' = c('character','numeric'),
  'scrollX' = c('character','numeric'),
  'scrollY' = c('character','numeric'),
  'windowWidth' = c('character','numeric'),
  'windowHeight' = c('character','numeric')
)
