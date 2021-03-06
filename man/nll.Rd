% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/objClass.R
\name{nll}
\alias{nll}
\title{Compute the negative log-likelihood}
\usage{
nll(nout)
}
\arguments{
\item{nout}{data.frame (result of \link{res}) or object of class \link{objframe}.}
}
\value{
list with entries value (numeric, the weighted residual sum of squares), 
gradient (numeric, gradient) and 
hessian (matrix of type numeric).
}
\description{
Compute the negative log-likelihood
}
