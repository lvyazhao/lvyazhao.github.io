\name{realRatingMatrix-class}
\Rdversion{1.1}
\docType{class}
\alias{realRatingMatrix-class}
\alias{coerce,matrix,realRatingMatrix-method}
\alias{coerce,realRatingMatrix,matrix-method}
\alias{coerce,realRatingMatrix,dgTMatrix-method}
\alias{coerce,realRatingMatrix,ngCMatrix-method}
\alias{coerce,realRatingMatrix,dgCMatrix-method}
\alias{coerce,data.frame,realRatingMatrix-method}
\alias{rowSds}
\alias{rowSds,realRatingMatrix-method}
\alias{colSds}
\alias{colSds,realRatingMatrix-method}
%\alias{LIST,realRatingMatrix-method}
\alias{binarize}
\alias{binarize,realRatingMatrix-method}
\alias{getRatings}
\alias{getRatings,realRatingMatrix-method}
\alias{removeKnownRatings}
\alias{removeKnownRatings,realRatingMatrix-method}

\title{Class "realRatingMatrix": Real-valued Rating Matrix}
\description{A matrix containing ratings (typically 1-5 stars, etc.).}
\section{Objects from the Class}{
Objects can be created by calls of the form \code{new("realRatingMatrix", data = m)}, where \code{m} is sparse matrix of class \code{dgCMatrix} 
(see package \pkg{Matrix}), or by coercion from a regular matrix.
}
\section{Slots}{
    \describe{
	\item{\code{data}:}{Object of class \code{"dgCMatrix"}, a sparse matrix
	    defined in package \pkg{Matrix}.}
    }
}
\section{Extends}{
Class \code{"\linkS4class{ratingMatrix}"}, directly.
}
\section{Methods}{
  \describe{
    \item{coerce}{\code{signature(from = "matrix", to = "realRatingMatrix")}} 
    \item{coerce}{\code{signature(from = "realRatingMatrix", to = "matrix")}}
    \item{coerce}{\code{signature(from = "data.frame", to = "realRatingMatrix")}: 
	coercion from a data.frame with three columns. 
	Col 1 contains user ids, col 2 contains	item ids and 
	col 3 contains ratings.}
    \item{coerce}{\code{signature(from = "realRatingMatrix", to = "dgTMatrix")}}
    \item{coerce}{\code{signature(from = "realRatingMatrix", to = "ngCMatrix")}}
    \item{coerce}{\code{signature(from = "realRatingMatrix", to = "dgCMatrix")}}
    
    \item{binarize}{\code{signature(x = "realRatingMatrix")}: create a 
        \code{"binaryRatingMatrix"} by setting all ratings larger or equal to 
        the argument \code{minRating} as 1 and all others to 0.}
    \item{getRatings}{\code{signature(x = "realRatingMatrix")}: returns all 
	ratings in \code{x} as a numeric vector. }
    \item{removeKnownRatings}{\code{signature(x = "realRatingMatrix")}: removes
	all ratings in \code{x} for which ratings are available in 
	the realRatingMatrix (of same dimensions as \code{x})
	passed as the argument \code{known}. }
    \item{rowSds}{\code{signature(x = "realRatingMatrix")}: calculate 
	the standard deviation of ratings for rows (users).}
    \item{colSds}{\code{signature(x = "realRatingMatrix")}: calculate 
	the standard deviation of ratings for columns (items).}
	 }
}
\seealso{
	See \code{\linkS4class{ratingMatrix}} inherited methods,
	\code{\linkS4class{binaryRatingMatrix}}, 
	\code{\linkS4class{topNList}}, 
	\code{\link{getList}} and \code{\link{getData.frame}}.
	Also see \code{\link[Matrix:dgCMatrix-class]{dgCMatrix}},
	\code{\link[Matrix:dgCMatrix-class]{dgTMatrix}} and
	\code{\link[Matrix:dgCMatrix-class]{ngCMatrix}}
	in \pkg{Matrix}.
}
\examples{
## create a matrix with ratings
m <- matrix(sample(c(NA,0:5),100, replace=TRUE, prob=c(.7,rep(.3/6,6))), 
	nrow=10, ncol=10, dimnames = list(
	    user=paste('u', 1:10, sep=''),
	    item=paste('u', 1:10, sep='')    
    ))
m

## coerce into a realRatingMAtrix
r <- as(m, "realRatingMatrix")
r

## get some information
dimnames(r)
rowCounts(r)
colCounts(r)
rowMeans(r)


## histogram of ratings
hist(getRatings(r), breaks="FD")

## inspect a subset
image(r[1:5,1:5])

## coerce it back to see if it worked
as(r, "matrix")

## coerce to data.frame
as(r, "data.frame")

## binarize into a binaryRatingMatrix with all 4+ rating a 1
b <- binarize(r, minRating=4)
b
as(b, "matrix")
}
\keyword{classes}
