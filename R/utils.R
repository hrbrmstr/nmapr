# more robust than %l0%
`%l0%` <- function (x, y) if (length(x) == 0) y else x

# nmap data dir finder
.nmap_data_dir <- function() {

  sys::exec_internal(
    cmd = .nmap_bin,
    args = c("-oX", "-")
  ) -> res

  if (res$status != 0) stop("'nmap' not found.", call. = FALSE)

  resp <- rawToChar(res$stdout)

  dirname(
    normalizePath(
      stringi::stri_match_first_regex(resp, '"file:(.*\\.xsl)"')[,2]
    )
  )

}
