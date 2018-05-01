#' Check `nmap` version
#'
#' @md
#' @export
nmap_version <- function() {

  sys::exec_internal(
    cmd = .nmap_bin,
    args = c("--version")
  ) -> res

  if (res$status != 0) stop("'nmap' not found.", call. = FALSE)

  cat(rawToChar(res$stdout))

}