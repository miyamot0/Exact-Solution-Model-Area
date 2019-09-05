
plotFrame <- data.frame(
  Delays = c(1,
             30,
             180,
             540,
             1080,
             2160,
             4320,
             8640,
             17280),
  Values = c(1.0,
             0.98,
             0.925,
             0.8,
             0.65,
             0.5,
             0.35,
             0.2,
             0.1)
)

paramK <- 0.000470

# Points
plot(plotFrame$Delays, plotFrame$Values,
     pch = 16,
     cex = 1.5,
     ylim = c(0, 1),
     main = "MB-AUC and PB-AUC Flexibility",
     xlab = "Delay",
     ylab = "Normalized Value",
     log = "x")

# Lines (MBAUC)
projectedDelay <- 1:17280
projectedCurve <- 1 / (1 + paramK * projectedDelay)

plotFrame$Pred <- 1 / (1 + paramK * plotFrame$Delays)

lines(projectedDelay, projectedCurve)

# Lines (MBAUC) - 2
projectedDelayShade <- 1:100
projectedCurveShade <- 1 / (1 + paramK * projectedDelayShade)

polygon(c(1, projectedDelayShade, 100), c(0, projectedCurveShade, 0), border="black", col="lightgray")
lines(projectedDelay, projectedCurve)

# Lines (PBAUC)
lines(plotFrame$Delays, plotFrame$Values, col = "black", lty = 4)
points(plotFrame$Delays, plotFrame$Values, pch = 16, cex = 1.5)

anchorY <- .02

# Lines (PBAUC) - 2
for (i in 1:nrow(plotFrame)) {
  lines(rep(plotFrame[i, "Delays"], 2), c(0, plotFrame[i, "Values"]), col = "black", lty = 4)

  if (i > 1) {
    text(plotFrame[i - 1, "Delays"], anchorY, labels= paste0("S:", i-1), pos=4)
  }
}

legend("topright",
       legend=c("MB-AUC Prediction",
                "PB-AUC Interpolations"),
       col=c("black", "black"),
       inset=.02,
       lty=c(1,4),
       box.lty = 0,
       cex=1)

arrows(3000, .75, 300, .75, col = "black")
text(3000, .749, labels = "Fixed PB-AUC\nSegment", pos=4)

arrows(3000, .6, 10, .6, col = "black")
text(3000, .59, labels = "Custom MB-AUC\nSegment (1-100)", pos=4)
