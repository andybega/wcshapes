

spatlag_base <- function(geom, x, ccode, lagger, ...) {
  w <- lagger(geom, ...)
  xlag <- as.vector(t(x) %*% w)
  xlag
}

spatlag <- function(x, ccode, date, useGW = TRUE, lagger, ...) {
  UseMethod("spatlag", x)
}


spatlag.numeric <- function(x, ccode, date, useGW = TRUE, lagger, ...) {
  # TODO
  # - vectorize

  # list of geoms by date
  geom <- cshp(date = date, useGW = useGW)

  # apply spatlag over geom
  xlag <- spatlag_base(geom, x, ccode, lagger, ...)
  xlag
}

spatlag.data.frame <- function(x, ccode, date, useGW = TRUE, lagger, data, ...) {
  NULL
}
