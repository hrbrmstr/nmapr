.nmap_bin <- unname(Sys.which("nmap"))

.onLoad <- function(libname, pkgname) {

  if (.nmap_bin == "") {
    packageStartupMessage(
      paste0(
        c(
          "'nmap' binary not found. Make sure 'nmap' is installed and on the system PATH. ",
          "Please see <https://nmap.org/book/install.html> for how to obtain and install ",
          "'nmap' on your system."
        ),
        collapse=""
      )
    )
  }

}


