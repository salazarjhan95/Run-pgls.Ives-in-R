# Run-pgls.Ives-in-R

A few months ago, a reviewer asked me to run an analysis I wasn't aware of at the time: pgls.Ives. This analysis is really useful. pgls.Ives() is a function from the Phytools package (Revell 2012). This function has the advantage of directly incorporating an estimate of intraspecific variance into its parameter estimates. However, a significant drawback is that it assumes the phylogenetic correlation among the residuals follows a Brownian Motion model of evolutionary diversification.

You can find more information here: https://www.rdocumentation.org/packages/phytools/versions/1.5-1/topics/pgls.Ives
And here: http://blog.phytools.org/2017/11/bivariate-phylogenetic-regression-with.html
