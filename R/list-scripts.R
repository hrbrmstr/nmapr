#' Retrieve descriptioin for an NSE script
#'
#' @md
#' @param nse_file name (with or without extension) of the NSE script
#' @param cat if `FALSE` the NSE script description will not be displayed to the console
#' @export
read_script_description <- function(nse_file, cat=TRUE) {

  nse_file <- basename(nse_file)
  nse_file <- sprintf("%s.nse", tools::file_path_sans_ext(nse_file))

  script_path <- file.path(.nmap_data_dir(), "scripts", nse_file)
  l <- stri_read_lines(script_path)
  pos <- which(stri_detect_regex(l, "^description|^\\]\\]"))
  l <- l[pos[1]:pos[2]]
  stri_replace_first_regex(l, "^description = \\[\\[", "") %>%
    stri_replace_first_regex("^\\]\\]", "") %>%
    purrr::discard(`==`, "") %>%
    paste0(collapse="\n") -> out

  if (cat) cat(out)

  out

}

#' @rdname read_script_description
#' @export
nse_descr <- read_script_description

#' List available NSE scripts
#'
#' @md
#' @export
list_available_scripts <- function() {

  script_db_path <- file.path(.nmap_data_dir(), "scripts", "script.db")

  stri_read_lines(script_db_path) %>%
    stri_replace_first_fixed("Entry {", "{") %>%
    stri_replace_first_fixed("filename =", '"filename" :') %>%
    stri_replace_first_fixed("categories = {", '"categories" : [') %>%
    stri_replace_last_fixed(", } }", " ] }") %>%
    paste0(collapse="\n") %>%
    textConnection() %>%
    jsonlite::stream_in(verbose = FALSE) -> xdf

  class(xdf) <- c("tbl_df", "tbl", "data.frame")
  xdf

}

#' @name nse_list
#' @rdname list_available_scripts
#' @export
nse_list <- list_available_scripts
