
marTest <- 5


# General

delayVector <- seq(0, 365, by = 0.1)

# Reynolds et al.

delays <- c(1, 2, 30, 180, 365)
reynoldsSmokers <- c(0.846916079, 0.750327525,0.22421986, 0.098844224, 0.049121418)
reynoldsNonSmokers <- c(0.952414436, 0.950926694, 0.525856007, 0.098844224, 0.150162097)

# Friedel

friedelSmokers <- 1/((1+3.28*delayVector)^0.3)
friedelNonsmokers <- 1/((1+0.004*delayVector)^3.61)

# Bickel

bickelSmokers <- 1/(1+0.05414*delayVector)
bickelNonsmokers <- 1/(1+0.0073*delayVector)

# Mitchell

mitchellSmokers <- 1/(1+0.012*delayVector)
mitchellNonsmokers <- 1/(1+0.006*delayVector)

# reynoldsCurve

reynoldsCurveSmokers <- 1/(1+0.075*delayVector)
reynoldsCurveNonsmokers <- 1/(1+0.014*delayVector)

#

pointSize <- 2
lineWidth <- 3
lineType <- 3

minX <- 0
maxX <- 400


middleGray <- "#636363"
lightestGray <- "#cccccc"
laststGray <- "#e5e5e5"
endGray <- "#efefef"

xLab <- "Delay (Days)"
yLab <- "Value (Proportional)"

pTitle <- "Combined PB-AUC and Adjusted MB-AUC Measures"



#dev.off()

#setEPS()
#postscript("SavedFigure.eps",
#           fonts = "Times",
#           paper = "special",
#           width = 11,
#           height = 8,
#           horizontal = TRUE,
#           pagecentre = FALSE,
           #paper = "special",
           #bg = "transparent",
#           onefile = TRUE)

#dev.new()

par(family = "Times",
    mar=c(3,3,2,1),
    mgp=c(2,.7,0),
    mfrow = c(1,1),
    tck=-.01)

plot(delays,
     reynoldsSmokers,
     type = 'o',
     col = 'black',
     pch = 15,
     cex = pointSize,
     cex.lab = 1.25,
     cex.axis = 1.25,
     cex.main = 0.1,
     lty = 1,
     lwd = 1.5,
     main = NA,
     family = "Times",
     xlab = xLab,
     ylab = "Normalized Value",
     xlim = c(minX, maxX),
     ylim = c(0, 1.0))

#title(NULL, line=0)

points(delays,
       reynoldsNonSmokers,
       type = 'o',
       col = 'black',
       pch = 22,
       lty = lineType,
       lwd = 1.5,
       cex = pointSize)

lines(delayVector,
      friedelSmokers,
      type = 'l',
      col = "darkgray",
      lwd = 1.5,
      lty = 1)

lines(delayVector,
      friedelNonsmokers,
      type = 'l',
      col = "darkgray",
      lwd = 1.5,
      lty = lineType)

lines(delayVector,
      bickelSmokers,
      type = 'l',
      col = "black",
      lwd = 3,
      lty = 1)

lines(delayVector,
      bickelNonsmokers,
      type = 'l',
      col = "black",
      lwd = 3,
      lty = lineType)

lines(delayVector,
      mitchellSmokers,
      type = 'l',
      col = "darkgray",
      lwd = 3,
      lty = 1)

lines(delayVector,
      mitchellNonsmokers,
      type = 'l',
      col = "darkgray",
      lwd = 3,
      lty = lineType)

lines(delayVector,
      reynoldsCurveSmokers,
      type = 'l',
      col = "black",
      lwd = 5,
      lty = 1)

lines(delayVector,
      reynoldsCurveNonsmokers,
      type = 'l',
      col = "black",
      lwd = 5,
      lty = lineType)

##

points(delays,
       reynoldsSmokers,
       type = 'o',
       col = 'black',
       pch = 15,
       lty = 1,
       lwd = 1.5,
       cex = pointSize)

points(delays,
       reynoldsNonSmokers,
       type = 'o',
       col = 'black',
       pch = 22,
       lty = lineType,
       lwd = 1.5,
       cex = pointSize)

lines(delayVector,
      friedelSmokers,
      type = 'l',
      col = "darkgray",
      lwd = 1.5,
      lty = 1)

lines(delayVector,
      friedelNonsmokers,
      type = 'l',
      col = "darkgray",
      lwd = 1.5,
      lty = lineType)

##

legend(
  "topright",
  bty = "n",
  lty = c(NA,
          1, 1, 1, 1, 1,
          NA, NA,
          lineType, lineType, lineType, lineType, lineType),
  lwd = c(1.5, 1.5, 1.5, 3, 3, 5,
          1.5,
          1.5, 1.5, 1.5, 3, 3, 5),
  text.font = c(2,1,1,1,1,1,1,2,1,1,1,1,1),
  cex = 1.1,
  pt.cex = 1,
  col = c("black",
          "black", "darkgray", "black", "darkgray", "black",
          "black", "black",
          "black", "darkgray", "black", "darkgray", "black"),
  legend = c("Smokers",
             "Reynolds et al. (2007);  PB-AUC = 0.156",
             "Friedel et al. (2014); Myerson-Green MB-AUC = 0.167",
             "Bickel et al. (1999); Mazur MB-AUC = 0.151",
             "Mitchell et al. (1999); Mazur MB-AUC = 0.382",
             "Reynolds et al. (2004); Mazur MB-AUC = 0.119",
             "",
             "Nonsmokers",
             "Reynolds et al. (2007); PB-AUC = 0.323",
             "Friedel et al. (2014); Myerson-Green MB-AUC = 0.235",
             "Bickel et al. (1999); Mazur MB-AUC = 0.486",
             "Mitchell et al. (1999); Mazur MB-AUC = 0.528",
             "Reynolds et al. (2004); Mazur MB-AUC = 0.352")
)

#dev.off()

#dev.copy2eps(file="anotherfile.eps")

#points(delays, reynoldsNonSmokers)
