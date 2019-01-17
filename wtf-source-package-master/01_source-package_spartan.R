#' In a temporary library, do the following.
## Before each installation restart R to avoid errors due to having the
## previous version installed.

#' Install the ps _source_ package from CRAN
devtools::install_cran("ps", lib = "~/tmp")

#' Load the package from the temporary library and try running `ps()`
library(ps, lib.loc = "~/tmp")
ps()

#' Install the develpment version of the ps package
devtools::install_github("r-lib/ps", lib = "~/tmp")

#' Install version 1.2.0 of the ps package from CRAN
devtools::install_github("r-lib/ps@v1.2.0", lib = "~/tmp")

#' Stretch goal
#' If that went well try installing the source version of git2r.
## git2r has more complicated dependencies and takes longer to compile, but
## it should install without problems
