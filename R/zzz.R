.onAttach <- function(libname, pkgname) {
  version <- read.dcf(file = system.file("DESCRIPTION", package = pkgname),
                      fields = "Version")
  packageStartupMessage("This is ", paste(pkgname, version))
  packageStartupMessage(pkgname, " is currently in development - please report any bugs or ideas at:")
  packageStartupMessage("https://github.com/CDU-data-science-team/honos/issues")
}
