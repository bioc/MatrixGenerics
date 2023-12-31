% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rowProds.R
\name{rowProds}
\alias{rowProds}
\alias{rowProds,matrix_OR_array_OR_table_OR_numeric-method}
\alias{rowProds,ANY-method}
\alias{colProds}
\alias{colProds,matrix_OR_array_OR_table_OR_numeric-method}
\alias{colProds,ANY-method}
\title{Calculates the product for each row (column) of a matrix-like object}
\usage{
rowProds(x, rows = NULL, cols = NULL, na.rm = FALSE, ...,
  useNames = TRUE)

\S4method{rowProds}{matrix_OR_array_OR_table_OR_numeric}(x, rows = NULL,
  cols = NULL, na.rm = FALSE, method = c("direct", "expSumLog"), ...,
  useNames = TRUE)

\S4method{rowProds}{ANY}(x, rows = NULL, cols = NULL, na.rm = FALSE, ...,
  useNames = TRUE)

colProds(x, rows = NULL, cols = NULL, na.rm = FALSE, ...,
  useNames = TRUE)

\S4method{colProds}{matrix_OR_array_OR_table_OR_numeric}(x, rows = NULL,
  cols = NULL, na.rm = FALSE, method = c("direct", "expSumLog"), ...,
  useNames = TRUE)

\S4method{colProds}{ANY}(x, rows = NULL, cols = NULL, na.rm = FALSE, ...,
  useNames = TRUE)
}
\arguments{
\item{x}{An NxK matrix-like object.}

\item{rows, cols}{A \code{\link{vector}} indicating the subset of rows
(and/or columns) to operate over. If \code{\link{NULL}}, no subsetting is
done.}

\item{na.rm}{If \code{\link[base]{TRUE}}, missing values
(\code{\link[base]{NA}} or \code{\link[base]{NaN}}) are
omitted from the calculations.}

\item{...}{Additional arguments passed to specific methods.}

\item{useNames}{If \code{\link{TRUE}} (default), names attributes of result are set. Else if \code{\link{FALSE}}, no naming support is done.}

\item{method}{A character vector of length one that specifies the
how the product is calculated. Note, that this is not a generic
argument and not all implementation have to provide it.}
}
\value{
Returns a \code{\link{numeric}} \code{\link{vector}} of length N (K).
}
\description{
Calculates the product for each row (column) of a matrix-like object.
}
\details{
The S4 methods for \code{x} of type \code{\link{matrix}},
\code{\link{array}}, \code{\link{table}}, or \code{\link{numeric}} call
\code{matrixStats::\link[matrixStats]{rowProds}} /
\code{matrixStats::\link[matrixStats]{colProds}}.
}
\examples{
mat <- matrix(rnorm(15), nrow = 5, ncol = 3)
mat[2, 1] <- NA
mat[3, 3] <- Inf
mat[4, 1] <- 0

print(mat)

rowProds(mat)
colProds(mat)
}
\seealso{
\itemize{
\item \code{matrixStats::\link[matrixStats]{rowProds}()} and
\code{matrixStats::\link[matrixStats:rowProds]{colProds}()} which are used
when the input is a \code{matrix} or \code{numeric} vector.
\item For sums across rows (columns), see
\code{\link{rowSums2}()} (\code{\link[=colSums2]{colSums2()}})
\item \code{base::\link{prod}()}.
}
}
\keyword{array}
\keyword{iteration}
\keyword{robust}
\keyword{univar}
