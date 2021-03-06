% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/descriptions.R
\name{as_cluster_desc}
\alias{as_cluster_desc}
\title{Describe clusters}
\usage{
as_cluster_desc(
  x,
  return = c("cluster", "super_cluster"),
  super_cluster_details = FALSE
)
}
\arguments{
\item{x}{Vector of numeric values ranging from 0 to 21}
}
\value{
Labelled "factor"
}
\description{
Describe clusters
}
\examples{
x <- 0:21
# Return clusters (0 to 21)
as_cluster_desc(x)
# Return super clusters (A to C)
as_cluster_desc(x,
                return = "super_cluster")
# Return detailed super clusters
as_cluster_desc(x,
                return = "super_cluster",
                super_cluster_details = TRUE)
}
