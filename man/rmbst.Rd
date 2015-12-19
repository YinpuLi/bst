\name{rmbst}
\alias{rmbst}
\title{ Robust Boosting for Multi-class Truncated Loss Functions}
\description{
  Gradient boosting for optimizing robust loss functions with componentwise
  linear, smoothing splines, tree models as base learners.
}

\usage{
rmbst(x, y, cost = 0.5, rfamily = "thinge", threshold = c("adaptive", "standard"), 
ctrl=bst_control(),control.tree=list(maxdepth = 1),learner=c("ls","sm","tree"),del=1e-10)
}
\arguments{
  \item{x}{ a data frame containing the variables in the model.}
  \item{y}{ vector of responses. \code{y} must be in \{1, 2, ..., k\}. }
  \item{cost}{ price to pay for false positive, 0 < \code{cost} < 1; price of false negative is 1-\code{cost}.}
  \item{rfamily}{ \code{family} = "thinge" is currently implemented.}
  \item{threshold}{ if \code{threshold="adaptive"}, the estimated function is updated in every boosting step when invoking \code{rbst} function. Otherwise, no update in boosting steps.}
  \item{ctrl}{ an object of class \code{\link{bst_control}}.}
  \item{control.tree}{ control parameters of rpart. }
  \item{learner}{ a character specifying the component-wise base learner to be used:
      \code{ls} linear models, 
      \code{sm} smoothing splines,
      \code{tree} regression trees.
}
  \item{del}{convergency critera}
}
\details{
 A linear or nonlinear classifier is fitted using robust boosting algorithm. 
}
\value{
  An object of class \code{bst} with \code{\link{print}}, \code{\link{coef}},
  \code{\link{plot}} and \code{\link{predict}} methods are available for linear models.
  For nonlinear models, methods \code{\link{print}} and \code{\link{predict}} are available.
\item{x, y, cost, rfamily, learner, control.tree, maxdepth}{These are input variables and parameters}
\item{ctrl}{the input \code{ctrl} with possible updated \code{fk} if \code{type="adaptive"}}
\item{yhat}{predicted function estimates}
\item{ens}{a list of length \code{mstop}. Each element is a fitted model to the psedo residuals, defined as negative gradient of loss function at the current estimated function}
\item{ml.fit}{the last element of \code{ens}}
\item{ensemble}{a vector of length \code{mstop}. Each element is the variable selected in each boosting step when applicable}
\item{xselect}{selected variables in \code{mstop}}
\item{coef}{estimated coefficients in \code{mstop}}
}
\seealso{\code{\link{cv.mbst}} for cross-validated stopping iteration. Furthermore see
  \code{\link{bst_control}}}

\author{ Zhu Wang }
\examples{
x <- matrix(rnorm(100*5),ncol=5)
c <- quantile(x[,1], prob=c(0.33, 0.67))
y <- rep(1, 100)
y[x[,1] > c[1] & x[,1] < c[2] ] <- 2
y[x[,1] > c[2]] <- 3
x <- as.data.frame(x)
x <- as.data.frame(x)
dat.m <- mbst(x, y, ctrl = bst_control(mstop=50), family = "hinge", learner = "ls")
predict(dat.m)
dat.m1 <- mbst(x, y, ctrl = bst_control(twinboost=TRUE, 
f.init=predict(dat.m), xselect.init = dat.m$xselect, mstop=50))
dat.m2 <- rmbst(x, y, ctrl = bst_control(mstop=50, s=1, trace=TRUE), 
rfamily = "thinge", learner = "ls")
predict(dat.m2)
}
\keyword{classification}