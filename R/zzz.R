.onLoad <- function(libname, pkgname) {
  shiny::registerInputHandler("snapper", function(data, ...) {
    imgdata <- strsplit(data$image, ",")[[1]][2]
    dir <- normalizePath(URLdecode(data$dir), mustWork = FALSE)

    if (!dir.exists(dir)) {
      warning("snapper: save_dir path does not exist", call. = FALSE)
      return("")
    }
    if (file.access(dir, 2) == -1) {
      warning("snapper: save_dir path is not writeable", call. = FALSE)
      return("")
    }

    retval <- tryCatch({
      filepath <- file.path(dir, data$filename)
      imgfile <- file(filepath, "wb")
      on.exit(close(imgfile))
      base64enc::base64decode(what = imgdata, output = imgfile)
      normalizePath(filepath)
    }, error = function(err) {
      warning("snapper: image could not be saved to server", call. = FALSE)
      ""
    })

    retval
  }, force = TRUE)
}

.onUnload <- function(libpath) {
  shiny::removeInputHandler("snapper")
}
