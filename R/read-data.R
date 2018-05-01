# stri_read_lines("/usr/local/share/nmap/nmap-mac-prefixes") %>%
#   purrr::discard(stri_detect_regex, "^#") %>%
#   stri_split_fixed(pattern = " ", n = 2, simplify = TRUE) %>%
#   as.data.frame(stringsAsFactors = FALSE) %>%
#   purrr::set_names(c("mac_prefix", "org")) -> mac_prefixes
# class(mac_prefixes) <- c("tbl_df", "tbl", "data.frame")

