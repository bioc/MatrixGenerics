% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rowTabulates.R
\name{rowTabulates}
\alias{rowTabulates}
\alias{rowTabulates,matrix_OR_array_OR_table_OR_numeric-method}
\alias{rowTabulates,ANY-method}
\alias{colTabulates}
\alias{colTabulates,matrix_OR_array_OR_table_OR_numeric-method}
\alias{colTabulates,ANY-method}
\title{Tabulates the values in a matrix-like object by row (column)}
\usage{
rowTabulates(x, rows = NULL, cols = NULL, values = NULL, ...,
  useNames = TRUE)

\S4method{rowTabulates}{matrix_OR_array_OR_table_OR_numeric}(x, rows = NULL,
  cols = NULL, values = NULL, ..., useNames = TRUE)

\S4method{rowTabulates}{ANY}(x, rows = NULL, cols = NULL, values = NULL,
  ..., useNames = TRUE)

colTabulates(x, rows = NULL, cols = NULL, values = NULL, ...,
  useNames = TRUE)

\S4method{colTabulates}{matrix_OR_array_OR_table_OR_numeric}(x, rows = NULL,
  cols = NULL, values = NULL, ..., useNames = TRUE)

\S4method{colTabulates}{ANY}(x, rows = NULL, cols = NULL, values = NULL,
  ..., useNames = TRUE)
}
\arguments{
\item{x}{An NxK matrix-like object.}

\item{rows, cols}{A \code{\link{vector}} indicating the subset of rows
(and/or columns) to operate over. If \code{\link{NULL}}, no subsetting is
done.}

\item{values}{the values to search for.}

\item{...}{Additional arguments passed to specific methods.}

\item{useNames}{If \code{\link{TRUE}} (default), names attributes of result are set. Else if \code{\link{FALSE}}, no naming support is done.}
}
\value{
a \code{\link{numeric}} \code{NxJ} (\code{KxJ})
\code{\link{matrix}}, where N (K) is the number of rows (columns) for
which the J values are calculated.
}
\description{
Tabulates the values in a matrix-like object by row (column).
}
\details{
The S4 methods for \code{x} of type \code{\link{matrix}},
\code{\link{array}}, \code{\link{table}}, or \code{\link{numeric}} call
\code{matrixStats::\link[matrixStats]{rowTabulates}} /
\code{matrixStats::\link[matrixStats]{colTabulates}}.
}
\examples{
  mat <- matrix(rpois(15, lambda = 3), nrow = 5, ncol = 3)
  mat[2, 1] <- NA_integer_
  mat[3, 3] <- 0L
  mat[4, 1] <- 0L

  print(mat)

  rowTabulates(mat)
  colTabulates(mat)

  rowTabulates(mat, values = 0)
  colTabulates(mat, values = 0)

}
\seealso{
\itemize{
\item \code{matrixStats::\link[matrixStats]{rowTabulates}()} and
\code{matrixStats::\link[matrixStats:rowTabulates]{colTabulates}()} which
are used when the input is a \code{matrix} or \code{numeric} vector.
\item \code{base::\link{table}()}
}
}
\keyword{array}
\keyword{iteration}
\keyword{robust}
\keyword{univar}
