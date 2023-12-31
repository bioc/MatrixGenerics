% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rowCollapse.R
\name{rowCollapse}
\alias{rowCollapse}
\alias{rowCollapse,matrix_OR_array_OR_table_OR_numeric-method}
\alias{rowCollapse,ANY-method}
\alias{colCollapse}
\alias{colCollapse,matrix_OR_array_OR_table_OR_numeric-method}
\alias{colCollapse,ANY-method}
\title{Extract one cell from each row (column) of a matrix-like object}
\usage{
rowCollapse(x, idxs, rows = NULL, ..., useNames = TRUE)

\S4method{rowCollapse}{matrix_OR_array_OR_table_OR_numeric}(x, idxs,
  rows = NULL, dim. = dim(x), ..., useNames = TRUE)

\S4method{rowCollapse}{ANY}(x, idxs, rows = NULL, ..., useNames = TRUE)

colCollapse(x, idxs, cols = NULL, ..., useNames = TRUE)

\S4method{colCollapse}{matrix_OR_array_OR_table_OR_numeric}(x, idxs,
  cols = NULL, dim. = dim(x), ..., useNames = TRUE)

\S4method{colCollapse}{ANY}(x, idxs, cols = NULL, ..., useNames = TRUE)
}
\arguments{
\item{x}{An NxK matrix-like object.}

\item{idxs}{An index \code{\link{vector}} with the position to extract.
It is recycled to match the number of rows (column)}

\item{rows, cols}{A \code{\link{vector}} indicating the subset of rows
(and/or columns) to operate over. If \code{\link{NULL}}, no subsetting is
done.}

\item{...}{Additional arguments passed to specific methods.}

\item{useNames}{If \code{\link{TRUE}} (default), names attributes of result are set. Else if \code{\link{FALSE}}, no naming support is done.}

\item{dim.}{An \code{\link{integer}} \code{\link{vector}} of length two
specifying the dimension of \code{x}, essential when x is a
\code{\link{numeric}} vector. Note, that this is not a generic
argument and not all methods need provide it.}
}
\value{
Returns a \code{\link{numeric}} \code{\link{vector}} of length N (K).
}
\description{
Extract one cell from each row (column) of a matrix-like object.
}
\details{
The S4 methods for \code{x} of type \code{\link{matrix}},
\code{\link{array}}, \code{\link{table}}, or \code{\link{numeric}} call
\code{matrixStats::\link[matrixStats]{rowCollapse}} /
\code{matrixStats::\link[matrixStats]{colCollapse}}.
}
\examples{
  mat <- matrix(rnorm(15), nrow = 5, ncol = 3)
  mat[2, 1] <- NA
  mat[3, 3] <- Inf
  mat[4, 1] <- 0

  print(mat)

  rowCollapse(mat, idxs = 2)
  rowCollapse(mat, idxs = c(1,1,2,3,2))

  colCollapse (mat, idxs = 4)

}
\seealso{
\itemize{
\item \code{matrixStats::\link[matrixStats:rowCollapse]{rowCollapse}()}
and \code{matrixStats::\link[matrixStats:rowCollapse]{colCollapse}()}
which are used when the input is a \code{matrix} or \code{numeric} vector.
}
}
\keyword{array}
\keyword{iteration}
\keyword{robust}
\keyword{univar}
