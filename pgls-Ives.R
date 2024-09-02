# Load necessary packages
library(ape)
library(caper)
#install.packages("AICcmodavg")
library(AICcmodavg)

# Load phylogenetic tree
anolistree <- read.nexus("poe.tre")
plot(anolistree)  # Visualize the tree to ensure it's loaded correctly


# Load data
anolisdata <- read.csv("DATA.csv", header=TRUE)
head(anolisdata)


# Set row names to species names
rownames(anolisdata) <- anolisdata$Sp
anolisdata


# Check class of relevant columns and convert to numeric if necessary
print(sapply(anolisdata[, c(6, 8, 21, 22, 23)], class))


# # Convert relevant columns to numeric if they are not already
# anolisdata[, c(3, 7, 20, 21)] <- sapply(anolisdata[, c(3, 7, 20, 21)], as.numeric)
# 
# # Remove rows with NAs in the relevant columns
# anolisdata <- anolisdata[complete.cases(anolisdata[, c(3, 7, 20, 21)]), ]

# Prune the tree to match the cleaned data
pruned_anolis <- drop.tip(anolistree, setdiff(anolistree$tip.label, rownames(anolisdata)))
plot(pruned_anolis)  # Visualize pruned tree


# Run pgls.Ives
## X and Y are the variables we're using, and Vx and Vy is the variance for each variable
## Cxy is the error covariance between x and y for each species 
## We can estimated from the with species covariance between x and y for each taxon, divided by the taxon-specific sample size.
## In this example Cxy is 0

# Stimate Cxy for each species in the tree and the data set
Vx = setNames(anolisdata[, 22],rownames(anolisdata))
Vy = setNames(anolisdata[, 21],rownames(anolisdata))

Cxy=sqrt(Vx*Vy)*runif(length(pruned_anolis$tip),min=-1,max=1)

result <- pgls.Ives(pruned_anolis,
                    X = setNames(anolisdata[, 8],rownames(anolisdata)),
                    y = setNames(anolisdata[, 6],rownames(anolisdata)),
                    Vx, Vy,
                    Cxy = setNames(rep(0,length(Cxy5)),rownames(anolisdata)))

result

## Here, we are just vizualizing what we just did
cor1 <- lm(anolisdata[, 8] ~ anolisdata[, 6])
summary(cor1)
plot(anolisdata[, 6], anolisdata[, 8])
abline(a = 4.1, b = -0,1)

## We have to keep in mind that I don't consider this implementation to be super reliable 
## (as indicated in the warning message). Please treat the results with caution!
