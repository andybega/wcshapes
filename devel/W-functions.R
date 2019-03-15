#' K-nearest neighbors weights matrix
#'
#' @param geom
#' @param k
knn <- function(geom, k) {

  coords <- coordinates(geom)

  # knn4 W matrix
  x <- spdep::knearneigh(coords, k=k)
  x <- spdep::knn2nb(x)
  W <- spdep::nb2mat(x)

  W
}

#' Contiguity weights matrix
#'
#' @param geom
#'
contiguity <- function(geom, queen = TRUE) {
  x <- spdep::poly2nb(geom, queen = queen)

  style <- "W"
  W <- spdep::nb2mat(x, style = style, zero.policy = TRUE)

  attr(W, "group") <- "contiguity"
  attr(W, "type")  <- ifelse(queen, "queen", "rook")
  attr(W, "style") <- style
  W
}
