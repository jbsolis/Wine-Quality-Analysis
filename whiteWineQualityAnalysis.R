#Which chemical properties influence the quality of white wines?

#install.packages('GGally')
install.packages('corrplot')

library(ggplot2)
library(GGally)
library(dplyr)
library(gridExtra)
library(corrplot)



setwd("C:/Users/Jeffrey/Desktop/Data Analysis Coursera/Project 4/Project")

wine <- read.csv('wineQualityWhites.csv')
wine <- wine[2:13] # The first column contained number 1 to 4898.  Ignore
wine$quality <- factor(wine$quality)

wine$quality.cat <- ifelse(wine$quality > 6, "High",
                           ifelse(wine$quality < 6, "Low", "Medium"))

wine$quality.cat <- factor(wine$quality.cat)
wine$quality.cat <- ordered(wine$quality.cat, c("Low","Medium","High"))

summary(wine)

ggplot(aes(x = residual.sugar, y = alcohol), data = wine) + 
    geom_point()  + 
    geom_smooth(method=lm, se=FALSE, fullrange=TRUE) +
    scale_x_log10() +
    scale_y_log10() +
    xlim(0,quantile(wine$residual.sugar,0.95)) +
    facet_wrap(~quality.cat, ncol = 1)


