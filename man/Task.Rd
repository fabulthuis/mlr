% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ClassifTask.R, R/ClusterTask.R, R/CostSensTask.R, R/MultilabelTask.R, R/RegrTask.R, R/SurvTask.R, R/Task.R
\name{makeClassifTask}
\alias{ClassifTask}
\alias{ClusterTask}
\alias{CostSensTask}
\alias{MultilabelTask}
\alias{RegrTask}
\alias{SurvTask}
\alias{Task}
\alias{makeClassifTask}
\alias{makeClusterTask}
\alias{makeCostSensTask}
\alias{makeMultilabelTask}
\alias{makeRegrTask}
\alias{makeSurvTask}
\title{Create a classification, regression, survival, cluster, cost-sensitive classification or
multilabel task.}
\usage{
makeClassifTask(id = deparse(substitute(data)), data, target,
  weights = NULL, blocking = NULL, positive = NA_character_,
  fixup.data = "warn", check.data = TRUE)

makeClusterTask(id = deparse(substitute(data)), data, weights = NULL,
  blocking = NULL, fixup.data = "warn", check.data = TRUE)

makeCostSensTask(id = deparse(substitute(data)), data, costs,
  blocking = NULL, fixup.data = "warn", check.data = TRUE)

makeMultilabelTask(id = deparse(substitute(data)), data, target,
  weights = NULL, blocking = NULL, positive = NA_character_,
  fixup.data = "warn", check.data = TRUE)

makeRegrTask(id = deparse(substitute(data)), data, target, weights = NULL,
  blocking = NULL, fixup.data = "warn", check.data = TRUE)

makeSurvTask(id = deparse(substitute(data)), data, target,
  censoring = "rcens", weights = NULL, blocking = NULL,
  fixup.data = "warn", check.data = TRUE)
}
\arguments{
\item{id}{[\code{character(1)}]\cr
Id string for object.
Default is the name of the R variable passed to \code{data}.}

\item{data}{[\code{data.frame}]\cr
A data frame containing the features and target variable(s).}

\item{target}{[\code{character(1)} | \code{character(2)} | \code{character(n.classes)}]\cr
Name(s) of the target variable(s).
For survival analysis these are the names of the survival time and event columns,
so it has length 2. For multilabel classification it contains the names of the logical
columns that encode whether a label is present or not and its length corresponds to the
number of classes.}

\item{weights}{[\code{numeric}]\cr
Optional, non-negative case weight vector to be used during fitting.
Cannot be set for cost-sensitive learning.
Default is \code{NULL} which means no (= equal) weights.}

\item{blocking}{[\code{factor}]\cr
An optional factor of the same length as the number of observations.
Observations with the same blocking level \dQuote{belong together}.
Specifically, they are either put all in the training or the test set
during a resampling iteration.
Default is \code{NULL} which means no blocking.}

\item{positive}{[\code{character(1)}]\cr
Positive class for binary classification (otherwise ignored and set to NA).
Default is the first factor level of the target attribute.}

\item{fixup.data}{[\code{character(1)}]\cr
Should some basic cleaning up of data be performed?
Currently this means removing empty factor levels for the columns.
Possible coices are:
\dQuote{no} = Don't do it.
\dQuote{warn} = Do it but warn about it.
\dQuote{quiet} = Do it but keep silent.
Default is \dQuote{warn}.}

\item{check.data}{[\code{logical(1)}]\cr
Should sanity of data be checked initially at task creation?
You should have good reasons to turn this off (one might be speed).
Default is \code{TRUE}.}

\item{costs}{[\code{data.frame}]\cr
A numeric matrix or data frame containing the costs of misclassification.
We assume the general case of observation specific costs.
This means we have n rows, corresponding to the observations, in the same order as \code{data}.
The columns correspond to classes and their names are the class labels
(if unnamed we use y1 to yk as labels).
Each entry (i,j) of the matrix specifies the cost of predicting class j
for observation i.}

\item{censoring}{[\code{character(1)}]\cr
Censoring type. Allowed choices are \dQuote{rcens} for right censored data (default),
\dQuote{lcens} for left censored and \dQuote{icens} for interval censored data using
the \dQuote{interval2} format.
See \code{\link[survival]{Surv}} for details.}
}
\value{
[\code{\link{Task}}].
}
\description{
The task encapsulates the data and specifies - through its subclasses -
the type of the task.
It also contains a description object detailing further aspects of the data.

Useful operators are: \code{\link{getTaskFormula}},
\code{\link{getTaskFeatureNames}},
\code{\link{getTaskData}},
\code{\link{getTaskTargets}}, and
\code{\link{subsetTask}}.

Object members:
\describe{
\item{env [\code{environment}]}{Environment where data for the task are stored.
  Use \code{\link{getTaskData}} in order to access it.}
\item{weights [\code{numeric}]}{See argument. \code{NULL} if not present.}
\item{blocking [\code{factor}]}{See argument. \code{NULL} if not present.}
\item{task.desc [\code{\link{TaskDesc}}]}{Encapsulates further information about the task.}
}

Notes:
For multilabel classification we assume that the presence of labels is encoded via logical
columns in \code{data}. The name of the column specifies the name of the label. \code{target}
is then a char vector that points to these columns.
}
\examples{
library(mlbench)
data(BostonHousing)
data(Ionosphere)

makeClassifTask(data = iris, target = "Species")
makeRegrTask(data = BostonHousing, target = "medv")
# an example of a classification task with more than those standard arguments:
blocking = factor(c(rep(1, 51), rep(2, 300)))
makeClassifTask(id = "myIonosphere", data = Ionosphere, target = "Class",
  positive = "good", blocking = blocking)
makeClusterTask(data = iris[, -5L])
}
\seealso{
Other costsens: \code{\link{makeCostSensClassifWrapper}},
  \code{\link{makeCostSensRegrWrapper}},
  \code{\link{makeCostSensWeightedPairsWrapper}}
}

