% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/w.R
\name{w_dist_power}
\alias{w_dist_power}
\title{Inverse distance weight}
\usage{
w_dist_power(x, alpha = 1)
}
\arguments{
\item{x}{a geometry collection}

\item{alpha}{exponent for distance weights}
}
\description{
Power distance weights.
}
\examples{
data("est_adm1")
w <- w_dist_power(sf::st_geometry(est_adm1), alpha = 1)

}
