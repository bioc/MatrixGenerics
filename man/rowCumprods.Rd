% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rowCumprods.R
\name{rowCumprods}
\alias{rowCumprods}
\alias{rowCumprods,matrix_OR_array_OR_table_OR_numeric-method}
\alias{rowCumprods,ANY-method}
\alias{colCumprods}
\alias{colCumprods,matrix_OR_array_OR_table_OR_numeric-method}
\alias{colCumprods,ANY-method}
\title{Calculates the cumulative product for each row (column) of a matrix-like
object}
\usage{
rowCumprods(x, rows = NULL, cols = NULL, ..., useNames = TRUE)

\S4method{rowCumprods}{matrix_OR_array_OR_table_OR_numeric}(x, rows = NULL,
  cols = NULL, dim. = dim(x), ..., useNames = TRUE)

\S4method{rowCumprods}{ANY}(x, rows = NULL, cols = NULL, ...,
  useNames = TRUE)

colCumprods(x, rows = NULL, cols = NULL, ..., useNames = TRUE)

\S4method{colCumprods}{matrix_OR_array_OR_table_OR_numeric}(x, rows = NULL,
  cols = NULL, dim. = dim(x), ..., useNames = TRUE)

\S4method{colCumprods}{ANY}(x, rows = NULL, cols = NULL, ...,
  useNames = TRUE)
}
\arguments{
\item{x}{An NxK matrix-like object.}

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
Returns a \code{\link{numeric}} \code{\link{matrix}}with the same
dimensions as \code{x}.
}
\description{
Calculates the cumulative product for each row (column) of a matrix-like
object.
}
\details{
The S4 methods for \code{x} of type \code{\link{matrix}},
\code{\link{array}}, \code{\link{table}}, or \code{\link{numeric}} call
\code{matrixStats::\link[matrixStats]{rowCumprods}} /
\code{matrixStats::\link[matrixStats]{colCumprods}}.
}
\examples{
mat <- matrix(rnorm(15), nrow = 5, ncol = 3)
mat[2, 1] <- NA
mat[3, 3] <- Inf
mat[4, 1] <- 0

print(mat)

rowCumprods(mat)
colCumprods(mat)
}
\seealso{
\itemize{
\item \code{matrixStats::\link[matrixStats:rowCumsums]{rowCumprods}()} and
\code{matrixStats::\link[matrixStats:rowCumsums]{colCumprods}()} which
are used when the input is a \code{matrix} or \code{numeric} vector.
\item \code{base::\link{cumprod}()}.
}
}
\keyword{array}
\keyword{iteration}
\keyword{robust}
\keyword{univar}
