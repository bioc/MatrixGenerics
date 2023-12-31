% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rowSdDiffs.R
\name{rowSdDiffs}
\alias{rowSdDiffs}
\alias{rowSdDiffs,matrix_OR_array_OR_table_OR_numeric-method}
\alias{rowSdDiffs,ANY-method}
\alias{colSdDiffs}
\alias{colSdDiffs,matrix_OR_array_OR_table_OR_numeric-method}
\alias{colSdDiffs,ANY-method}
\title{Calculates the standard deviation of the difference between each element of
a row (column) of a matrix-like object}
\usage{
rowSdDiffs(x, rows = NULL, cols = NULL, na.rm = FALSE, diff = 1L,
  trim = 0, ..., useNames = TRUE)

\S4method{rowSdDiffs}{matrix_OR_array_OR_table_OR_numeric}(x, rows = NULL,
  cols = NULL, na.rm = FALSE, diff = 1L, trim = 0, ...,
  useNames = TRUE)

\S4method{rowSdDiffs}{ANY}(x, rows = NULL, cols = NULL, na.rm = FALSE,
  diff = 1L, trim = 0, ..., useNames = TRUE)

colSdDiffs(x, rows = NULL, cols = NULL, na.rm = FALSE, diff = 1L,
  trim = 0, ..., useNames = TRUE)

\S4method{colSdDiffs}{matrix_OR_array_OR_table_OR_numeric}(x, rows = NULL,
  cols = NULL, na.rm = FALSE, diff = 1L, trim = 0, ...,
  useNames = TRUE)

\S4method{colSdDiffs}{ANY}(x, rows = NULL, cols = NULL, na.rm = FALSE,
  diff = 1L, trim = 0, ..., useNames = TRUE)
}
\arguments{
\item{x}{An NxK matrix-like object.}

\item{rows, cols}{A \code{\link{vector}} indicating the subset of rows
(and/or columns) to operate over. If \code{\link{NULL}}, no subsetting is
done.}

\item{na.rm}{If \code{\link[base]{TRUE}}, missing values
(\code{\link[base]{NA}} or \code{\link[base]{NaN}}) are
omitted from the calculations.}

\item{diff}{An integer specifying the order of difference.}

\item{trim}{A double in [0,1/2] specifying the fraction of observations to
be trimmed from each end of (sorted) x before estimation.}

\item{...}{Additional arguments passed to specific methods.}

\item{useNames}{If \code{\link{TRUE}} (default), names attributes of result are set. Else if \code{\link{FALSE}}, no naming support is done.}
}
\value{
Returns a \code{\link{numeric}} \code{\link{vector}} of length N (K).
}
\description{
Calculates the standard deviation of the difference between each element of
a row (column) of a matrix-like object.
}
\details{
The S4 methods for \code{x} of type \code{\link{matrix}},
\code{\link{array}}, \code{\link{table}}, or \code{\link{numeric}} call
\code{matrixStats::\link[matrixStats]{rowSdDiffs}} /
\code{matrixStats::\link[matrixStats]{colSdDiffs}}.
}
\examples{
mat <- matrix(rnorm(15), nrow = 5, ncol = 3)
mat[2, 1] <- NA
mat[3, 3] <- Inf
mat[4, 1] <- 0

print(mat)

rowSdDiffs(mat)
colSdDiffs(mat)
}
\seealso{
\itemize{
\item \code{matrixStats::\link[matrixStats:varDiff]{rowSdDiffs}()} and
\code{matrixStats::\link[matrixStats:varDiff]{colSdDiffs}()} which are
used when the input is a \code{matrix} or \code{numeric} vector.
\item for the direct standard deviation see \code{\link[=rowSds]{rowSds()}}.
}
}
\keyword{array}
\keyword{iteration}
\keyword{robust}
\keyword{univar}
