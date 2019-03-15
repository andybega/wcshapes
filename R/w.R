
w_dist <- function(x) {
  x %>%
    sf::st_centroid() %>%
    sf::st_distance() %>%
    units::set_units("km")
}

#' Inverse distance weight
#'
#' Power distance weights.
#'
#' @param x a geometry collection
#' @param alpha exponent for distance weights
#'
#' @examples
#' data("est_adm1")
#' w <- w_dist_power(sf::st_geometry(est_adm1), alpha = 1)
#'
#' @export
w_dist_power <- function(x, alpha = 1) {
  dist_mat <- w_dist(x)

  # apply power transform
  w <- dist_mat %>%
    unclass() %>%
    `^`(., -alpha) %>%
    `diag<-`(0)

  # row-normalize
  w <- apply(w, 1, function(x) {
    x * 1 / sum(x)
  }) %>% t()

  w
}
