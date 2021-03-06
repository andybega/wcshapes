
<!-- README.md is generated from README.Rmd. Please edit that file -->
wcshapes
========

The goal of wcshapes is to make spatial lagging with country-year but also other panel data easier.

Goals, basically none implemented yet:

-   make a spatial lagger function that plays nicely with sf tibbles
-   integrate cshapes data to make spatial lagging with country-year-like data easier
-   a country-year spatial lagger solution that respects changes in state-system membership / aka unbalanced panels
-   add multiple spatial weight options (see \#1)
-   add W normalization options (see \#2)

Installation
------------

``` r
library("remotes")
install_github("andybega/wcshapes")
```

NOPE NOT YET:

You can install the released version of wcshapes from [CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("wcshapes")
```

Example
-------

``` r
library("wcshapes")
library("sf")
#> Linking to GEOS 3.6.1, GDAL 2.1.3, PROJ 4.9.3
library("ggplot2")

data("est_adm1")

est_adm1$x <- as.integer(est_adm1$NAME_1 == "Harju")
w0 <- w_dist_power(st_geometry(est_adm1), alpha = .5)
w1 <- w_dist_power(st_geometry(est_adm1), alpha = 1)
w2 <- w_dist_power(st_geometry(est_adm1), alpha = 2)
est_adm1$x_sl0 <- as.numeric(w0 %*% est_adm1$x)
est_adm1$x_sl1 <- as.numeric(w1 %*% est_adm1$x)
est_adm1$x_sl2 <- as.numeric(w2 %*% est_adm1$x)

plot(est_adm1[, c("x", "x_sl0", "x_sl1", "x_sl2")])
```

<img src="man/figures/README-unnamed-chunk-1-1.png" width="100%" />
