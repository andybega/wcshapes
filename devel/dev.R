#
#   1. do stuff to the package
#
#   2. Keep track of major changes in NEWS.md
#

library("cshapes")
library("network")

world_geom <- cshp(date = as.Date("2015-01-01"))

X11(type='cairo')

geom <- world_geom
W <- spdep::poly2nb(geom)

capitals <- coordinates(data.frame(x = geom@data$CAPLONG, y = geom@data$CAPLAT))
plot(geom)
plot(W, capitals, add = TRUE, col = "gray50")

W <- spdep::nb2mat(W, zero.policy = TRUE)

W2 <- contiguity(geom)


plot.network(network(W2, directed = FALSE),
             coord = capitals, add = TRUE)
plot(geom, add = TRUE)

W[1:5, 1:5]; W2[1:5, 1:5]

library("devtools")

devtools::install_github("ahalterman/phoxy")

library("phoxy")
library("rvest")
library("XML2")
library("plyr")
library("dplyr")


library("covr")
library("shiny")

#devtools::use_testthat()

if (!requireNamespace("pkg", quietly = TRUE)) {
  stop("Pkg needed for this function to work. Please install it.",
       call. = FALSE)
}

# Test coverage
cov <- package_coverage()
shine(cov)

# Check local
devtools::load_all()
devtools::test()
devtools::document()
devtools::check()

#   Ready for building the whole package
#   _______________
#
#   3. Update date and version in DESCRIPTION:
#         [major][minor][patch][dev]
#           - major: not backwards compatible
#           - minor: feature enhancements
#           - patch: fixes bugs
#           - dev (9000): working version
#
#   4. Check/test the packge, fix bugs, errors, warnings, notes that come up
#

file.copy("NEWS.md", "NEWS", overwrite=TRUE)

desc <- readLines("DESCRIPTION")
vers <- desc[grep("Version", desc)]
vers <- stringr::str_extract(vers, "[0-9\\.]+")

devtools::build()
devtools::install_local(paste0("../phoxydb_", vers, ".tar.gz"))

# Check Windows, R devel and release
build_win(version = "R-release")
build_win(version = "R-devel")

# commit to git and check travis
# https://travis-ci.org

#
#   5. Update cran-comments.md
#      Release to CRAN
#
R.Version()$version.string

devtools::release()
