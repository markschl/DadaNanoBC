
.env <- new.env(parent = emptyenv())
.env$opts <- list()

#' Set global options
#'
#' Convenience function for setting global options such as program paths.
#'
#' @details
#' The following options can be set:
#' - Required program paths (`samtools`, `minimap2`, `seqtool`, `vsearch`)
#' - `tmp_dir`: Path to a custom temporary directory for short-lived
#'   data and not overly large data. On Linux, the default is to place these files
#'   in a subdirectory of `$XDG_RUNTIME_DIR` (usually `/run/user/<userid>`, tmpfs).
#'
#' Under the hood, this simply does `options(DadaNanoBC.opt = 'value', ...)`.
#'
#' The same options can be set as environment variables:
#' `DadaNanoBC_opt=value` (in R: `Sys.setenv(DadaNanoBC_opt = 'value')`.
#' `set_global_opt` always has priority over environment variables.
#'
#' @examples
#' set_global_opts(samtools = '/path/to/samtools', tmp_dir = '/tmp/nanopore-barcoding')
#'
#' @export
set_global_opts <- function(...) {
  o <- list(...)
  if (length(o) == 0)
    return()
  names(o) <- paste0('DadaNanoBC.', names(o))
  do.call(options, o)
  invisible(NULL)
}

get_opt <- function(o, default = NULL) {
  value <- .env$vars[[o]]
  if (!is.null(value)) {
    return(value)
  }
  value <- getOption(paste0('DadaNanoBC.', o))
  if (is.null(value)) {
    value <- Sys.getenv(paste0('DadaNanoBC_', o))
    if (!nzchar(value)) {
      if (is.null(value <- default)) {
        return(NULL)
      }
    }
  }
  .env$opts[[o]] <- value
  value
}

get_create_tmp_dir <- function(tmp_dir = NULL) {
  if (is.null(tmp_dir)) {
    tmp_dir <- get_opt('tmp_dir')
    if (is.null(tmp_dir)) {
      tmp_dir <- Sys.getenv('XDG_RUNTIME_DIR')
      if (!nzchar(tmp_dir)) {
        tmp_dir <- tempdir()
      } else {
        tmp_dir <- file.path(tmp_dir, 'DadaNanoBC')
      }
      .env$opts$tmp_dir <- tmp_dir
    }
  }
  dir.create(tmp_dir, FALSE, TRUE)
  tmp_dir
}
