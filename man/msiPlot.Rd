% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/msiPlot.R
\name{msiPlot}
\alias{msiPlot}
\title{Draw a density (median signal intensity) plot}
\usage{
msiPlot(cfList, markers, byGroup = NULL, byCluster = NULL, ...)
}
\arguments{
\item{cfList}{a cfList object. It should contain at least data in the 'expr' and 'samples' slots.}

\item{markers}{character vector with column names of the markers to be plotted. A numeric vector
is also accepted, note that 1 starts after removing columns 'clusterID' and 'sampleID'.}

\item{byGroup}{a character, referring to a column name in the \code{samples} slot of the \code{cfList}. This will
be used as the grouping for the y-axis.}

\item{byCluster}{character vector specifying which cluster to be plotted. This will be used as
the grouping for the y-axis.}

\item{...}{Additional arguments passed on to \code{\link[ggridges]{geom_density_ridges}}.}
}
\value{
None
}
\description{
Function to plot the density (median signal intensity) for given markers.
}
\examples{
# Read Data
dirFCS <- system.file("extdata", package="cytofast")
cfData <- readCytosploreFCS(dir = dirFCS, colNames = "description")

# relabeling of clusterID
levels(cfData@expr[,"clusterID"]) <- gsub("[^0-9]", "", levels(cfData@expr[,"clusterID"]))  

# Add cell counts to cfList and add meta data
cfData <- cellCounts(cfData, frequency = TRUE, scale = TRUE)
meta <- spitzer[match(row.names(cfData@samples), spitzer$CSPLR_ST),]
cfData@samples <- cbind(cfData@samples, meta)

# Remove unnecessary markers
cfData@expr <- cfData@expr[,-c(3:10, 13:16, 55:59, 61:63)]

# Draw median signal intensity plot, by group
msiPlot(cfData, markers = c("MHC.II", "CD45", "CD4"), byGroup = 'group')

# Or by cluster
msiPlot(cfData, markers = c("MHC.II", "CD45", "CD4"), byCluster = c("1", "6", "10"))


}
\keyword{density}
\keyword{intensity}
\keyword{median}
\keyword{signal}
