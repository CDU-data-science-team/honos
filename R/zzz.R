.onAttach <- function(libname, pkgname) {
  version <- read.dcf(file = system.file("DESCRIPTION", package = pkgname),
                      fields = "Version")
  packageStartupMessage("This is ", paste(pkgname, version))

  packageStartupMessage(pkgname, " is currently in development - function names and arguments may change in later versions.")
  packageStartupMessage("PLEASE REPORT ANY BUGS OR IDEAS!")

}
