#' Report SSL Certificate Configuration Strength for one or more hosts
#'
#' This calls `nmap` with the `ssl-enum-ciphers` script. Said script repeatedly
#' initiates SSL/TLS connections, each time trying a new cipher or compressor
#' while recording whether a host accepts or rejects it. The end result is a
#' list of all the ciphers and compressors that a server accepts
#'
#' @md
#' @note Running this script is _intrusive_ since it must initiate many connections
#'       to a server, and therefore is quite noisy. It may take several minutes
#'       _per-host_.
#' @param hosts character. hostnames/IPs address to connect too
#' @param port port to connect to. Defaults to `443`
# @param display_html if `TRUE`, an `nmap` XSLT-transformed report will be
#        presented in the HTML viewer (the scan data is still returned)
#' @export
test_ssl_strength <- function(host, port=443L) {#}, display_html=FALSE) {

  sys::exec_internal(
    .nmap_bin,
    c(
      "-oX", "-",
      "--script", "ssl-enum-ciphers",
      "-p", as.character(port),
      as.character(host)
    )
  ) -> res

  if (res$status == 0) {

    rpt <- xml2::read_xml(res$stdout)

    hosts <- xml2::xml_find_all(rpt, ".//host")

    purrr::map(hosts, ~{

      doc <- .x

      host <- xml2::xml_find_first(doc, ".//hostname[@type='user']") %>%
        xml2::xml_attr("name")

      least_strength <- (xml2::xml_find_all(doc, ".//elem[@key='least strength']") %>%
        xml2::xml_text()) %l0% NA

      sdat <- xml2::xml_find_first(doc, ".//script[@id='ssl-enum-ciphers']")

      tb <- xml2::xml_find_all(sdat, "./table")
      if (length(tb) > 0) {
        purrr::map_df(tb, ~{
          data.frame(
            name = xml2::xml_find_all(.x, "./table[@key='ciphers']/table/elem[@key='name']") %>% xml2::xml_text(),
            kex_info = xml2::xml_find_all(.x, "./table[@key='ciphers']/table/elem[@key='kex_info']") %>% xml2::xml_text(),
            strength = xml2::xml_find_all(.x, "./table[@key='ciphers']/table/elem[@key='strength']") %>% xml2::xml_text(),
            stringsAsFactors=FALSE
          ) -> ciphers
          ciphers$host <- host
          ciphers$key <- xml2::xml_attr(.x, "key")
          ciphers
        }) -> ciphers
        ciphers <- ciphers[,c("host", "key", "name", "kex_info", "strength")]
        class(ciphers) <- c("tbl_df", "tbl", "data.frame")
      } else {
        ciphers <- NULL
      }

      tb <- xml2::xml_find_all(sdat, "./table")
      if (length(tb) > 0) {
        purrr::map_df(tb, ~{
          wrngs <- xml2::xml_find_first(.x, "./table[@key='warnings']")
          data.frame(
            warnings = (xml2::xml_find_all(wrngs, "./elem") %>% xml2::xml_text()) %l0% NA_character_,
            stringsAsFactors = FALSE
          ) -> wrngs_df
          wrngs_df$host <- host
          wrngs_df$key <- xml2::xml_attr(.x, "key")
          wrngs_df
        }) -> wrngs
        wrngs <- wrngs[,c("host", "key", "warnings")]
        class(wrngs) <- c("tbl_df", "tbl", "data.frame")
      } else {
        wrngs <- NULL
      }

      tb <- xml2::xml_find_all(sdat, "./table")
      if (length(tb) > 0) {
        purrr::map_df(tb, ~{
          data.frame(
            cipher_pref = (xml2::xml_find_all(.x, "./elem[@key='cipher preference']") %>% xml2::xml_text()) %||% NA_character_,
            stringsAsFactors = FALSE
          ) -> cipher_pref
          cipher_pref$key <- xml2::xml_attr(.x, "key")
          cipher_pref
        }) -> cipher_pref
        cipher_pref$host <- host
        cipher_pref <- cipher_pref[,c("host", "key", "cipher_pref")]
        class(cipher_pref) <- c("tbl_df", "tbl", "data.frame")
      } else {
        cipher_pref <- NULL
      }

      data.frame(
        host = host,
        port = port,
        least_strength = least_strength,
        stringsAsFactors = FALSE
      ) -> host_meta
      host_meta$n_warnings <- sum(!is.na(wrngs$warnings))
      class(host_meta) <- c("tbl_df", "tbl", "data.frame")

      # if (display_html){
      #   .nmap_xsl <- xml2::read_xml(system.file("xslt", "nmap.xsl", package="nmapr"))
      #   xslt::xml_xslt(doc, .nmap_xsl) %>%
      #     as.character() %>%
      #     htmltools::HTML() %>%
      #     htmltools::html_print()
      # }

      list(
        host_meta = host_meta,
        ciphers = ciphers,
        cipher_pref = cipher_pref,
        warnings = wrngs
      )

    }) -> out

    list(
      host_meta = purrr::map_df(out, "host_meta"),
      ciphers = purrr::map_df(out, "ciphers"),
      cipher_pref =purrr::map_df(out, "cipher_pref"),
      warnings = purrr::map_df(out, "warnings")
    ) -> out

    class(out) <- "nmap_ssl_enum_ciphers"

    out

  } else {
    NULL
  }

}
